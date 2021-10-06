import 'package:flutter/material.dart';

class LoginController {
  BuildContext? context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController paswordController = new TextEditingController();

  Future? init(BuildContext context) {
    this.context = context;
  }

  void goToRegisterPage() {
    Navigator.pushNamed(context!, 'register');
  }

  void login() {
    // String email = emailController.text.trim();
    // String password = paswordController.text.trim();
    Navigator.pushNamed(context!, 'client/payments/create');
  }
}
