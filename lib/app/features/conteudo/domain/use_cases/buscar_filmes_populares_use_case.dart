import 'package:filmeno/app/features/conteudo/domain/entities/filme.dart';
import 'package:filmeno/app/features/conteudo/domain/repositories/filme_repository.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class BuscarFilmesPopularesUseCase {
  Future<Result<List<Filme>, Falha>> call();
}

class BuscarFilmesPopularesUseCaseImpl implements BuscarFilmesPopularesUseCase {
  final FilmeRepository _filmeRepository;

  BuscarFilmesPopularesUseCaseImpl(this._filmeRepository);

  @override
  Future<Result<List<Filme>, Falha>> call() =>
      _filmeRepository.buscarPopulares();
}
