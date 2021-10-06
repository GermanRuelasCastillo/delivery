import 'dart:convert';

import 'package:delivery/src/api/enviroment.dart';
import 'package:delivery/src/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:delivery/src/models/mercado_pago/mercado_pago_document_type.dart';

class MercadoPagoProvider {
  String _urlMercadoPago = 'api.mercadopago.com';
  final _mercadoPagoCredentials = Enviroment.mercadoPagoCredentials;
  BuildContext? context;
  User? user;
// , User user
  Future? init(BuildContext context) {
    this.context = context;
    // this.user = user;
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
