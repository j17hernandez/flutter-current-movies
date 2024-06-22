import 'dart:async';

import 'package:intl/intl.dart';
import 'package:CurrentMovies/src/data/sources/db_config.dart';
import 'package:CurrentMovies/src/data/sources/tables/table_user.data.dart';
import 'package:CurrentMovies/src/models/user_model.domain.dart';
// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart';

class UserDAO {
  Database? _db;
  Completer<Database>? _dbCompleter;

  UserDAO() {
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    if (_dbCompleter == null) {
      _dbCompleter = Completer<Database>();
      _db = await DbConfig().database;
      _dbCompleter!.complete(_db);
    }
  }

  Future<UserModel?> insert(UserTable user) async {
    try {
      await _db!.insert(UserTable.tableName, user.toJson());
      return await getUserById(user.id);
    } catch (error) {
      throw "Error al insertar el usuario en la base de datos";
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    if (_dbCompleter == null) {
      throw Exception("La base de datos no está inicializada.");
    }
    // Espera a que la inicialización se complete si es necesario
    _db = await _dbCompleter!.future;

    List<UserModel> list = [];
    List<Map<String, dynamic>> maps = await _db!.query(UserTable.tableName,
        where: '${UserTable.columnDeleted} IS NULL');
    if (maps.isNotEmpty) list = UserTable.toModel(maps);
    return list;
  }

  Future<UserModel?> getUserById(String? id) async {
    List<Map<String, dynamic>> maps = await _db!.query(UserTable.tableName,
        where: '${UserTable.columnId} = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      UserTable userTable = UserTable.fromJson(maps.first);
      return UserModel.fromJson(userTable.toJson());
    }

    return null;
  }

  Future<UserModel?> getUserByIdentification(String? identification) async {
    List<Map<String, dynamic>> maps = await _db!.query(UserTable.tableName,
        where: '${UserTable.columnIdentification} = ?',
        whereArgs: [identification]);

    if (maps.isNotEmpty) {
      UserTable userTable = UserTable.fromJson(maps.first);
      return UserModel.fromJson(userTable.toJson());
    }

    return null;
  }

  Future<UserModel?> getUserBy(String columnName, String value) async {
    List<Map<String, dynamic>> maps = await _db!.query(UserTable.tableName,
        where: '$columnName = ?', whereArgs: [value]);

    if (maps.isNotEmpty) {
      UserTable userTable = UserTable.fromJson(maps.first);
      return UserModel.fromJson(userTable.toJson());
    }
    return null;
  }

  Future<int> delete(String id) async => await _db!.update(
      UserTable.tableName,
      {
        UserTable.columnDeleted:
            DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
      },
      where: '${UserTable.columnId} = ?',
      whereArgs: [id]);

  Future<UserModel?> update(UserTable user) async {
    await _db!.update(UserTable.tableName, user.toJson(),
        where: '${UserTable.columnId} = ?', whereArgs: [user.id]);
    return getUserById(user.id);
  }

  Future<UserModel?> updateLastLogin(String? id) async {
    final newLastLogin =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    await _db?.update(
      UserTable.tableName,
      {UserTable.columnLastLogin: newLastLogin},
      where: 'id = ?',
      whereArgs: [id],
    );
    return getUserById(id);
  }

  Future<UserModel?> login(String identification, String password) async {
    List<Map<String, dynamic>> maps = await _db!.query(UserTable.tableName,
        where:
            '${UserTable.columnUsername} = ? AND ${UserTable.columnPassword} = ?',
        whereArgs: [identification, password]);

    if (maps.isNotEmpty) {
      UserTable userTable = UserTable.fromJson(maps.first);
      if (userTable.lastLogin != null) {
        return updateLastLogin(userTable.id);
      }

      return UserModel.fromJson(userTable.toJson());
    }

    return null;
  }

  Future close() async => _db!.close();
}
