import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/filme_detalhado.dart';
import 'package:filmeno/app/features/conteudo_detalhado/infra/datasources/filme_detalhado_datasource.dart';
import 'package:filmeno/app/shared/domain/entities/configuracao.dart';
import 'package:filmeno/app/shared/external/mapper/mapper.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:filmeno/app/shared/infra/service/cliente_http_service.dart';
import 'package:result_dart/result_dart.dart';

class FilmeDetalhadoDatasourceImpl implements FilmeDetalhadoDatasource {
  final ClienteHttpService _httpService;
  final Mapper<FilmeDetalhado> _mapper;

  FilmeDetalhadoDatasourceImpl(this._httpService, this._mapper);

  @override
  Future<Result<FilmeDetalhado, Falha>> get(String codigo) async {
    try {
      final response = await _httpService.get<FilmeDetalhado>(
        url: '${Configuracao.I.apiUrlBase}/movie/$codigo',
        headers: {'language': 'pt-BR', 'append_to_response': 'watch/providers'},
        mapper: _mapper,
      );

      return Success(response);
    } catch (exception, stack) {
      return Failure(Erro(
        mensagemParaUsuario:
            'Ocorreu um erro ao buscar os detalhes do filme. Por favor, tente novamente.',
        exception: exception,
        stack: stack,
        tagMetodo: 'FilmeDetalhadoDatasourceImpl-get',
      ));
    }
  }
}
