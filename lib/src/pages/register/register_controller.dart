import 'package:delivery/src/models/api_response.dart';
import 'package:delivery/src/models/user.dart';
import 'package:delivery/src/provider/users_provider.dart';
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
    String pasword = paswordController.text;
    String confirmarpasword = confirmarpaswordController.text;

    User user = new User(
        id: '1',
        email: email,
        name: nombre,
        lastname: apellidos,
        phone: telefono,
        password: pasword,
        sessionToken: '-',
        image: '-');
    ResponseApi? response = await usersProvider.create(user);

    print('Respuesta:${response!.toJson()}');
  }
}
