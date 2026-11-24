class HistoricoOcorrencias {
  const HistoricoOcorrencias({
    required this.id,
    required this.localId,
    required this.quantidadeTotal,
    required this.quantidadeConfirmadas,
    required this.quantidadeContestadas,
    this.ultimaOcorrencia,
    this.descricao,
    required this.dataAtualizacao,
  });

  final int id;
  final int localId;
  final int quantidadeTotal;
  final int quantidadeConfirmadas;
  final int quantidadeContestadas;
  final DateTime? ultimaOcorrencia;
  final String? descricao;
  final DateTime dataAtualizacao;

  factory HistoricoOcorrencias.fromJson(Map<String, dynamic> json) =>
      HistoricoOcorrencias(
        id: json['id'] as int,
        localId: json['local_id'] as int,
        quantidadeTotal: json['quantidade_total'] as int,
        quantidadeConfirmadas: json['quantidade_confirmadas'] as int,
        quantidadeContestadas: json['quantidade_contestadas'] as int,
        ultimaOcorrencia: DateTime.tryParse(
          json['ultima_ocorrencia']?.toString() ?? '',
        ),
        descricao: json['descricao'] as String?,
        dataAtualizacao: DateTime.parse(json['data_atualizacao'] as String),
      );
}
