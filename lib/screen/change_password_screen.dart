import 'dart:convert';

import 'package:alibyo_qr_scanner/model/auth.dart';
import 'package:alibyo_qr_scanner/screen/authentication_screen/body.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../screen/authentication_screen/body.dart';
import '../main.dart';

Future<void> _onChange(disId, newPass, BuildContext context) async {
  _form.currentState.save();
  //final String resId = Provider.of<Auth>(context, listen: false).login(distributorId, username, password);
  print('here');
  print(newPass);
  //print(resId);
  final url =
      'http://murmuring-plains-43014.herokuapp.com/distributor_change_pass';
  try {
    final response = await http.put(url,
        body: json.encode({
          "distributor_id": disId,
          "password": newPass,
        }),
        headers: {'Content-type': 'application/json'});
    print('there');
    //final responseData = json.decode(response.body) as Map<String, dynamic>;

    print(json.encode(response.body));
    Navigator.of(context).popAndPushNamed(MyMainPage.routeName);
  } catch (error) {
    print('yatiiii');
    print(error);
    throw (error);
  }
}

void _showChangePassDialog(disId, newPass, BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text('Change Password'),
      content: Text('Are you sure you want to change the password?'),
      actions: [
        FlatButton(
          child: Text('No'),
          onPressed: () => {Navigator.of(context).pop()},
        ),
        FlatButton(
          child: Text('Yes'),
          onPressed: () => {_onChange(disId, newPass, context)},
        ),
      ],
    ),
  );
}

final TextEditingController _pass = TextEditingController();

final GlobalKey<FormState> _form = GlobalKey<FormState>();

class ChangePasswordScreen extends StatefulWidget {
  static const routeName = '/change-password-srceen';

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String newPass;
  @override
  Widget build(BuildContext context) {
    final disId = ModalRoute.of(context).settings.arguments as String;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(colors: [
              Color.fromARGB(180, 10, 140, 255),
              Color.fromARGB(60, 5, 160, 255),
            ]),
          ),
          height: size.height * 1,
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    margin: EdgeInsets.only(top: 60, left: 50),
                    child: Icon(
                      Icons.arrow_back,
                      size: 50,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .02,
              ),
              Card(
                elevation: 2,

                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),

                //margin: EdgeInsets.all(40),
                child: Container(
                  height: size.height * .6,
                  padding:
                      EdgeInsets.only(bottom: 50, top: 50, left: 30, right: 20),
                  //alignment: Alignment.center,
                  width: size.width * .7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Change Password',
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _form,
                        child: Column(children: <Widget>[
                          TextFormField(
                              obscureText: true,
                              style: TextStyle(color: Colors.blue),
                              decoration: InputDecoration(
                                labelText: 'New Password',
                              ),
                              controller: _pass,
                              validator: (val) {
                                if (val.isEmpty) return 'Empty';
                                return null;
                              }),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            obscureText: true,
                            style: TextStyle(color: Colors.blue),
                            decoration: InputDecoration(
                              labelText: 'Confirm New Password',
                            ),
                            //controller: _confirmPass,
                            validator: (val) {
                              if (val.isEmpty) return 'Empty';
                              if (val != _pass.text) return 'Not Match';

                              return null;
                              //onChanged: newPass = value.toString(),),
                            },
                            onChanged: (val) {
                              newPass = val;
                            },
                          )
                        ]),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          if (_form.currentState.validate()) {
                            _showChangePassDialog(disId, newPass, context);
                          }
                        },
                        child: Container(
                          width: 150,
                          alignment: Alignment.center,
                          height: 50.0,
                          decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              gradient: new LinearGradient(colors: [
                                Color.fromARGB(180, 10, 140, 255),
                                Color.fromARGB(60, 5, 160, 255),
                              ])),
                          child: Text(
                            'Done',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
