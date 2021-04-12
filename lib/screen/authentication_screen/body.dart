import 'package:alibyo_qr_scanner/model/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './background.dart';
import '../../model/http_exception.dart';
import '../../model/auth.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Map<String, String> _authData = {
    'username': '',
    'password': '',
    'device_name': 'mobile',
  };
  final _form = GlobalKey<FormState>();

  bool iconPassword = true;
  void passwordVisibility() {
    if (iconPassword == true) {
      setState(() {
        iconPassword = false;
      });
    } else {
      setState(() {
        iconPassword = true;
      });
    }
  }

  void _showDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('An error Occured!'),
              content: Text(message),
              actions: [
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  Future<void> onSubmit(BuildContext context) async {
    _form.currentState.save();
    //Navigator.of(context).pushReplacementNamed('/home-screen');
    try {
      print(_authData['username']);
      print(_authData['password']);

      await Auth().login(_authData['username'], _authData['password']);
      if (Auth().isLogin == true) {
        Navigator.of(context).pushReplacementNamed('/home-screen');
      } else {
        print('not login');
      }

      //Navigator.of(context).pushReplacementNamed('/home-screen');
      //}
      //  on HttpException catch (error) {
      //   var errorMessage = 'Authentication failed';
      //   if (error.toString().contains('EMAIL_EXISTS')) {
      //     errorMessage = 'This Email address is already in used.';
      //     // } else if (error.toString().contains('INVALID_EMAIL')) {
      //     //   errorMessage = 'This is not a valid email address';
      //     // } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
      //     //   errorMessage = 'Could not find a user with that email.';
      //}
      // _showDialog(errorMessage);
    } catch (error) {
      _showDialog(error);
      print(error.toString());
      const errorMessage = 'Could not authenticate you.';
      _showDialog(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    //final <Map<List, String>Dummy_account> dummy = [];

    //final tr = Dummy_Account.map((acc) => acc.username).toString();

    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        children: [
          Container(
            width: size.width * .8,
            padding: EdgeInsets.fromLTRB(0, 230, 0, 0),
            child: Image.asset(
              'assets/images/alibyo_test_logo.png',
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: size.height * .02,
          ),
          Container(
            child: Form(
              key: _form,
              child: Column(
                children: [
                  Container(
                    width: size.width * .7,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.person,
                            color: Theme.of(context).primaryColor,
                          ),
                          hintText: 'Username',
                          border: InputBorder.none),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the username';
                        } else if (value.length < 6) {
                          return 'Username must be 6 character or above';
                        }
                      },
                      onChanged: (value) {
                        _authData['username'] = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  Container(
                    width: size.width * .7,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextFormField(
                      obscureText: iconPassword,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.lock,
                            color: Theme.of(context).primaryColor,
                          ),
                          suffixIcon: InkWell(
                            onTap: passwordVisibility,
                            child: iconPassword
                                ? Icon(
                                    Icons.visibility_off,
                                    color: Theme.of(context).primaryColor,
                                  )
                                : Icon(
                                    Icons.visibility,
                                    color: Theme.of(context).primaryColor,
                                  ),
                          ),
                          hintText: 'Password',
                          border: InputBorder.none),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the password';
                        } else if (value.length < 6) {
                          return 'Incorrect password';
                        }
                      },
                      onChanged: (value) {
                        _authData['password'] = value;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * .01,
          ),
          Container(
            width: size.width * .5,
            height: size.height * .08,
            padding: EdgeInsets.all(9),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(45),
              child: FlatButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  if (_form.currentState.validate()) {
                    print(_authData);
                    onSubmit(context);
                  }
                },
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
