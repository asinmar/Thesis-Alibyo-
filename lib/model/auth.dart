import 'dart:convert';

import 'package:alibyo_qr_scanner/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  var isLoggedIn = false;
  String distributorId;

  Future login(
    String distributorId,
    String username,
    String password,
    BuildContext context,
  ) async {
    String distributorId;
    print('here');
    print(username);
    print(password);
    const url = 'http://murmuring-plains-43014.herokuapp.com/log';
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
      final responseData = json.decode(response.body);

      distributorId = responseData['user']['id'].toString();
      print(distributorId);

      // if (responseData['error'] != null) {
      //   throw HttpException(responseData['error']);
      // } else {
      //   isLoggedIn = true;
      // }
      Navigator.of(context)
          .popAndPushNamed(HomeScreen.routeName, arguments: distributorId);
      //  Navigator.push(
      // context,
      // MaterialPageRoute(builder: (context) =>
      //   HomeScreen(distributorId)),
      //);
      notifyListeners();
    } catch (error) {
      print('EROOORRR');
      print(error);

      throw (error);
    }
  }
}
