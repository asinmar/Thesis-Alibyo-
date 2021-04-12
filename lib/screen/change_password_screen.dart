import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatelessWidget {
  static const routeName = '/change-password-srceen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                  labelText: 'New Password', border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: 'Confirm New Password', border: InputBorder.none),
            ),
          ],
        ),
      ),
    );
  }
}

class eer extends StatefulWidget {
  @override
  _eerState createState() => _eerState();
}

class _eerState extends State<eer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
