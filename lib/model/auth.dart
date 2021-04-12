import 'dart:convert';

import 'package:alibyo_qr_scanner/model/http_exception.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/widgets.dart';

class Auth {
  // String _token;
  // DateTime _expiryDate;
  // String _userId;
  bool isLogin = false;

  Future<void> login(String username, String password) async {
    //isLogin = false;
    var url = Uri.parse('https://192.168.137.1/api/auth/login');
    try {
      final response = await http.post(url,
          body: json.encode(
            {
              "username": username,
              "password": password,
              //'returnSecureToken': true,
            },
          ),
          headers: {'Content-type': 'application/json'});
      print(json.decode(response.body));
      //final responseData = json.decode(response.body);
      //var token = responseData['idToken'];
      if (200 == response.statusCode) {
        //return responseData;

        isLogin = true;
        print(response.body.toString());
        return;
      } else {
        return 'error';
      }

      //print("login na");
      // } else {
      //   print(responseData.statusCode.toString());
      // }
      // if (responseData['error'] != null) {
      //   throw HttpException(responseData['error']['message']);
      // } else {
      //   return responseData;
      // }
    } catch (error) {
      print(error);

      throw (error);
    }
  }
}
