import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:CurrentMovies/src/data/sources/tables/table_user.data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbConfig {
  static final DbConfig _instance = DbConfig._internal();

  factory DbConfig() => _instance;

  bool isInit = true;

  DbConfig._internal();

  late Database _database;

  /// Retorna la instancia de la base de datos, si no existe la inicializa
  Future<Database> get database async {
    if (!isInit) {
      return _database;
    }
    _database = await initDatabase();
    isInit = false;
    return _database;
  }

  static Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'database_movies.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(UserTable.create());
    });
  }
}
