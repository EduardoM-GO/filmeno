import 'package:filmeno/app/features/conteudo/domain/entities/filme.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class FilmeDatasource {
  Future<Result<List<Filme>, Falha>> buscarPopulares();
  Future<Result<List<Filme>, Falha>> buscarEmCartaz();
  Future<Result<List<Filme>, Falha>> buscarProximasEstreias();
  Future<Result<List<Filme>, Falha>> buscarMaisBemAvaliados();
}
