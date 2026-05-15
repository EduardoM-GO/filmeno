final class WatchProvider {
  final String name;
  final String logoPath;

  WatchProvider({required this.name, required this.logoPath});

  factory WatchProvider.fromMap(Map<String, dynamic> map) {
    return WatchProvider(
      name: map['provider_name'] ?? '',
      logoPath: map['logo_path'] ?? '',
    );
  }
}
