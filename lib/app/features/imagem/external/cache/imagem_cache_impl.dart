import 'dart:async';

import 'package:filmeno/app/features/imagem/domain/entities/imagem.dart';
import 'package:filmeno/app/features/imagem/infra/cache/imagem_cache.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:filmeno/app/shared/infra/service/db_helper_service.dart';
import 'package:isar/isar.dart';
import 'package:result_dart/result_dart.dart';

class ImagemCacheImpl implements ImagemCache {
  final DbHelperService dbHelper;

  ImagemCacheImpl(this.dbHelper);

  @override
  Future<Result<Imagem, Falha>> obterImagem(String url) async {
    try {
      final db = await dbHelper.getInstancia();
      final result = await db.imagems.getByUrl(url);
      final Imagem imagem = result ?? Imagem.empty();
      return Success(imagem);
    } catch (exception, stack) {
      return Failure(Erro(
        mensagemParaUsuario: 'Não foi possível obter a imagem em cache',
        exception: exception,
        stack: stack,
        tagMetodo: 'ImagemCacheImpl-obterImagem',
      ));
    }
  }

  @override
  Future<Result<Unit, Falha>> salvar(Imagem imagem) async {
    try {
      final db = await dbHelper.getInstancia();

      await db.writeTxn(() async {
        await db.imagems.put(imagem);
      });

      return const Success(unit);
    } catch (exception, stack) {
      return Failure(Erro(
        mensagemParaUsuario: 'Não foi possível salvar a imagem em cache',
        exception: exception,
        stack: stack,
        tagMetodo: 'ImagemCacheImpl-salvar',
      ));
    }
  }

  @override
  Future<Result<Unit, Falha>> excluirCacheAntigos() async {
    try {
      final db = await dbHelper.getInstancia();
      await db.writeTxn(() async {
        await db.imagems
            .filter()
            .dataCriacaoLessThan(dataLimiteCacheAntigo)
            .deleteAll();
      });
      return const Success(unit);
    } catch (exception, stack) {
      return Failure(Erro(
        mensagemParaUsuario: 'Não foi possível excluir os caches antigos',
        exception: exception,
        stack: stack,
        tagMetodo: 'ImagemCacheImpl-excluirCacheAntigos',
      ));
    }
  }

  DateTime get dataLimiteCacheAntigo {
    final dataAtual = DateTime.now();
    final DateTime data =
        DateTime(dataAtual.year, dataAtual.month, dataAtual.day)
            .subtract(const Duration(days: 7));

    return data;
  }
}
