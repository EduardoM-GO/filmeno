import 'dart:async';

import 'package:isar/isar.dart';

abstract interface class DbHelperService {
  FutureOr<Isar> getInstancia();
}
