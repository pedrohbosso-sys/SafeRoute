class Rota {
  const Rota({
    required this.id,
    required this.usuarioId,
    required this.origemLocalId,
    required this.destinoLocalId,
    required this.distanciaKm,
    required this.tempoEstimadoMinutos,
    required this.status,
    this.createdAt,
  });

  final int id;
  final String usuarioId;
  final int origemLocalId;
  final int destinoLocalId;
  final double distanciaKm;
  final int tempoEstimadoMinutos;
  final String status;
  final DateTime? createdAt;

  factory Rota.fromJson(Map<String, dynamic> json) => Rota(
    id: json['id'] as int,
    usuarioId: json['usuario_id'] as String,
    origemLocalId: json['origem_local_id'] as int,
    destinoLocalId: json['destino_local_id'] as int,
    distanciaKm: (json['distancia_km'] as num).toDouble(),
    tempoEstimadoMinutos: json['tempo_estimado_minutos'] as int,
    status: json['status'] as String,
    createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
  );
}
