import 'dart:io';

import 'package:filmeno/app/shared/external/service/db_helper_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

void main() {
  late DbHelperImpl dbHelperImpl;
  setUpAll(() async {
    await Isar.initializeIsarCore(download: true);
  });

  setUp(() {
    dbHelperImpl = DbHelperImpl(Directory(''));
  });

  tearDownAll(() async {
    await Isar.getInstance()?.close(deleteFromDisk: true);
  });

  test('db helper impl - open', () async {
    final result = await dbHelperImpl.open();

    expect(result.isOpen, equals(true));
  });

  group('db helper impl - getInstancia -', () {
    setUp(() async {
      await Isar.getInstance()?.close();
    });

    test('Criar instancia', () async {
      expect(Isar.getInstance() != null, equals(false));

      final result = await dbHelperImpl.getInstancia();

      expect(result.isOpen, equals(true));
      expect(Isar.getInstance() != null, equals(true));
    });

    test('Pegando instancia já criada', () async {
      expect(Isar.getInstance() != null, equals(false));

      final resultInstanciaCriando = await dbHelperImpl.getInstancia();

      expect(resultInstanciaCriando.isOpen, equals(true));
      expect(Isar.getInstance() != null, equals(true));

      final resultInstanciaExitente = await dbHelperImpl.getInstancia();

      expect(resultInstanciaExitente.isOpen, equals(true));
    });
  });
}
