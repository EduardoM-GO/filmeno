import 'package:filmeno/app/features/conteudo/domain/entities/filme.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('conteudo - avaliacaoUsuarioFormatada ', () {
    const Filme filme = Filme(
      codigo: '1',
      titulo: 'Filme 1',
      urlCapa: 'url',
      avaliacaoUsuario: 8.80,
      favorito: false,
      assistirMaisTarde: false,
    );

    expect(filme.avaliacaoUsuarioFormatada, '88%');
  });
}
