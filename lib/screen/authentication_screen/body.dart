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
    'email': '',
    'password': '',
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

  void _showErrorDialog(String message) {
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

  Future<void> _onSubmit(BuildContext context) async {
    _form.currentState.save();
    print(_authData['email']);
    print(_authData['password']);
    try {
      await Provider.of<Auth>(context, listen: false).login(
        _authData['email'],
        _authData['password'],
      );
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('Unauthorized')) {
        errorMessage = 'Account does not exist';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var inputDecoration = InputDecoration(
        icon: Icon(
          Icons.person,
          color: Theme.of(context).primaryColor,
        ),
        hintText: 'Username',
        border: InputBorder.none);
    return Background(
      child: Column(
        children: [
          //Logo
          Container(
            width: size.width * .6,
            height: size.height * .45,
            padding: EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Image.asset(
              'assets/images/alibyo_logo.png',
              fit: BoxFit.fill,
            ),
          ),
          Form(
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
                  child:
                      //Username
                      TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: inputDecoration,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter the username';
                      } else if (value.length < 3) {
                        return 'Username must be 3 character or above';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _authData['email'] = value;
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
                  child:
                      //Password
                      TextFormField(
                    obscureText: iconPassword,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
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
                      } else if (value.length < 3) {
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

          SizedBox(
            height: size.height * .03,
          ),
          Container(
            width: size.width * .5,
            height: size.height * .06,
            //color: Colors.red,
            padding: const EdgeInsets.all(0),
            child:
                //Botton
                RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              textColor: Colors.white,
              padding: const EdgeInsets.all(0),
              onPressed: () {
                if (_form.currentState.validate()) {
                  //print(_authData);
                  _onSubmit(context);
                }
              },
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    gradient: new LinearGradient(colors: [
                      Color.fromARGB(180, 10, 140, 255),
                      Color.fromARGB(60, 5, 160, 255),
                    ])),
                child: Text(
                  'LOGIN',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    //color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
