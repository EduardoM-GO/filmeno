import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sembast/sembast_io.dart';

part 'sembast_provider.g.dart';

@Riverpod(keepAlive: true)
Future<Database> sembastDatabase(Ref ref) async {
  final appDir = await getApplicationDocumentsDirectory();
  await appDir.create(recursive: true);
  final dbPath = join(appDir.path, 'filmeno.db');

  return databaseFactoryIo.openDatabase(dbPath);
}
