import 'package:filmeno/app/features/conteudo/domain/entities/filme.dart';
import 'package:filmeno/app/features/conteudo/domain/repositories/filme_repository.dart';
import 'package:filmeno/app/features/conteudo/domain/use_cases/obter_imagem_conteudos_use_case.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:result_dart/result_dart.dart';

abstract class BuscarFilmesProximasEstreiasUseCase {
  Future<Result<List<Filme>, Falha>> call();
}

final class BuscarFilmesProximasEstreiasUseCaseImpl
    extends ObterImagemConteudosUseCase<Filme>
    implements BuscarFilmesProximasEstreiasUseCase {
  final FilmeRepository _repository;

  BuscarFilmesProximasEstreiasUseCaseImpl(
      this._repository, super.imagemRepository);

  @override
  Future<Result<List<Filme>, Falha>> call() async {
    final result = await _repository.buscarProximasEstreias();
    if (result.isError()) {
      return Failure(result.exceptionOrNull()!);
    }

    return getImagemDosConteudos(result.getOrNull()!);
  }
}
