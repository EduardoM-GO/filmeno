import 'dart:io';

import 'package:filmeno/app/features/imagem/components/imagem_conteudo/widgets/imagem_widget.dart';
import 'package:filmeno/app/features/imagem/domain/entities/imagem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('imagem widget - empty', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ImagemWidget(
        imagem: Imagem.empty(),
        avaliacaoUsuario: 0.0,
      ),
    ));
    expect(find.byType(Placeholder), findsNWidgets(1));
    expect(find.byType(Image), findsNWidgets(0));
  });

  testWidgets('imagem widget - Com imagem', (tester) async {
    final imagemByte = File('diagrama_entidades.png').readAsBytesSync();
    await tester.pumpWidget(MaterialApp(
      home: ImagemWidget(
          imagem: Imagem(
            dataCriacao: DateTime.now(),
            url: '1234',
            imagem: imagemByte,
          ),
          avaliacaoUsuario: 0.0),
    ));
    expect(find.byType(Placeholder), findsNWidgets(0));
    expect(find.byType(Image), findsNWidgets(1));
  });
}
