class Configuracao {
  static Configuracao? _instance;

  Configuracao._();
  static Configuracao get instance => _instance ??= Configuracao._();

  String get apiUrlBase => 'https://api.themoviedb.org/3';
  String get imagemUrlBase => 'https://image.tmdb.org/t/p/original';
  Duration get duracaoAnimacao => const Duration(milliseconds: 500);
}
