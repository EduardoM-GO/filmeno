import 'package:filmeno/app/shared/domain/entities/metadados.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('metadados - proximaPagina', () {
    const paginaAtual = 1;
    const quantidadePaginaTotal = 10;
    const metadados = Metadados(
        paginaAtual: paginaAtual, quantidadePaginaTotal: quantidadePaginaTotal);

    final proximaPagina = metadados.proximaPagina;

    expect(proximaPagina, equals(2));
  });

  group('metadados - temProximaPagina', () {
    test('true', () {
      const paginaAtual = 1;
      const quantidadePaginaTotal = 10;
      const metadados = Metadados(
          paginaAtual: paginaAtual,
          quantidadePaginaTotal: quantidadePaginaTotal);

      final temProximaPagina = metadados.temProximaPagina;

      expect(temProximaPagina, isTrue);
    });

    test('false', () {
      const paginaAtual = 10;
      const quantidadePaginaTotal = 10;
      const metadados = Metadados(
          paginaAtual: paginaAtual,
          quantidadePaginaTotal: quantidadePaginaTotal);

      final temProximaPagina = metadados.temProximaPagina;

      expect(temProximaPagina, isFalse);
    });
  });
}
