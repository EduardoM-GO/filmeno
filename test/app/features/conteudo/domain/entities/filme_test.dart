import 'package:filmeno/app/features/conteudo/domain/entities/filme.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Filme - copyWith', () {
    test('Novo Codigo', () {
      const filme = Filme(
        codigo: '123',
        titulo: 'Filme A',
        urlCapa: '',
        avalicaoUsuario: 0,
        favorito: false,
        assistirMaisTarde: false,
      );
      const novoCodigo = '456';

      final filmeAtualizado = filme.copyWith(codigo: novoCodigo);

      expect(filmeAtualizado.codigo, novoCodigo);
      expect(filmeAtualizado.titulo, filme.titulo);
    });

    test('Sem dados novos', () {
      const filme = Filme(
        codigo: '123',
        titulo: 'Filme A',
        urlCapa: '',
        avalicaoUsuario: 0,
        favorito: false,
        assistirMaisTarde: false,
      );

      final filmeAtualizado = filme.copyWith(codigo: null);

      expect(filmeAtualizado, filme);
    });
  });
}
