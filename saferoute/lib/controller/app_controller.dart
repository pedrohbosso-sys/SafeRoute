import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/ocorrencia.dart';

const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
const supabaseKey = String.fromEnvironment('SUPABASE_ANON_KEY');
const mapboxToken = String.fromEnvironment('MAPBOX_ACCESS_TOKEN');

class RouteChoice {
  const RouteChoice({
    required this.points,
    required this.km,
    required this.minutes,
    required this.safe,
  });
  final List<LatLng> points;
  final double km;
  final int minutes;
  final bool safe;
}

class AppController extends ChangeNotifier {
  AppController(this.client);
  final SupabaseClient? client;
  static const fallback = LatLng(-22.7371, -47.3331);

  LatLng position = fallback;
  bool locationAvailable = false;
  LatLng? destination;
  String destinationName = '';
  List<Ocorrencia> incidents = [];
  List<RouteChoice> routes = [];
  bool busy = false;
  String? error;
  int selectedRoute = 0;
  bool navigating = false;
  StreamSubscription<Position>? _positionSubscription;
  int? _savedRouteId;

  bool get authenticated => client?.auth.currentUser != null;
  String? get userId => client?.auth.currentUser?.id;
  bool get configured => client != null;

  Future<void> start() async {
    await locate();
    await loadIncidents();
  }

