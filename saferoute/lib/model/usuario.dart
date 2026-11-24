class Usuario {
  const Usuario({
    required this.id,
    required this.nome,
    required this.email,
    this.endereco,
    this.cargo,
    this.createdAt,
  });

  final String id;
  final String nome;
  final String email;
  final String? endereco;
  final String? cargo;
  final DateTime? createdAt;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
    id: json['id'] as String,
    nome: json['nome'] as String? ?? '',
    email: json['email'] as String? ?? '',
    endereco: json['endereco'] as String?,
    cargo: json['cargo'] as String?,
    createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
  );
}
