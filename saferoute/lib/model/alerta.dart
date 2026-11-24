class Alerta {
  const Alerta({
    required this.id,
    required this.rotaId,
    required this.usuarioId,
    this.ocorrenciaId,
    required this.descricao,
    required this.dataAlerta,
  });

  final int id;
  final int rotaId;
  final String usuarioId;
  final int? ocorrenciaId;
  final String descricao;
  final DateTime dataAlerta;

  factory Alerta.fromJson(Map<String, dynamic> json) => Alerta(
    id: json['id'] as int,
    rotaId: json['rota_id'] as int,
    usuarioId: json['usuario_id'] as String,
    ocorrenciaId: json['ocorrencia_id'] as int?,
    descricao: json['descricao'] as String,
    dataAlerta: DateTime.parse(json['data_alerta'] as String),
  );
}
