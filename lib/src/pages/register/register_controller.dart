import 'package:delivery/src/models/api_response.dart';
import 'package:delivery/src/models/user.dart';
import 'package:delivery/src/provider/users_provider.dart';
import 'package:delivery/src/utils/my_snackbar.dart';
import 'package:flutter/material.dart';

class RegisterController {
  BuildContext? context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController nombreController = new TextEditingController();
  TextEditingController apellidosController = new TextEditingController();
  TextEditingController telefonoController = new TextEditingController();
  TextEditingController paswordController = new TextEditingController();
  TextEditingController confirmarpaswordController =
      new TextEditingController();

  UsersProvider usersProvider = new UsersProvider();

  Future? init(BuildContext context) {
    this.context = context;
    usersProvider.init(context);
  }

  void register() async {
    String email = emailController.text;
    String nombre = nombreController.text;
    String apellidos = apellidosController.text;
    String telefono = telefonoController.text;
    String password = paswordController.text;
    String confirmarpasword = confirmarpaswordController.text;

    if (email.isEmpty ||
        nombre.isEmpty ||
        apellidos.isEmpty ||
        email.isEmpty ||
        telefono.isEmpty ||
        password.isEmpty ||
        confirmarpasword.isEmpty) {
      MySnackbar.show(context!, 'Debes ingresar todos los datos');
      return;
    }

    if (password.length < 6) {
      MySnackbar.show(context!, 'Contraseña debe contener al menos 6 dígitos');
      return;
    }

    if (confirmarpasword != password) {
      MySnackbar.show(context!, 'Contraseñas no coinciden');
      return;
    }

    User user = new User(
      id: '1',
      email: email,
      name: nombre,
      lastname: apellidos,
      phone: telefono,
      password: password,
      sessionToken: '-',
    );
    ResponseApi? response = await usersProvider.create(user);
    MySnackbar.show(context!, response!.message);
  }

  void back() {
    Navigator.pop(context!);
  }
}
