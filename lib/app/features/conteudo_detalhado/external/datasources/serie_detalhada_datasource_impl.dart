import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/serie_detalhada.dart';
import 'package:filmeno/app/features/conteudo_detalhado/infra/datasources/serie_detalhada_datasource.dart';
import 'package:filmeno/app/shared/domain/entities/configuracao.dart';
import 'package:filmeno/app/shared/external/mapper/mapper.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:filmeno/app/shared/infra/service/cliente_http_service.dart';
import 'package:result_dart/result_dart.dart';

class SerieDetalhadaDatasourceImpl implements SerieDetalhadaDatasource {
  final ClienteHttpService _httpService;
  final Mapper<SerieDetalhada> _mapper;

  SerieDetalhadaDatasourceImpl(this._httpService, this._mapper);

  @override
  Future<Result<SerieDetalhada, Falha>> get(String codigo) async {
    try {
      final response = await _httpService.get<SerieDetalhada>(
        url: '${Configuracao.I.apiUrlBase}/tv/$codigo',
        headers: {
          'language': 'pt-BR',
          'append_to_response': 'release_dates,watch/providers,content_ratings'
        },
        mapper: _mapper,
      );

      return Success(response);
    } catch (exception, stack) {
      return Failure(Erro(
        mensagemParaUsuario:
            'Ocorreu um erro ao buscar os detalhes da série. Por favor, tente novamente.',
        exception: exception,
        stack: stack,
        tagMetodo: 'SerieDetalhadaDatasourceImpl-get',
      ));
    }
  }
}
