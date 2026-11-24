import 'local.dart';

class Ocorrencia {
  const Ocorrencia({
    required this.id,
    required this.usuarioId,
    required this.localId,
    required this.tipo,
    required this.descricao,
    required this.dataOcorrencia,
    required this.validade,
    required this.status,
    this.gravidade = 1,
    this.fotoUrl,
    this.confirmadas = 0,
    this.contestadas = 0,
    this.local,
    this.createdAt,
  });

  final int id;
  final String usuarioId;
  final int localId;
  final String tipo;
  final String descricao;
  final DateTime dataOcorrencia;
  final DateTime validade;
  final String status;
  final int gravidade;
  final String? fotoUrl;
  final int confirmadas;
  final int contestadas;
  final Local? local;
  final DateTime? createdAt;

  bool get ativa => status == 'ativa' && validade.isAfter(DateTime.now());

  factory Ocorrencia.fromJson(Map<String, dynamic> json) => Ocorrencia(
    id: json['id'] as int,
    usuarioId: json['usuario_id'] as String,
    localId: json['local_id'] as int,
    tipo: json['tipo'] as String,
    descricao: json['descricao'] as String? ?? '',
    dataOcorrencia: DateTime.parse(json['data_ocorrencia'] as String),
    validade: DateTime.parse(json['validade'] as String),
    status: json['status'] as String,
    gravidade: json['gravidade'] as int? ?? 1,
    fotoUrl: json['foto_url'] as String?,
    confirmadas: (json['confirmacao'] as List? ?? [])
        .where((value) => (value as Map)['confirmada'] == true)
        .length,
    contestadas: (json['confirmacao'] as List? ?? [])
        .where((value) => (value as Map)['confirmada'] == false)
        .length,
    local: json['local'] is Map<String, dynamic>
        ? Local.fromJson(json['local'] as Map<String, dynamic>)
        : null,
    createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
  );
}
