import 'dart:typed_data';

import 'package:filmeno/app/features/imagem/domain/entities/imagem.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('imagem - imagem', () {
    final imagem = Imagem(
      dataCriacao: DateTime(0),
      url: '',
      imagem: const [1, 2],
    );

    expect(imagem.imagem.isNotEmpty, isTrue);
    expect(imagem.imagem, equals(Uint8List.fromList([1, 2])));
  });
}
