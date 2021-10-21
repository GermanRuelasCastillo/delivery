import 'package:delivery/src/pages/register/register_controller.dart';
import 'package:delivery/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class RegisterPage extends StatefulWidget {
  // Register({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterController _rCon = RegisterController();
  @override
  void initState() {
    super.initState();
    // Esto se correra despues de mostrado todo en pantalla
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _rCon.init(context);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: -80,
              left: -100,
              child: _circleLogin(),
            ),
            Positioned(
              top: 65,
              left: 28,
              child: _textRegister(),
            ),
            Positioned(
              top: 50,
              left: -5,
              child: _iconBack(),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 150),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _imageUserProfile(),
                    SizedBox(height: 30),
                    _textField('Correo electrónico', Icons.email,
                        _rCon.emailController, TextInputType.emailAddress),
                    _textField('Nombre', Icons.person, _rCon.nombreController,
                        TextInputType.text),
                    _textField('Apellidos', Icons.person_outline,
                        _rCon.apellidosController, TextInputType.text),
                    _textField('Teléfono', Icons.phone,
                        _rCon.telefonoController, TextInputType.phone),
                    _textField('Contraseña', Icons.lock,
                        _rCon.paswordController, TextInputType.text),
                    _textField('Confirmar Contraseña', Icons.lock_outline,
                        _rCon.confirmarpaswordController, TextInputType.text),
                    _buttonRegister()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _imageUserProfile() {
    return CircleAvatar(
      radius: 60,
      backgroundColor: Colors.grey[200],
      backgroundImage: AssetImage('assets/img/user_profile_2.png'),
    );
  }

  Widget _circleLogin() {
    return Container(
      width: 240,
      height: 230,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: MyColors.primaryColor),
    );
  }

  Widget _textField(hint, icon, controller, ktype) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        keyboardType: ktype,
        controller: controller,
        obscureText: (hint == 'Contraseña' || hint == 'Confirmar Contraseña')
            ? true
            : false,
        decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryDark),
            prefixIcon: Icon(icon, color: MyColors.primaryColor)),
      ),
    );
  }

  Widget _buttonRegister() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: ElevatedButton(
        onPressed: _rCon.register,
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.symmetric(vertical: 15)),
        child: Text('Registrarse'),
      ),
    );
  }

  Widget _textRegister() {
    return Text('REGISTRO',
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'NimbusSans',
            fontSize: 16));
  }

  Widget _iconBack() {
    return IconButton(
        onPressed: _rCon.back,
        icon: Icon(Icons.arrow_back_ios, color: Colors.white));
  }
}
