import 'package:flutter/material.dart';

import '../screen/home_screen.dart';
import '../screen/change_password_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            //automaticallyImplyLeading: false,
            title: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Example Name',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Example Contact Number',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          /*Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            color: Theme.of(context).primaryColor,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            ),
          ),*/
          buildListTile(
            'Home',
            Icons.home,
            () {
              Navigator.of(context).pushNamed(HomeScreen.routeName);
            },
            context,
          ),
          Divider(),
          buildListTile(
            'History',
            Icons.library_books,
            () {},
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
            () {},
            context,
          ),
          /*Divider(
            color: Theme.of(context).primaryColor,
          ),*/
        ],
      ),
    );
  }
}
