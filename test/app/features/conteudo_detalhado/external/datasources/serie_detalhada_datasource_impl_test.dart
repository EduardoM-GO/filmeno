import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/serie_detalhada.dart';
import 'package:filmeno/app/features/conteudo_detalhado/external/datasources/serie_detalhada_datasource_impl.dart';
import 'package:filmeno/app/features/conteudo_detalhado/external/mapper/serie_detalhada_mapper.dart';
import 'package:filmeno/app/shared/domain/entities/configuracao.dart';
import 'package:filmeno/app/shared/external/mapper/mapper.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:filmeno/app/shared/infra/service/cliente_http_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockClienteHttpService extends Mock implements ClienteHttpService {}

void main() {
  late ClienteHttpService httpService;
  late Mapper<SerieDetalhada> mapper;
  late SerieDetalhadaDatasourceImpl datasource;

  setUp(() {
    httpService = _MockClienteHttpService();
    mapper = SerieDetalhadaMapper();
    datasource = SerieDetalhadaDatasourceImpl(httpService, mapper);
  });

  group('serie detalhada datasource impl - get -', () {
    late String codigo;

    setUp(() {
      codigo = '1';
    });

    test('Ok', () async {
      final serieDetalhada = SerieDetalhada(
        codigo: codigo,
        titulo: '',
        urlCapa: '',
        avaliacaoUsuario: 0,
        favorito: false,
        assistirMaisTarde: false,
        faixaEtaria: '',
        dataLancamento: DateTime.now(),
        quantidadeDeEpisodios: 1,
        quantidadeDeTemporada: 1,
        generos: const [],
        sinopse: '',
        plataformas: const [],
      );

      when(() => httpService.get<SerieDetalhada>(
            url: '${Configuracao.I.apiUrlBase}/tv/$codigo',
            headers: {
              'language': 'pt-BR',
              'append_to_response':
                  'release_dates,watch/providers,content_ratings'
            },
            mapper: mapper,
          )).thenAnswer((_) async => serieDetalhada);

      final result = await datasource.get(codigo);

      expect(result.isSuccess(), isTrue);
      expect(result.getOrNull(), equals(serieDetalhada));
    });

    test('Erro', () async {
      when(() => httpService.get<SerieDetalhada>(
            url: '${Configuracao.I.apiUrlBase}/tv/$codigo',
            headers: {
              'language': 'pt-BR',
              'append_to_response':
                  'release_dates,watch/providers,content_ratings'
            },
            mapper: mapper,
          )).thenThrow(Exception());

      final result = await datasource.get(codigo);

      expect(result.isError(), isTrue);
      expect(result.fold((s) => s, (e) => e), isA<Erro>());
      expect(result.fold((s) => s, (e) => e.tagMetodo),
          equals('SerieDetalhadaDatasourceImpl-get'));
    });
  });
}
