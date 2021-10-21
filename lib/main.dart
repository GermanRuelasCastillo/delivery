import 'package:delivery/src/pages/client/address/list/client_address_list_page.dart';
import 'package:delivery/src/pages/client/payments/create/client_payment_create_page.dart';
import 'package:delivery/src/pages/client/payments/installments/client_payment_installments_page.dart';
import 'package:delivery/src/pages/client/products/list/client_products_list_page.dart';
import 'package:delivery/src/pages/login/login_page.dart';
import 'package:delivery/src/pages/register/register_page.dart';
import 'package:delivery/src/utils/my_colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Delivery App Flutter',
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'register': (BuildContext context) => RegisterPage(),
        'client/products/list': (BuildContext context) =>
            ClientProducsListPage(),
        'client/address/list': (BuildContext context) =>
            ClientAddressListPage(),
        'client/payments/create': (BuildContext context) =>
            ClientPaymentCreatePage(),
        'client/payments/installments': (BuildContext context) =>
            ClientPaymentInstallmentsPage(),
      },
      theme: ThemeData(
          fontFamily: 'NimbusSans', primaryColor: MyColors.primaryColor),
    );
  }
}
