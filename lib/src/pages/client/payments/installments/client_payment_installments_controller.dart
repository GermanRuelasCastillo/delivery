// import 'dart:convert';

import 'dart:convert';

import 'package:delivery/src/models/mercado_pago/mercado_pago_card_token.dart';
import 'package:delivery/src/models/mercado_pago/mercado_pago_document_type.dart';
import 'package:delivery/src/models/mercado_pago/mercado_pago_installment.dart';
import 'package:delivery/src/models/mercado_pago/mercado_pago_issuer.dart';
import 'package:delivery/src/models/mercado_pago/mercado_pago_payment_method_installments.dart';
import 'package:delivery/src/models/product.dart';
import 'package:delivery/src/models/user.dart';
import 'package:delivery/src/provider/mercado_pago_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:http/http.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class ClientPaymentsInstallmentsController {
  BuildContext? context;
  Function? refresh;

  // MERCADOPAGO MODELS
  MercadoPagoProvider _mercadoPagoProvider = new MercadoPagoProvider();
  MercadoPagoCardToken cardToken = new MercadoPagoCardToken();
  User? user;
  List<Producto> selectedProducts = [];
  double totalPayment = 10;
  MercadoPagoPaymentMethodInstallments installments =
      new MercadoPagoPaymentMethodInstallments();
  List<MercadoPagoInstallment> installmentList = [];
  MercadoPagoIssuer issuer = new MercadoPagoIssuer();
  String selectedInstallment = '1';

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    cardToken = MercadoPagoCardToken.fromJsonMap(arguments);
    // selectedProducts = Producto.fromJsonList(await _sharedPref.getString('order').toString()).toList();
    _mercadoPagoProvider.init(context);
    // getTotalPayment();
    getInstallments();
    refresh();
  }

  void getInstallments() async {
    installments = await _mercadoPagoProvider.getInstallments(
        cardToken.firstSixDigits, totalPayment);
    installmentList = installments.payerCosts;
    issuer = installments.issuer;
    refresh!();
  }

  void getTotalPayment() {
    selectedProducts.forEach((producto) {
      totalPayment = totalPayment + (producto.quantity * producto.price);
    });
    refresh!();
  }
}
