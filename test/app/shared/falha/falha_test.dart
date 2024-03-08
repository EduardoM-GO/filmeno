import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Falha - Aviso', () {
    final Falha aviso = Aviso(
        mensagemParaUsuario: 'mensagemParaUsuario', tagMetodo: 'tagMetodo');

    expect(aviso, isA<Aviso>());
    expect(aviso.mensagemParaUsuario, equals('mensagemParaUsuario'));
    expect(aviso.tagMetodo, equals('tagMetodo'));
    expect(
        aviso.props,
        equals(Aviso(
                mensagemParaUsuario: 'mensagemParaUsuario',
                tagMetodo: 'tagMetodo')
            .props));
  });
  test('Falha - Erro', () {
    final Exception exception = Exception();
    final StackTrace stackTrace = StackTrace.current;
    final Erro erro = Erro(
        mensagemParaUsuario: 'mensagemParaUsuario',
        exception: exception,
        stack: stackTrace,
        tagMetodo: 'tagMetodo');

    expect(erro, isA<Erro>());
    expect(erro.mensagemParaUsuario, equals('mensagemParaUsuario'));
    expect(erro.exception, equals(exception));
    expect(erro.stack, equals(stackTrace));
    expect(erro.tagMetodo, equals('tagMetodo'));
    expect(
        erro.props,
        equals(Erro(
                mensagemParaUsuario: 'mensagemParaUsuario',
                exception: exception,
                stack: stackTrace,
                tagMetodo: 'tagMetodo')
            .props));
  });
}
