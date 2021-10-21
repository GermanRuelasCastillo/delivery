import 'dart:convert';

import 'package:delivery/src/models/api_response.dart';
import 'package:delivery/src/models/user.dart';
import 'package:delivery/src/provider/users_provider.dart';
import 'package:delivery/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class LoginController {
  BuildContext? context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController paswordController = new TextEditingController();
  UsersProvider usersProvider = new UsersProvider();
  SharedPref _sharedPref = new SharedPref();

  Future? init(BuildContext context) async {
    this.context = context;
    await usersProvider.init(context);

    User user = User.fromJson(await _sharedPref.read('user') ?? {});
    print(user.sessionToken);
    if (user.sessionToken != 'null') {
      Navigator.pushNamedAndRemoveUntil(
          context, 'client/products/list', (route) => false);
    }
  }

  void goToRegisterPage() {
    Navigator.pushNamed(context!, 'register');
  }

  void login() async {
    try {
      String email = emailController.text.trim();
      String password = paswordController.text.trim();
      ResponseApi responseApi =
          await usersProvider.login(email, password) as ResponseApi;
      if (responseApi.success) {
        Map<String, dynamic> userTemp = jsonDecode(responseApi.data);
        User user = User.fromJson(userTemp);
        print(user.toJson());
        _sharedPref.save('user', user.toJson());
        Navigator.pushNamedAndRemoveUntil(
            context!, 'client/products/list', (route) => false);
      } else {
        snackError(responseApi.message);
      }
    } catch (e) {
      print(e.toString());
      snackError(e.toString());
    }

    // Navigator.pushNamed(context!, 'client/payments/create');
  }

  void snackError(title) {
    final snackBar = SnackBar(content: Text(title));
    ScaffoldMessenger.of(context!).showSnackBar(snackBar);
  }
}
