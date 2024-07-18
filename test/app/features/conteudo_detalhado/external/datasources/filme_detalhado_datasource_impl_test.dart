import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/filme_detalhado.dart';
import 'package:filmeno/app/features/conteudo_detalhado/external/datasources/filme_detalhado_datasource_impl.dart';
import 'package:filmeno/app/features/conteudo_detalhado/external/mapper/filme_detalhado_mapper.dart';
import 'package:filmeno/app/shared/domain/entities/configuracao.dart';
import 'package:filmeno/app/shared/external/mapper/mapper.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:filmeno/app/shared/infra/service/cliente_http_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockClienteHttpService extends Mock implements ClienteHttpService {}

void main() {
  late ClienteHttpService httpService;
  late Mapper<FilmeDetalhado> mapper;
  late FilmeDetalhadoDatasourceImpl datasource;

  setUp(() {
    httpService = _MockClienteHttpService();
    mapper = FilmeDetalhadoMapper();
    datasource = FilmeDetalhadoDatasourceImpl(httpService, mapper);
  });

  group('filme detalhado datasource impl - get -', () {
    late String codigo;

    setUp(() {
      codigo = '1';
    });

    test('Ok', () async {
      final filmeDetalhado = FilmeDetalhado(
        codigo: codigo,
        titulo: '',
        urlCapa: '',
        avaliacaoUsuario: 0,
        favorito: false,
        assistirMaisTarde: false,
        faixaEtaria: '',
        duracao: Duration.zero,
        dataLancamento: DateTime.now(),
        generos: const [],
        sinopse: '',
        plataformas: const [],
      );

      when(() => httpService.get<FilmeDetalhado>(
            url: '${Configuracao.I.apiUrlBase}/movie/$codigo',
            headers: {
              'language': 'pt-BR',
              'append_to_response': 'watch/providers'
            },
            mapper: mapper,
          )).thenAnswer((_) async => filmeDetalhado);

      final result = await datasource.get(codigo);

      expect(result.isSuccess(), isTrue);
      expect(result.getOrNull(), equals(filmeDetalhado));
    });

    test('Erro', () async {
      when(() => httpService.get<FilmeDetalhado>(
            url: '${Configuracao.I.apiUrlBase}/movie/$codigo',
            headers: {
              'language': 'pt-BR',
              'append_to_response': 'watch/providers'
            },
            mapper: mapper,
          )).thenThrow(Exception());

      final result = await datasource.get(codigo);

      expect(result.isError(), isTrue);
      expect(result.fold((s) => s, (e) => e), isA<Erro>());
      expect(result.fold((s) => s, (e) => e.tagMetodo),
          equals('FilmeDetalhadoDatasourceImpl-get'));
    });
  });
}
