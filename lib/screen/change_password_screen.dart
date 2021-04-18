import 'package:alibyo_qr_scanner/screen/home_screen.dart';
import 'package:flutter/material.dart';

void _showChangePassDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            title: Text('Change Password'),
            content: Text('Are you sure you want to change the password?'),
            actions: [
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.of(context).popAndPushNamed(HomeScreen.routeName);
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

class ChangePasswordScreen extends StatelessWidget {
  static const routeName = '/change-password-srceen';
  @override
  Widget build(BuildContext context) {
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
                      TextField(
                        obscureText: true,
                        style: TextStyle(color: Colors.blue),
                        decoration: InputDecoration(
                          labelText: 'New Password',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        obscureText: true,
                        style: TextStyle(color: Colors.blue),
                        decoration: InputDecoration(
                          labelText: 'Confirm New Password',
                        ),
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
                        onPressed: () => _showChangePassDialog(context),
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
