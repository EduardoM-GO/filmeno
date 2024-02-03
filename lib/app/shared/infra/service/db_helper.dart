import 'dart:async';

import 'package:isar/isar.dart';

abstract interface class DbHelper {
  FutureOr<Isar> getInstancia();
}
