import 'package:alibyo_qr_scanner/model/auth.dart';
import 'package:alibyo_qr_scanner/screen/record_relief_screen.dart';
import 'package:alibyo_qr_scanner/screen/relief_scanner_screen.dart';
import 'package:alibyo_qr_scanner/screen/resident_scanner_screen.dart';
import 'package:alibyo_qr_scanner/screen/resident_screen.dart';
import 'package:provider/provider.dart';

import './screen/change_password_screen.dart';
import './screen/home_screen.dart';

import 'package:flutter/material.dart';

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
            home: auth.isLoggedIn ? HomeScreen() : MyMainPage(),
            routes: {
              MyMainPage.routeName: (ctx) => MyMainPage(),
              HomeScreen.routeName: (ctx) => HomeScreen(),
              ResidentScannerScreen.routeName: (ctx) => ResidentScannerScreen(),
              ReliefScannerScreen.routeName: (ctx) => ReliefScannerScreen(),
              ChangePasswordScreen.routeName: (ctx) => ChangePasswordScreen(),
              ResidentScreen.routeName: (ctx) => ResidentScreen(),
              RecordReliefScreen.routeName: (ctx) => RecordReliefScreen(),
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
