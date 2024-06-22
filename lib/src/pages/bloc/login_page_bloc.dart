// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:convert';

import 'package:CurrentMovies/src/utils/common_functions.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:CurrentMovies/src/data/repositories/user_repository.domain.dart';
import 'package:CurrentMovies/src/data/sources/tables/table_user.data.dart';
import 'package:CurrentMovies/src/models/user_model.domain.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class LoginPageBloc extends ChangeNotifier {
  LoginPageBloc({required this.userRepository});

  final UserRepository userRepository;

  UserModel? dataUser;
  bool obscureText = true;
  String username = '';
  String identification = '';
  String name = '';
  String email = '';
  String password = '';
  bool isLoading = false;

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  ConnectivityResult get connectionStatus => _connectionStatus;

  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  void init() async {
    await checkConnectivity();
    prefs.then((value) {
      String? user = value.getString("dataUser");
      if (user != null && user != 'null') {
        UserModel userModel = UserModel.fromJson(jsonDecode(user));
        updateDataUser(userModel);
        notifyListeners();
      }
    });
  }

  Future<void> checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    if (result != _connectionStatus) {
      _connectionStatus = result;
      notifyListeners();
    }
  }

  void updateObscureText() {
    obscureText = !obscureText;
    notifyListeners();
  }

  void updateName(String value) {
    name = value;
    notifyListeners();
  }

  void updateUsername(String value) {
    username = value;
    notifyListeners();
  }

  void updateIdentification(String value) {
    identification = value;
    notifyListeners();
  }

  void updateEmail(String value) {
    email = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    password = value;
    notifyListeners();
  }

  void updateDataUser(UserModel? user) {
    dataUser = user;
    notifyListeners();
  }

  void clearLoginFields() {
    updateUsername("");
    updatePassword("");
  }

  Future<UserModel?> login(String username, String password) async {
    isLoading = true;
    notifyListeners();
    dataUser = await userRepository.login(username, password);
    UserModel? user = await userRepository.updateLastLogin('${dataUser?.id}');
    prefs.then((value) {
      value.setString("dataUser", jsonEncode(user));
    });
    isLoading = false;
    notifyListeners();
    return user;
  }

  Future<UserModel?> getUserByUsername(String id) async {
    return await userRepository.getUserByUsername(id);
  }

  Future<UserModel?> getUserByIdentification(String identification) async {
    UserModel? user =
        await userRepository.getUserByIdentification(identification);
    return user;
  }

  void clearSignupFields() {
    updateName("");
    updateEmail("");
    updateIdentification("");
    updateUsername("");
    updatePassword("");
  }

  Future<UserModel?> signup() async {
    UserModel? existEmail = await userRepository.getUserByEmail(email);
    if (existEmail != null) {
      existEmail.detail = 'El correo ya está registrado';
      return existEmail;
    }

    UserModel? existIdentification =
        await userRepository.getUserByIdentification(identification);

    if (existIdentification != null) {
      existIdentification.detail = 'La identificación ya está registrada';
      return existIdentification;
    }

    UserModel? existUser = await userRepository.getUserByUsername(username);
    if (existUser != null) {
      existUser.detail = 'El usuario ya está registrado';
      return existUser;
    }

    Map<String, dynamic> json = {
      "id": const Uuid().v4().toString(),
      "created_by": null,
      "created_in": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      "modified_by": null,
      "modified_in": null,
      "deleted": null,
      "identification": identification,
      "username": username,
      "password": password,
      "email": email,
      "first_name": name,
      "last_name": null,
      "phone": null,
      "last_login": null,
      "is_superuser": 0,
      "is_active": 1,
    };
    UserTable user = UserTable.fromJson(json);
    UserModel? newUser = await userRepository.setUser(user);
    if (newUser != null) {
      clearSignupFields();
    }
    notifyListeners();
    return newUser;
  }

  void logout() {
    updateDataUser(null);
    CommonFunctions.clearPreferences();
    notifyListeners();
  }
}
