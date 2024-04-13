import 'package:filmeno/app/shared/rota/nome_rota.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('nome rota - toString', () {
    const nomeRota = NomeRota.splash;
    expect(nomeRota.toString(), equals('/'));
  });
}
