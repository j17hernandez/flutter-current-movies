import 'package:CurrentMovies/src/models/user_model.domain.dart';

class UserTable {
  static String tableName = 'user';
  static String columnId = 'id';
  static String columncreatedIn = 'created_in';
  static String columnDeleted = 'deleted';
  static String columnIdentification = 'identification';
  static String columnUsername = 'username';
  static String columnPassword = 'password';
  static String columnEmail = "email";
  static String columnFirstName = "first_name";
  static String columnLastName = "last_name";
  static String columnLastLogin = "last_login";
  static String columnIsActive = "is_active";

  late String? id;
  late String createdIn;
  late String? modifiedIn;
  late String? deleted;
  late String identification;
  late String username;
  late String password;
  late String email;
  late String? firstName;
  late String? lastName;
  late String? lastLogin;
  late int? isActive;

  Map<String, dynamic> toJson() => {
        columnId: id,
        columncreatedIn: createdIn,
        columnDeleted: deleted,
        columnIdentification: identification,
        columnUsername: username,
        columnPassword: password,
        columnEmail: email,
        columnFirstName: firstName,
        columnLastName: lastName,
        columnLastLogin: lastLogin,
        columnIsActive: isActive,
      };

  static List<UserTable> fromJsonList(List<dynamic> json) =>
      json.map((i) => UserTable.fromJson(i)).toList();

  UserTable.fromJson(Map<String, dynamic> json) {
    id = json[columnId];
    createdIn = json[columncreatedIn];
    deleted = json[columnDeleted];
    identification = json[columnIdentification];
    username = json[columnUsername];
    password = json[columnPassword];
    email = json[columnEmail];
    firstName = json[columnFirstName];
    lastName = json[columnLastName];
    lastLogin = json[columnLastLogin];
    isActive = json[columnIsActive];
  }

  static String create() {
    return """CREATE TABLE IF NOT EXISTS '$tableName'(
    $columnId TEXT PRIMARY KEY NOT NULL,
    $columncreatedIn TEXT NOT NULL,
    $columnDeleted TEXT,
    $columnIdentification TEXT NOT NULL UNIQUE,
    $columnUsername TEXT NOT NULL UNIQUE,
    $columnPassword TEXT,
    $columnEmail TEXT NOT NULL UNIQUE,
    $columnFirstName TEXT,
    $columnLastName TEXT,
    $columnLastLogin TEXT,
    $columnIsActive INTEGER NOT NULL CHECK ($columnIsActive IN (0, 1))
    )""";
  }

  static List<UserModel> toModel(List<Map<String, dynamic>> json) =>
      json.map((i) => UserModel.fromJson(i)).toList();
}
