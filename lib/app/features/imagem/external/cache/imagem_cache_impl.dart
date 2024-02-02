import 'dart:async';
import 'dart:io';

import 'package:filmeno/app/features/imagem/domain/entities/imagem.dart';
import 'package:filmeno/app/features/imagem/infra/cache/imagem_cache.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:isar/isar.dart';
import 'package:result_dart/result_dart.dart';

class ImagemCacheImpl implements ImagemCache {
  final Directory diretorio;

  ImagemCacheImpl(this.diretorio);

  @override
  Future<Result<Imagem, Falha>> obterImagem(String url) async {
    try {
      final isar = await getInstancia();
      final result = await isar.imagems.getByUrl(url);
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
      final isar = await getInstancia();

      await isar.writeTxn(() async {
        await isar.imagems.put(imagem);
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
      final dataMaximaCache = DateTime.now().subtract(const Duration(days: 7));
      final isar = await getInstancia();
      await isar.writeTxn(() async {
        await isar.imagems
            .filter()
            .dataCriacaoLessThan(dataMaximaCache)
            .deleteAll();
      });
      return const Success(unit);
    } catch (exception, stack) {
      return Failure(Erro(
        mensagemParaUsuario: 'Não foi possível excluir o cache antigo',
        exception: exception,
        stack: stack,
        tagMetodo: 'ImagemCacheImpl-excluirCacheAntigos',
      ));
    }
  }

  Isar? _isar;

  FutureOr<Isar> getInstancia() async {
    if (_isar?.isOpen ?? false) {
      return _isar!;
    }
    _isar = await Isar.open(
      [ImagemSchema],
      directory: diretorio.path,
    );

    return _isar!;
  }
}
