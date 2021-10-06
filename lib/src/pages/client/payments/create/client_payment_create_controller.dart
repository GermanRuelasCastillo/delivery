// import 'dart:convert';

import 'dart:convert';

import 'package:delivery/src/models/mercado_pago/mercado_pago_card_token.dart';
import 'package:delivery/src/models/mercado_pago/mercado_pago_document_type.dart';
import 'package:delivery/src/models/user.dart';
import 'package:delivery/src/provider/mercado_pago_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:http/http.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class ClientPaymentsCreateController {
  BuildContext? context;
  Function? refresh;
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController documentNumberController = new TextEditingController();

  // DATOS DE TARJETA
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  // MERCADOPAGO MODELS
  List<MercadoPagoDocumentType> documentTypeList = [];
  MercadoPagoProvider _mercadoPagoProvider = new MercadoPagoProvider();
  MercadoPagoCardToken cardToken = new MercadoPagoCardToken();
  User? user;
  String typeDocument = 'DNI';
  String expirationYear = 'Y';
  int expirationMonth = 0;

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    // SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    // user = User.fromJson(
    //     await json.decode(_sharedPref.getString('user').toString()));
    // , user!
    _mercadoPagoProvider.init(context);
    getIdentificationTypes();
  }

  void getIdentificationTypes() async {
    documentTypeList = await _mercadoPagoProvider.getIdentificationTypes();
    refresh!();
  }

  void onCreditCardModelChanged(CreditCardModel creditCardModel) {
    cardNumber = creditCardModel.cardNumber;
    expiryDate = creditCardModel.expiryDate;
    cardHolderName = creditCardModel.cardHolderName;
    cvvCode = creditCardModel.cvvCode;
    isCvvFocused = creditCardModel.isCvvFocused;
    refresh!();
  }

  void createCardToken() async {
    String documentNumber = documentNumberController.text;
    if (cardNumber.isEmpty) {
      snackError('Ingresa el número de la tarjeta');
      return;
    }
    if (expiryDate.isEmpty) {
      snackError('Ingresa la fecha de expiración de la tarjeta');
      return;
    }
    if (cvvCode.isEmpty) {
      snackError('Ingresa el código de la tarjeta');
      return;
    }
    if (cardHolderName.isEmpty) {
      snackError('Ingresa el titular de la tarjeta');
      return;
    }
    if (documentNumber.isEmpty) {
      snackError('Ingresa el número de la documento');
      return;
    }
    if (expiryDate.isNotEmpty) {
      List<String> list = expiryDate.split('/');
      if (list.length == 2) {
        expirationMonth = int.parse(list[0]);
        expirationYear = '20${list[1]}';
      } else {
        snackError('Ingresa el mes y año de expiración');
        return;
      }
    }
    print('MONTO ' + expirationMonth.toString());
    if (cardNumber.isNotEmpty) {
      cardNumber = cardNumber.replaceAll(RegExp(' '), '');
    }
    Response response = await _mercadoPagoProvider.createCardToken(
        cvv: cvvCode,
        expirationYear: expirationYear,
        expirationMonth: expirationMonth,
        cardNumber: cardNumber,
        documentNumber: documentNumber,
        documentId: typeDocument,
        cardHolderName: cardHolderName);

    if (response != null) {
      final data = json.decode(response.body);
      print('DATA ${data}');
      if (response.statusCode == 201) {
        cardToken = new MercadoPagoCardToken.fromJsonMap(data);
        print('cardToken: ${cardToken.toJson()}');
      } else {
        print(' error en tokenizacion');
        print(data);
        int? status = int.tryParse(data['cause'][0]['code'] ?? data['status']);
        String message = data["message"] ?? 'ERROR AL REGISTRAR TARJETA';
        snackError('Código:$status Error:$message');
      }
    }
  }

  void snackError(title) {
    final snackBar = SnackBar(content: Text(title));
    ScaffoldMessenger.of(context!).showSnackBar(snackBar);
  }

  void onCreditCardWidgetChanged(CreditCardBrand creditCardBrand) {}
}
