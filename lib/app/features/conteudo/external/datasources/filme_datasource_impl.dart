import 'package:filmeno/app/features/conteudo/domain/entities/conteudo.dart';
import 'package:filmeno/app/features/conteudo/domain/entities/filme.dart';
import 'package:filmeno/app/features/conteudo/infra/datasources/filme_datasource.dart';
import 'package:filmeno/app/shared/external/mapper/mapper.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:filmeno/app/shared/infra/service/cliente_http_service.dart';
import 'package:result_dart/result_dart.dart';

class FilmeDatasourceImpl implements FilmeDatasource {
  final ClienteHttpService _httpService;
  final Mapper<Filme> _mapper;

  FilmeDatasourceImpl(this._httpService, this._mapper);

  @override
  Future<Result<List<Filme>, Falha>> buscarEmCartaz() async {
    try {
      final result =
          await _httpService.getList<Filme>(url: url, mapper: _mapper);
    } catch (exception, stack) {
      return Failure(Erro(
        mensagemParaUsuario:
            'Não foi possível recuperar os filmes em exibição.',
        exception: exception,
        stack: stack,
        tagMetodo: 'FilmeDatasourceImpl-buscarEmCartaz',
      ));
    }
  }

  @override
  Future<Result<List<Filme>, Falha>> buscarMaisBemAvaliados() {
    // TODO: implement buscarMaisBemAvaliados
    throw UnimplementedError();
  }

  @override
  Future<Result<List<Filme>, Falha>> buscarPopulares() {
    // TODO: implement buscarPopulares
    throw UnimplementedError();
  }

  @override
  Future<Result<List<Filme>, Falha>> buscarProximasEstreias() {
    // TODO: implement buscarProximasEstreias
    throw UnimplementedError();
  }
}
