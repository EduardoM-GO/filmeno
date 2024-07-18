class Configuracao {
  static Configuracao? _instance;

  Configuracao._();
  static Configuracao get I => _instance ??= Configuracao._();

  String get apiUrlBase => 'https://api.themoviedb.org/3';
  String get imagemUrlBase => 'https://image.tmdb.org/t/p/original';
  Duration get duracaoAnimacao => const Duration(milliseconds: 500);
  String get apiKey =>
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0YTNjOTQ2ZWE4YzNjMTNjNzZmNDI3NjE4ZTM4NjI4NSIsInN1YiI6IjY0ZjRlNzdjZTBjYTdmMDBjYmU2MWRkMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.QuyZIAfhJ1WQ7CfxQYThx_Po702sIyB8rIT6_kOseRA';
}
