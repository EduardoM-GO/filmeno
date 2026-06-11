class MovieGender {
  final int id;
  final String name;

  MovieGender({required this.id, required this.name});

  factory MovieGender.fromMap(Map<String, dynamic> map) {
    return MovieGender(id: map['id'] ?? 0, name: map['name'] ?? '');
  }
}
