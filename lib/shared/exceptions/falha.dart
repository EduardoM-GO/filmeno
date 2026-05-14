sealed class Falha {
  final String mensagem;
  Falha(this.mensagem);
}

final class FalhaRede extends Falha {
  FalhaRede([String? msg]) : super(msg ?? 'Erro de conexão com o servidor.');
}

final class FalhaServidor extends Falha {
  final int? statusCode;
  FalhaServidor({this.statusCode, String? msg})
      : super(msg ?? 'Erro interno do servidor ($statusCode).');
}

final class FalhaDesconhecida extends Falha {
  FalhaDesconhecida([String? msg]) : super(msg ?? 'Ocorreu um erro inesperado.');
}
