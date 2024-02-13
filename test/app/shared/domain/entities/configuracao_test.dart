import 'package:filmeno/app/shared/domain/entities/configuracao.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Configuracao configuracao;

  setUp(() => configuracao = Configuracao.instance);

  test('configuracao - apiUrlBase', () {
    final result = configuracao.apiUrlBase;

    expect(result.isNotEmpty, equals(true));
    expect(result, equals('https://api.themoviedb.org/3'));
  });

  test('configuracao - imagemUrlBase', () {
    final result = configuracao.imagemUrlBase;

    expect(result.isNotEmpty, equals(true));
    expect(result, equals('https://image.tmdb.org/t/p/original'));
  });
  test('configuracao - duracaoAnimacao', () {
    final result = configuracao.duracaoAnimacao;

    expect(result, equals(const Duration(milliseconds: 500)));
  });
}
