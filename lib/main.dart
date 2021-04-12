//123456import 'dart:html';
import 'dart:io';
import 'package:alibyo_qr_scanner/model/authen.dart';

import './screen/change_password_screen.dart';
import './screen/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screen/authentication_screen/body.dart';

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }

void main() {
  //HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alibyo QR-Scanner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.cyanAccent,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: MyMainPage(),
      routes: {
        HomeScreen.routeName: (ctx) => HomeScreen(),
        ChangePasswordScreen.routeName: (ctx) => ChangePasswordScreen(),
      },
    );
  }
}

class MyMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Body(),
      ),
    );
  }
}
