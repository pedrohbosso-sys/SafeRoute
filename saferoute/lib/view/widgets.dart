import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../controller/app_controller.dart';
import '../model/ocorrencia.dart';

const primary = Color(0xFF4C99A6);
const ink = Color(0xFF19343A);
const safe = Color(0xFF10B981);
const danger = Color(0xFFE05252);

Widget card({
  required Widget child,
  EdgeInsets padding = const EdgeInsets.all(16),
}) => Container(
  padding: padding,
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: const [
      BoxShadow(color: Color(0x100A3340), blurRadius: 20, offset: Offset(0, 8)),
    ],
  ),
  child: child,
);

void message(BuildContext context, String value) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
}

String typeLabel(String type) => switch (type) {
  'alagamento' => 'Alagamento',
  'enchente' => 'Enchente',
  'obras' => 'Obras na pista',
  'interdicao' => 'Interdição',
  _ => 'Outro risco',
};

IconData typeIcon(String type) => switch (type) {
  'alagamento' || 'enchente' => Icons.water,
  'obras' => Icons.construction,
  'interdicao' => Icons.block,
  _ => Icons.warning_amber,
};

class RouteMap extends StatelessWidget {
  const RouteMap({super.key, required this.controller, this.onIncident});
  final AppController controller;
  final ValueChanged<Ocorrencia>? onIncident;

  @override
  Widget build(BuildContext context) {
    if (mapboxToken.isEmpty) {
      return Container(
        color: const Color(0xFFE8F1F2),
        child: const Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.map_outlined, size: 64, color: primary),
                  SizedBox(height: 12),
                  Text(
                    'Mapa Mapbox',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ink,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Configure MAPBOX_ACCESS_TOKEN para exibir o mapa e calcular rotas.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    final choice = controller.routes.isNotEmpty
        ? controller.routes[controller.selectedRoute]
        : null;
    return FlutterMap(
      key: ValueKey(
        '${controller.position.latitude}:${controller.destination?.latitude}:${controller.selectedRoute}',
      ),
      options: MapOptions(
        initialCenter: controller.position,
        initialZoom: choice == null ? 13 : 12,
      ),
      children: [
        TileLayer(
          urlTemplate:
              'https://api.mapbox.com/styles/v1/mapbox/streets-v12/tiles/256/{z}/{x}/{y}?access_token=$mapboxToken',
          userAgentPackageName: 'com.saferoute.saferoute',
        ),
        if (choice != null)
          PolylineLayer(
            polylines: [
              Polyline(
                points: choice.points,
                strokeWidth: 6,
                color: choice.safe ? safe : danger,
              ),
            ],
          ),
        MarkerLayer(
          markers: [
            Marker(
              point: controller.position,
              width: 50,
              height: 50,
              child: const Icon(Icons.my_location, color: primary, size: 32),
            ),
            if (controller.destination != null)
              Marker(
                point: controller.destination!,
                width: 50,
                height: 50,
                child: const Icon(Icons.location_on, color: safe, size: 38),
              ),
            ...controller.incidents
                .where((i) => i.local != null)
                .map(
                  (i) => Marker(
                    point: LatLng(i.local!.latitude, i.local!.longitude),
                    width: 50,
                    height: 50,
                    child: IconButton.filled(
                      onPressed: () => onIncident?.call(i),
                      icon: Icon(typeIcon(i.tipo)),
                      style: IconButton.styleFrom(
                        backgroundColor: danger,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ),
          ],
        ),
      ],
    );
  }
}
