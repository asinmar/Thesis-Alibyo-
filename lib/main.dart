//123456import 'dart:html';
// import 'dart:io';
// import 'package:alibyo_qr_scanner/model/authen.dart';

import 'package:alibyo_qr_scanner/model/auth.dart';
import 'package:provider/provider.dart';

import './screen/change_password_screen.dart';
import './screen/home_screen.dart';

import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import './screen/authentication_screen/body.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          )
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Alibyo QR-Scanner',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              accentColor: Colors.cyanAccent,
              scaffoldBackgroundColor: Colors.white,
            ),
            home: !auth.isAuth ? HomeScreen() : MyMainPage(),
            routes: {
              MyMainPage.routeName: (ctx) => MyMainPage(),
              HomeScreen.routeName: (ctx) => HomeScreen(),
              ChangePasswordScreen.routeName: (ctx) => ChangePasswordScreen(),
            },
          ),
        ));
  }
}

class MyMainPage extends StatelessWidget {
  static const routeName = '/auth';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Body(),
      ),
    );
  }
}
