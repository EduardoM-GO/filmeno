import 'dart:async';
import 'dart:io';

import 'package:filmeno/app/features/imagem/domain/entities/imagem.dart';
import 'package:filmeno/app/shared/infra/service/db_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

class DbHelperImpl implements DbHelper {
  final Directory diretorio;

  DbHelperImpl(this.diretorio);

  @override
  FutureOr<Isar> getInstancia() {
    final Isar? isar = Isar.getInstance();

    if (isar != null) {
      return isar;
    }

    return open();
  }

  @visibleForTesting
  Future<Isar> open() async {
    final Isar isar = await Isar.open(
      [ImagemSchema],
      directory: diretorio.path,
    );
    return isar;
  }
}
