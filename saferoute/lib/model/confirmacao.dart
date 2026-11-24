class Confirmacao {
  const Confirmacao({
    required this.id,
    required this.ocorrenciaId,
    required this.usuarioId,
    required this.confirmada,
    this.descricao,
    required this.dataConfirmacao,
  });

  final int id;
  final int ocorrenciaId;
  final String usuarioId;
  final bool confirmada;
  final String? descricao;
  final DateTime dataConfirmacao;

  factory Confirmacao.fromJson(Map<String, dynamic> json) => Confirmacao(
    id: json['id'] as int,
    ocorrenciaId: json['ocorrencia_id'] as int,
    usuarioId: json['usuario_id'] as String,
    confirmada: json['confirmada'] as bool,
    descricao: json['descricao'] as String?,
    dataConfirmacao: DateTime.parse(json['data_confirmacao'] as String),
  );
}
