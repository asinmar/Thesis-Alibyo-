// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart' as Dio;
// import 'dio.dart';

// class Authen extends ChangeNotifier {
//   bool _isLoggedIn = false;

//   bool get authenticated => _isLoggedIn;

//   void login(Map creds) async {
//     print(creds);

//     try {
//       Dio.Response response = await dio().post('/auth/login', data: creds);
//       print(response.data.toString());
//       _isLoggedIn = true;

//       notifyListeners();
//     } catch (e) {
//       print(e);
//     }
//   }

//   void logout() {
//     _isLoggedIn = false;
//     notifyListeners();
//   }
// }
