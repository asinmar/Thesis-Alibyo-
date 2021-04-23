//import 'package:alibyo_qr_scanner/model/user.dart';
import 'package:alibyo_qr_scanner/screen/authentication_screen/body.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../screen/home_screen.dart';
import '../screen/change_password_screen.dart';
import '../model/auth.dart';
//import '../screen/authentication_screen/body.dart' as bod;

class HomeDrawer extends StatelessWidget {
  Widget buildListTile(
      String title, IconData icon, Function tapHandler, BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
        color: Theme.of(context).primaryColor,
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      onTap: tapHandler,
    );
  }

  var auth = Auth();

  void _showLogoutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('Logout'),
              content: Text('Are you sure you want to logout?'),
              actions: [
                FlatButton(
                  child: Text('Yes'),
                  onPressed: () {
                    Navigator.of(context).popAndPushNamed(MyMainPage.routeName);
                  },
                ),
                FlatButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Text(
                    ('Alibyo'),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          buildListTile(
            'Home',
            Icons.home,
            () {
              //Navigator.of(context).pushNamed(HomeScreen.routeName);
            },
            context,
          ),
          Divider(),
          buildListTile(
            'Change Password',
            Icons.security,
            () {
              Navigator.of(context).pushNamed(ChangePasswordScreen.routeName);
            },
            context,
          ),
          Divider(),
          buildListTile(
            'Logout',
            Icons.logout,
            () => _showLogoutDialog(context),
            context,
          ),
        ],
      ),
    );
  }
}
