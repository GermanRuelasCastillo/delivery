import 'package:flutter/material.dart';

class ClientAddressListController {
  BuildContext? context;
  Function? refresh;

  Future? init(BuildContext context, Function? refresh) {
    this.context = context;
    this.refresh = refresh;
  }

  void createOrder() async {
    Navigator.pushNamed(context!, 'client/payments/create');
  }
}
