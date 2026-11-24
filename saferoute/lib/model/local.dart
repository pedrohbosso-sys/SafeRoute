class Local {
  const Local({
    required this.id,
    required this.endereco,
    required this.latitude,
    required this.longitude,
    this.createdAt,
  });

  final int id;
  final String endereco;
  final double latitude;
  final double longitude;
  final DateTime? createdAt;

  factory Local.fromJson(Map<String, dynamic> json) => Local(
    id: json['id'] as int,
    endereco: json['endereco'] as String? ?? '',
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
    createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
  );
}
