import 'dart:developer';

sealed class Falha {
  final String mensagem;
  Falha({required this.mensagem, Object? erro, StackTrace? stack}) {
    log(mensagem, error: erro, stackTrace: stack);
  }
}

final class FalhaRede extends Falha {
  FalhaRede({required String? msg, required super.erro, super.stack})
      : super(mensagem: msg ?? 'Erro de conexão com o servidor.');
}

final class FalhaServidor extends Falha {
  final int? statusCode;
  FalhaServidor({this.statusCode, String? msg, super.erro, super.stack})
      : super(mensagem: msg ?? 'Erro interno do servidor ($statusCode).');
}

final class FalhaNoBancoDeDados extends Falha {
  FalhaNoBancoDeDados({String? msg, required super.erro, super.stack})
      : super(mensagem: msg ?? 'Ocorreu um erro ao acessar o banco de dados.');
}

final class FalhaDesconhecida extends Falha {
  FalhaDesconhecida({String? msg, required super.erro, super.stack})
      : super(mensagem: msg ?? 'Ocorreu um erro inesperado.');
}
