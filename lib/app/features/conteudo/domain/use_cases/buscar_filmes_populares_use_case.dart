import 'package:filmeno/app/features/conteudo/domain/entities/filme.dart';
import 'package:filmeno/app/features/conteudo/domain/repositories/filme_repository.dart';
import 'package:filmeno/app/shared/domain/entities/resultado_com_metadados.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class BuscarFilmesPopularesUseCase {
  Future<Result<ResultadoComMetadados<List<Filme>>, Falha>> call(
      {int? proximaPagina});
}

class BuscarFilmesPopularesUseCaseImpl implements BuscarFilmesPopularesUseCase {
  final FilmeRepository _filmeRepository;

  BuscarFilmesPopularesUseCaseImpl(this._filmeRepository);

  @override
  Future<Result<ResultadoComMetadados<List<Filme>>, Falha>> call(
          {int? proximaPagina}) =>
      _filmeRepository.buscarPopulares(proximaPagina: proximaPagina);
}
