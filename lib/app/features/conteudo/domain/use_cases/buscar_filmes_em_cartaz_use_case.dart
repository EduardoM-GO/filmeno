import 'package:filmeno/app/features/conteudo/domain/entities/filme.dart';
import 'package:filmeno/app/features/conteudo/domain/repositories/filme_repository.dart';
import 'package:filmeno/app/shared/domain/entities/resultado_com_metadados.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:result_dart/result_dart.dart';

abstract class BuscarFilmesEmCartazUseCase {
  Future<Result<ResultadoComMetadados<List<Filme>>, Falha>> call(
      {int? proximaPagina});
}

class BuscarFilmesEmCartazUseCaseImpl implements BuscarFilmesEmCartazUseCase {
  final FilmeRepository _repository;

  BuscarFilmesEmCartazUseCaseImpl(this._repository);

  @override
  Future<Result<ResultadoComMetadados<List<Filme>>, Falha>> call(
          {int? proximaPagina}) =>
      _repository.buscarEmCartaz(proximaPagina: proximaPagina);
}
