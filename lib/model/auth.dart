import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../model/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  int _userId;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> login(String email, String password) async {
    //isLogin = false;
    const url = 'http://192.168.6.147:8000/api/auth/login';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            "email": email,
            "password": password,
            //'returnSecureToken': true,
          },
        ),
        headers: {'Content-type': 'application/json'},
      );
      print(json.decode(response.body));

      // if (200 == response.statusCode) {
      //   //isLogin = true;
      //   print(response.body.toString());
      // } else {
      //   return 'error';
      // }
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']);
      }
      _token = responseData['access_token'];
      _userId = responseData['user']['id'];
      _expiryDate = DateTime.now().add(
        Duration(days: 7),
      );
      notifyListeners();
      // print(_token);
      // print(_userId);
      // print(_expiryDate);
    } catch (error) {
      print('EROOORRR');
      print(error);

      throw (error);
    }
  }
}
