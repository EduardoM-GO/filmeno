import 'package:filmeno/app/features/conteudo/domain/entities/serie.dart';
import 'package:filmeno/app/features/conteudo/domain/repositories/serie_repository.dart';
import 'package:filmeno/app/features/conteudo/domain/use_cases/obter_imagem_conteudos_use_case.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class BuscarSeriesVaiSerExibidoHojeUseCase {
  Future<Result<List<Serie>, Falha>> call();
}

final class BuscarSeriesVaiSerExibidoHojeUseCaseImpl
    extends ObterImagemConteudosUseCase<Serie>
    implements BuscarSeriesVaiSerExibidoHojeUseCase {
  final SerieRepository _repository;

  BuscarSeriesVaiSerExibidoHojeUseCaseImpl(
    this._repository,
    super.imagemRepository,
  );

  @override
  Future<Result<List<Serie>, Falha>> call() async {
    final result = await _repository.buscarVaiSerExibidoHoje();
    if (result.isError()) {
      return Failure(result.exceptionOrNull()!);
    }

    return getImagemDosConteudos(result.getOrNull()!);
  }
}
