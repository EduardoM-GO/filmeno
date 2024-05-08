import 'package:filmeno/app/features/conteudo/domain/entities/serie.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class SerieRepository {
  Future<Result<List<Serie>, Falha>> buscarPopular();
  Future<Result<List<Serie>, Falha>> buscarMelhoresAvaliados();
  Future<Result<List<Serie>, Falha>> buscarVaiSerExibidoHoje();
  Future<Result<List<Serie>, Falha>> buscarVaiSerExibidoNaSemana();
}
