import 'package:CurrentMovies/src/data/sources/tables/table_user.data.dart';
import 'package:CurrentMovies/src/models/user_model.domain.dart';

abstract class UserRepository {
  getAllUsers();
  Future<UserModel?> getUserByUsername(String username);
  setUser(UserTable dataToInsert);
  delete(String id);
  login(String identification, String password);
  Future<UserModel?> getUserByIdentification(String identification);
  Future<UserModel?> getUserByEmail(String email);
  Future<UserModel?> updateLastLogin(String id);
  Future<UserModel?> update(UserTable user);
}
