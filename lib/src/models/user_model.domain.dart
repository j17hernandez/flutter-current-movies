// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? id;
  String createdIn;
  String? modifiedIn;
  String? deleted;
  String identification;
  String username;
  String password;
  String email;
  String? firstName;
  String? lastName;
  String? lastLogin;
  int? isActive;
  String? detail;

  UserModel({
    this.id,
    required this.createdIn,
    this.modifiedIn,
    this.deleted,
    required this.identification,
    required this.username,
    required this.password,
    required this.email,
    this.firstName,
    this.lastName,
    this.lastLogin,
    this.isActive,
    this.detail,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        createdIn: json["created_in"],
        modifiedIn: json["modified_in"],
        deleted: json["deleted"],
        identification: json['identification'],
        username: json['username'],
        password: json['password'],
        email: json['email'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        lastLogin: json['last_login'],
        isActive: json["is_active"],
        detail: json['detail'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_in": createdIn,
        "modified_in": modifiedIn,
        "deleted": deleted,
        "identification": identification,
        "username": username,
        "password": password,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "last_login": lastLogin,
        "is_active": isActive,
        "detail": detail,
      };
}
