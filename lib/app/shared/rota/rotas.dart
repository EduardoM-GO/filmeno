part of 'go_rotas.dart';

List<GoRota> get rotas => [
      GoRota(
        path: NomeRota.splash.caminho,
        builder: (context, state) => const SplashPage(),
      ),
      GoRota(
        path: NomeRota.home.caminho,
        injector: (getIt) {
          getIt
              .registerFactory<ImagemCache>(() => ImagemCacheImpl(getIt.get()));
          getIt.registerFactory<ImagemDatasource>(
              () => ImagemDatasourceImpl(getIt.get()));
          getIt.registerFactory<ImagemRepository>(
              () => ImagemRepositoryImpl(getIt.get(), getIt.get()));
          getIt.registerFactory<ObterImagemUseCase>(
              () => ObterImagemUseCaseImpl(getIt.get()));

          ///Filmes
          getIt.registerSingleton<Mapper<Filme>>(FilmeMapper());
          getIt.registerFactory<FilmeDatasource>(
              () => FilmeDatasourceImpl(getIt.get(), getIt.get()));
          getIt.registerFactory<FilmeRepository>(
              () => FilmeRepositoryImpl(getIt.get()));
              
          getIt.registerFactory<BuscarFilmesEmCartazUseCase>(
              () => BuscarFilmesEmCartazUseCaseImpl(getIt.get()));
          getIt.registerFactory<BuscarFilmesMelhoresAvalidadosUseCase>(
              () => BuscarFilmesMelhoresAvalidadosUseCaseImpl(getIt.get()));
          getIt.registerFactory<BuscarFilmesPopularesUseCase>(
              () => BuscarFilmesPopularesUseCaseImpl(getIt.get()));
          getIt.registerFactory<BuscarFilmesProximasEstreiasUseCase>(
              () => BuscarFilmesProximasEstreiasUseCaseImpl(getIt.get()));
        },
        builder: (context, state) => const HomePage(),
      ),
    ];