  Future<void> locate() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) return;
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return;
      }
      final value = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      position = LatLng(value.latitude, value.longitude);
      locationAvailable = true;
      notifyListeners();
    } catch (_) {
      // The map remains usable around the initial service area.
    }
  }

  Future<void> signIn(String email, String password) async {
    if (client == null) throw StateError('Configure o Supabase para entrar.');
    await client!.auth.signInWithPassword(email: email, password: password);
    notifyListeners();
    await loadIncidents();
  }

  Future<void> signUp(String name, String email, String password) async {
    if (client == null) {
      throw StateError('Configure o Supabase para cadastrar.');
    }
    await client!.auth.signUp(
      email: email,
      password: password,
      data: {'nome': name},
    );
    notifyListeners();
  }

  Future<void> resetPassword(String email) async {
    if (client == null) {
      throw StateError('Configure o Supabase para recuperar a senha.');
    }
    await client!.auth.resetPasswordForEmail(email);
  }

  Future<void> signOut() async {
    await client?.auth.signOut();
    notifyListeners();
  }

  Future<void> loadIncidents() async {
    if (client == null) return;
    try {
      final data = await client!
          .from('ocorrencia')
          .select('*, local(*), confirmacao(confirmada)')
          .eq('status', 'ativa')
          .gt('validade', DateTime.now().toUtc().toIso8601String())
          .order('data_ocorrencia', ascending: false);
      incidents = (data as List)
          .map((row) => Ocorrencia.fromJson(row as Map<String, dynamic>))
          .toList();
      error = null;
    } catch (e) {
      error = 'Não foi possível carregar as ocorrências: $e';
    }
    notifyListeners();
  }

  Future<bool> report({
    required String type,
    required String description,
    required LatLng point,
    required int severity,
    Uint8List? photoBytes,
  }) async {
    if (!authenticated) throw StateError('Entre para publicar ocorrências.');
    if (!locationAvailable && point == fallback) {
      throw StateError(
        'Ative o GPS ou ajuste as coordenadas antes de publicar.',
      );
    }
    final now = DateTime.now().toUtc();
    final local = await client!
        .from('local')
        .insert({
          'endereco':
              '${point.latitude.toStringAsFixed(5)}, ${point.longitude.toStringAsFixed(5)}',
          'latitude': point.latitude,
          'longitude': point.longitude,
        })
        .select('id')
        .single();
    final occurrence = await client!
        .from('ocorrencia')
        .insert({
          'usuario_id': userId,
          'local_id': local['id'],
          'tipo': type,
          'descricao': description,
          'gravidade': severity,
          'data_ocorrencia': now.toIso8601String(),
          'validade': now
              .add(Duration(hours: severity == 3 ? 4 : 2))
              .toIso8601String(),
          'status': 'ativa',
        })
        .select('id')
        .single();
    var photoSaved = true;
    if (photoBytes != null) {
      try {
        final path = '$userId/${occurrence['id']}.jpg';
        await client!.storage
            .from('incident-photos')
            .uploadBinary(
              path,
              photoBytes,
              fileOptions: const FileOptions(contentType: 'image/jpeg'),
            );
        final url = client!.storage.from('incident-photos').getPublicUrl(path);
        await client!
            .from('ocorrencia')
            .update({'foto_url': url})
            .eq('id', occurrence['id']);
      } catch (_) {
        photoSaved = false;
      }
    }
    await loadIncidents();
    return photoSaved;
  }

  Future<void> confirm(Ocorrencia incident, bool exists) async {
    if (!authenticated) throw StateError('Entre para confirmar ocorrências.');
    if (incident.usuarioId == userId) {
      throw StateError('Você não pode confirmar sua própria ocorrência.');
    }
    await client!.from('confirmacao').upsert({
      'ocorrencia_id': incident.id,
      'usuario_id': userId,
      'confirmada': exists,
      'data_confirmacao': DateTime.now().toUtc().toIso8601String(),
    }, onConflict: 'ocorrencia_id,usuario_id');
    await loadIncidents();
  }

  Future<void> searchDestination(String query) async {
    if (mapboxToken.isEmpty) {
      throw StateError(
        'Configure MAPBOX_ACCESS_TOKEN para pesquisar destinos.',
      );
    }
    final uri = Uri.https(
      'api.mapbox.com',
      '/geocoding/v5/mapbox.places/${Uri.encodeComponent(query)}.json',
      {
        'access_token': mapboxToken,
        'language': 'pt',
        'limit': '1',
        'proximity': '${position.longitude},${position.latitude}',
      },
    );
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw StateError('Falha na busca de destino.');
    }
    final features =
        (jsonDecode(response.body) as Map<String, dynamic>)['features'] as List;
    if (features.isEmpty) throw StateError('Destino não encontrado.');
    final feature = features.first as Map<String, dynamic>;
    final center = feature['center'] as List;
    destination = LatLng(
      (center[1] as num).toDouble(),
      (center[0] as num).toDouble(),
    );
    destinationName = feature['place_name'] as String;
    notifyListeners();
    await calculateRoutes();
  }

  Future<void> calculateRoutes() async {
    final target = destination;
    if (target == null || mapboxToken.isEmpty) return;
    busy = true;
    error = null;
    notifyListeners();
    try {
      final uri = Uri.https(
        'api.mapbox.com',
        '/directions/v5/mapbox/driving/${position.longitude},${position.latitude};${target.longitude},${target.latitude}',
        {
          'access_token': mapboxToken,
          'alternatives': 'true',
          'geometries': 'geojson',
          'overview': 'full',
          'steps': 'false',
        },
      );
      final response = await http.get(uri);
      if (response.statusCode != 200) {
        throw StateError('Serviço de rotas indisponível.');
      }
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final results = (data['routes'] as List).cast<Map<String, dynamic>>();
      routes =
          results.map((item) {
            final geometry = item['geometry'] as Map<String, dynamic>;
            final coordinates = (geometry['coordinates'] as List).cast<List>();
            final points = coordinates
                .map(
                  (p) => LatLng(
                    (p[1] as num).toDouble(),
                    (p[0] as num).toDouble(),
                  ),
                )
                .toList();
            return RouteChoice(
              points: points,
              km: (item['distance'] as num).toDouble() / 1000,
              minutes: ((item['duration'] as num).toDouble() / 60).round(),
              safe: !_crossesIncident(points),
            );
          }).toList()..sort((a, b) {
            if (a.safe != b.safe) return a.safe ? -1 : 1;
            return a.minutes.compareTo(b.minutes);
          });
      selectedRoute = 0;
      if (routes.isEmpty) error = 'Nenhuma rota encontrada para esse destino.';
    } catch (e) {
      error = e.toString();
    } finally {
      busy = false;
      notifyListeners();
    }
  }

  bool _crossesIncident(List<LatLng> points) {
    return incidents.where((item) => item.ativa && item.local != null).any((
      item,
    ) {
      final point = LatLng(item.local!.latitude, item.local!.longitude);
      for (var i = 1; i < points.length; i++) {
        if (_distanceToSegment(point, points[i - 1], points[i]) < 80) {
          return true;
        }
      }
      return points.length == 1 &&
          const Distance().as(LengthUnit.Meter, point, points.first) < 80;
    });
  }

  double _distanceToSegment(LatLng point, LatLng a, LatLng b) {
    final scaleX = 111320 * math.cos(point.latitude * math.pi / 180);
    const scaleY = 111320.0;
    final ax = (a.longitude - point.longitude) * scaleX;
    final ay = (a.latitude - point.latitude) * scaleY;
    final bx = (b.longitude - point.longitude) * scaleX;
    final by = (b.latitude - point.latitude) * scaleY;
    final lengthSquared = (bx - ax) * (bx - ax) + (by - ay) * (by - ay);
    if (lengthSquared == 0) return math.sqrt(ax * ax + ay * ay);
    final t = (-(ax * (bx - ax) + ay * (by - ay)) / lengthSquared).clamp(
      0.0,
      1.0,
    );
    final dx = ax + t * (bx - ax);
    final dy = ay + t * (by - ay);
    return math.sqrt(dx * dx + dy * dy);
  }

  void chooseRoute(int index) {
    selectedRoute = index;
    notifyListeners();
  }

  Future<void> startNavigation() async {
    if (routes.isEmpty || !routes[selectedRoute].safe) {
      throw StateError('Nenhuma rota segura disponível.');
    }
    await locate();
    if (!locationAvailable) {
      throw StateError('Permita o acesso ao GPS para acompanhar sua rota.');
    }
    if (authenticated && destination != null) {
      try {
        final origin = await client!
            .from('local')
            .insert({
              'endereco': 'Origem GPS',
              'latitude': position.latitude,
              'longitude': position.longitude,
            })
            .select('id')
            .single();
        final target = await client!
            .from('local')
            .insert({
              'endereco': destinationName,
              'latitude': destination!.latitude,
              'longitude': destination!.longitude,
            })
            .select('id')
            .single();
        final selected = routes[selectedRoute];
        final saved = await client!
            .from('rota')
            .insert({
              'usuario_id': userId,
              'origem_local_id': origin['id'],
              'destino_local_id': target['id'],
              'distancia_km': selected.km,
              'tempo_estimado_minutos': selected.minutes,
              'status': 'em_andamento',
            })
            .select('id')
            .single();
        _savedRouteId = saved['id'] as int;
      } catch (e) {
        error = 'Rota iniciada, mas não foi salva no histórico: $e';
      }
    }
    await _positionSubscription?.cancel();
    _positionSubscription =
        Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 20,
          ),
        ).listen((value) {
          position = LatLng(value.latitude, value.longitude);
          locationAvailable = true;
          notifyListeners();
        });
    navigating = true;
    notifyListeners();
  }

  Future<void> stopNavigation() async {
    await _positionSubscription?.cancel();
    _positionSubscription = null;
    navigating = false;
    if (_savedRouteId != null && client != null) {
      try {
        await client!
            .from('rota')
            .update({'status': 'concluida'})
            .eq('id', _savedRouteId!);
      } catch (_) {
        /* Keep local navigation usable. */
      }
      _savedRouteId = null;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _positionSubscription?.cancel();
    super.dispose();
  }
}
