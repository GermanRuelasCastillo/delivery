import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:delivery/src/api/enviroment.dart';
import 'package:delivery/src/models/api_response.dart';
import 'package:delivery/src/models/user.dart';
import 'package:flutter/material.dart';

class UsersProvider {
  String _url = Enviroment.API_DELIVERY;
  String _api = '/api/users';
  BuildContext? context;

  Future? init(BuildContext context) {
    this.context = context;
  }

  Future<ResponseApi>? create(User user) async {
    try {
      Uri uri = Uri.http(_url, '$_api/create');
      print(uri);
      String bodyParams = json.encode(user);

      final res = await http.post(uri, headers: _setHeader(), body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi responseApi = new ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print(e);
      final data = {
        'success': false,
        'error': e.toString(),
        'message': e.toString()
      };
      ResponseApi responseApi = new ResponseApi.fromJson(data);
      return responseApi;
    }
  }

  Future<ResponseApi>? login(String email, String password) async {
    try {
      Uri uri = Uri.http(_url, '$_api/login');
      print(uri);
      String bodyParams = json.encode({
        'email': email,
        'password': password,
      });
      final res = await http.post(uri, headers: _setHeader(), body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi responseApi = new ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      final data = {
        'success': false,
        'error': e.toString(),
        'message': e.toString()
      };
      ResponseApi responseApi = new ResponseApi.fromJson(data);
      return responseApi;
    }
  }
  _setHeader() => {
        'Content-type': 'application/json',
      };
}
