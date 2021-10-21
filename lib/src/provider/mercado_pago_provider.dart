import 'dart:convert';

import 'package:delivery/src/api/enviroment.dart';
import 'package:delivery/src/models/mercado_pago/mercado_pago_payment_method_installments.dart';
import 'package:delivery/src/models/user.dart';
import 'package:delivery/src/models/order.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:delivery/src/models/mercado_pago/mercado_pago_document_type.dart';

class MercadoPagoProvider {
  String _urlMercadoPago = 'api.mercadopago.com';
  String _url = Enviroment.API_DELIVERY;
  final _mercadoPagoCredentials = Enviroment.mercadoPagoCredentials;
  BuildContext? context;
  User? user;
// , User user
  Future? init(BuildContext context) {
    this.context = context;
    // this.user = user;
  }

  Future<MercadoPagoPaymentMethodInstallments> getInstallments(
      String bin, double amount) async {
    try {
      final url =
          Uri.https(_urlMercadoPago, '/v1/payment_methods/installments', {
        'access_token': _mercadoPagoCredentials.accessToken,
        'bin': bin,
        'amount': amount.toString(),
      });

      final res = await http.get(url);
      final data = json.decode(res.body);
      final result =
          new MercadoPagoPaymentMethodInstallments.fromJsonList(data);
      return result.installmentList.first;
    } catch (e) {
      return MercadoPagoPaymentMethodInstallments();
    }
  }

  Future<List<MercadoPagoDocumentType>> getIdentificationTypes() async {
    try {
      final url = Uri.https(_urlMercadoPago, '/v1/identification_types', {
        'access_token': _mercadoPagoCredentials.accessToken,
      });

      final res = await http.get(url);
      final data = json.decode(res.body);
      final result = new MercadoPagoDocumentType.fromJsonList(data);
      return result.documentTypeList;
    } catch (e) {
      return [];
    }
  }

  Future<http.Response> createPayment({
    required String cardId,
    required double transactionAmount,
    required int installments,
    required String paymentMethodId,
    required String paymentTypeId,
    required String issuerId,
    required String emailCustomer,
    required String cardToken,
    required String identificationType,
    required String identificationNumber,
    required Order order,
  }) {
    final url = Uri.http(_url, '/api/payments/createPay', {
      '/api/payments/createPay': _mercadoPagoCredentials.accessToken,
    });

    Map<String, dynamic> body = {
      'description': 'Flutter delivery payment',
      'transaction_amount': transactionAmount,
      'installments': installments,
      'payment_method_id': paymentMethodId,
      'token': cardToken,
      'payer': {
        'email': emailCustomer,
        'identification': {
          'type': identificationType,
          'number': identificationNumber,
        }
      }
    };

    String bodyParams = json.encode(body);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': user!.sessionToken
    };
    return http.post(url, headers: headers, body: bodyParams);
  }

  Future<Response> createCardToken(
      {required String cvv,
      required String expirationYear,
      required int expirationMonth,
      required String cardNumber,
      required String documentNumber,
      required String documentId,
      required String cardHolderName}) async {
    try {
      final url = Uri.https(_urlMercadoPago, '/v1/card_tokens', {
        'public_key': _mercadoPagoCredentials.publicKey,
      });
      final body = {
        'security_code': cvv,
        'expiration_year': expirationYear,
        'expiration_month': expirationMonth,
        'card_number': cardNumber,
        'card_holder': {
          'number': documentNumber,
          'type': documentId,
        },
        'name': cardHolderName
      };

      final res = await http.post(url, body: json.encode(body));
      return res;
    } catch (e) {
      return Response('Error', 500);
    }
  }
}
