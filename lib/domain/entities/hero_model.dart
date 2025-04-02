class HeroModel {
  final int id;
  final String name;
  final String description;
  final String imageUrl;

  HeroModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  factory HeroModel.fromMap(Map<String, dynamic> map) {
    final thumbnail = map['thumbnail'];
    final path = thumbnail['path'];
    final ext = thumbnail['extension'];

    return HeroModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? 'Sem nome',
      description:
          (map['description'] as String).trim().isEmpty
              ? 'Nenhuma descrição disponível.'
              : map['description'],
      imageUrl: "$path.$ext",
    );
  }
}
