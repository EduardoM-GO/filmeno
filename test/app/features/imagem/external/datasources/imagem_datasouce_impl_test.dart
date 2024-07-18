import 'dart:typed_data';

import 'package:filmeno/app/features/imagem/external/datasources/imagem_datasource_impl.dart';
import 'package:filmeno/app/shared/domain/entities/configuracao.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:filmeno/app/shared/infra/service/cliente_http_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockClienteHttpService extends Mock implements ClienteHttpService {}

void main() {
  late ClienteHttpService service;
  late ImagemDatasourceImpl datasouce;

  setUp(() {
    service = _MockClienteHttpService();
    datasouce = ImagemDatasourceImpl(service);
  });

  group('imagem datasouce impl - buscarImagem -', () {
    late String url;

    setUp(() => url = '/url');
    test('Ok', () async {
      when(
        () => service.getImagem('${Configuracao.I.imagemUrlBase}$url'),
      ).thenAnswer((invocation) async => Uint8List(0));

      final result = await datasouce.buscarImagem(url);

      expect(result.isSuccess(), equals(true));
      expect(result.fold((success) => success, (failure) => failure),
          isA<Uint8List>());
      expect(result.fold((success) => success, (failure) => failure),
          equals(Uint8List(0)));
    });

    test('Erro', () async {
      when(
        () => service.getImagem('${Configuracao.I.imagemUrlBase}$url'),
      ).thenThrow(Exception());

      final result = await datasouce.buscarImagem(url);

      expect(result.isError(), equals(true));
      expect(
          result.fold((success) => success, (failure) => failure), isA<Erro>());
      expect(result.fold((success) => success, (failure) => failure.tagMetodo),
          equals('ImagemDatasouceImpl-buscarImagem'));
    });
  });
}
