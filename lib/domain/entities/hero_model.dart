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

    final id = map['id'] ?? 0;
    final name = map['name'] ?? 'No name';

    final rawDescription = map['description'];
    final description =
        (rawDescription is String && rawDescription.trim().isNotEmpty)
            ? rawDescription
            : 'Not have description';

    return HeroModel(
      id: id,
      name: name,
      description: description,
      imageUrl: "$path.$ext",
    );
  }
}
