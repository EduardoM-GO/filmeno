import 'package:filmeno/app/features/conteudo/domain/entities/filme.dart';
import 'package:filmeno/app/features/conteudo/domain/repositories/filme_repository.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:result_dart/result_dart.dart';

abstract class BuscarFilmesEmCartazUseCase {
  Future<Result<List<Filme>, Falha>> call();
}

class BuscarFilmesEmCartazUseCaseImpl implements BuscarFilmesEmCartazUseCase {
  final FilmeRepository _repository;

  BuscarFilmesEmCartazUseCaseImpl(this._repository);

  @override
  Future<Result<List<Filme>, Falha>> call() => _repository.buscarEmCartaz();
}
