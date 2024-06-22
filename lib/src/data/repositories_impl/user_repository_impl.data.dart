import 'dart:math';

import 'package:CurrentMovies/src/data/repositories/user_repository.domain.dart';
import 'package:CurrentMovies/src/data/sources/daos/user_dao.data.dart';
import 'package:CurrentMovies/src/data/sources/tables/table_user.data.dart';
import 'package:CurrentMovies/src/models/user_model.domain.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDAO dataBase;
  UserRepositoryImpl(this.dataBase);
  @override
  getAllUsers() {
    return dataBase.getAllUsers();
  }

  @override
  Future<UserModel?> setUser(UserTable dataToInsert) {
    return dataBase.insert(dataToInsert);
  }

  @override
  delete(String id) {
    return dataBase.delete(id);
  }

  @override
  login(String identification, String password) {
    return dataBase.login(identification, password);
  }

  @override
  Future<UserModel?> getUserByIdentification(String identification) {
    return dataBase.getUserBy(UserTable.columnIdentification, identification);
  }

  @override
  Future<UserModel?> getUserByUsername(String username) {
    return dataBase.getUserBy(UserTable.columnUsername, username);
  }

  @override
  Future<UserModel?> getUserByEmail(String email) {
    return dataBase.getUserBy(UserTable.columnEmail, email);
  }

  @override
  Future<UserModel?> updateLastLogin(String id) {
    return dataBase.updateLastLogin(id);
  }

  @override
  Future<UserModel?> update(UserTable user) {
    return dataBase.update(user);
  }
}
