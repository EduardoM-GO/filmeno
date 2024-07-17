mixin GenerosMapperMixin {
  List<String> getGeneros(Map<String, dynamic> map) {
    if (!map.containsKey('genres')) {
      return [];
    }

    final List<dynamic> results = map['genres'];

    final List<String> generos = results
        .cast<Map<String, dynamic>>()
        .map((e) => e['name'].toString())
        .toList();

    return generos;
  }
}
