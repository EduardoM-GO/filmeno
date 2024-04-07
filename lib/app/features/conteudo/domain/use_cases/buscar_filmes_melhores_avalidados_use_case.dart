import 'package:filmeno/app/features/conteudo/domain/entities/filme.dart';
import 'package:filmeno/app/features/conteudo/domain/repositories/filme_repository.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:result_dart/result_dart.dart';

abstract class BuscarFilmesMelhoresAvalidadosUseCase {
  Future<Result<List<Filme>, Falha>> call();
}

class BuscarFilmesMelhoresAvalidadosUseCaseImpl
    implements BuscarFilmesMelhoresAvalidadosUseCase {
  final FilmeRepository _repository;

  BuscarFilmesMelhoresAvalidadosUseCaseImpl(this._repository);

  @override
  Future<Result<List<Filme>, Falha>> call() =>
      _repository.buscarMelhoresAvalidados();
}
