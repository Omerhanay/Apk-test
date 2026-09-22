import 'dart:io';

import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../security/key_store.dart';
import 'database.dart';

/// Opens the encrypted on-device database. The key comes from the Android
/// Keystore-backed [KeyStore] and never touches disk in plaintext.
Future<LifeDatabase> openLifeDatabase(KeyStore keys) async {
  final dir = await getApplicationSupportDirectory();
  final file = File(p.join(dir.path, 'life_os.db'));
  final key = await keys.databaseKey();

  return LifeDatabase(NativeDatabase.createInBackground(
    file,
    setup: (db) {
      // Hex key literal avoids any quoting issues; must run before any other statement.
      db.execute("PRAGMA key = \"x'$key'\"");
      // Fails fast if the key is wrong or the build lacks encryption support.
      db.select('SELECT count(*) FROM sqlite_master');
    },
  ));
}
