import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../model/http_exception.dart';

class Auth with ChangeNotifier {
  var isLoggedIn = false;
  Future<void> login(
    String username,
    String password,
  ) async {
    print('here');
    print(username);
    print(password);
    const url = 'http://192.168.43.201:8000/log';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            "username": username,
            "password": password,
          },
        ),
        headers: {'Content-type': 'application/json'},
      );
      print('send');
      print(json.decode(response.body));
      isLoggedIn = true;
      // final responseData = json.decode(response.body);

      // if (responseData['error'] != null) {
      //   throw HttpException(responseData['error']);
      // } else {
      //   isLoggedIn = true;
      // }

      notifyListeners();
    } catch (error) {
      print('EROOORRR');
      print(error);

      throw (error);
    }
  }
}
