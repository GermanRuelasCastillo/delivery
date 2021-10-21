import 'package:delivery/src/models/product.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientOrdersCreateController {
  BuildContext? context;
  Function? refresh;

  // Product product;

  int counter = 1;
  double productPrice = 0;

  List<Producto> selectedProducts = [];
  double total = 0;

// async
  Function? init(BuildContext context, Function refresh) {
    this.context = context;
    this.refresh = refresh;

    // SharedPreferences _sharedPref = await SharedPreferences.getInstance();

    // selectedproducts = Product.fromJsonList(await _sharedPref.getString('order').toString()).toList();

    getTotal();
    refresh();
  }

  void getTotal() {
    total = 0;
    selectedProducts.forEach((product) {
      total = total + (product.quantity * product.price);
    });
    refresh!();
  }
}
