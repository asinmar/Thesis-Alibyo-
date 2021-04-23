import 'package:alibyo_qr_scanner/screen/resident_scanner_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/home_drawer.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Alibyo'),
      ),
      drawer: HomeDrawer(),
      body: Builder(
        builder: (BuildContext context) {
          return Container(
            alignment: Alignment.center,
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: size.width * .4,
                  height: size.height * .06,
                  //color: Colors.red,
                  padding: const EdgeInsets.all(0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(0),
                    onPressed: () => (Navigator.of(context)
                        .pushNamed(ResidentScannerScreen.routeName)),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: new LinearGradient(colors: [
                            Color.fromARGB(255, 10, 140, 255),
                            Color.fromARGB(60, 5, 160, 255),
                          ])),
                      child: Text(
                        'Scan Resident',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          //color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // Text(
                //   'Unknown QR Code',
                //   style: TextStyle(
                //     fontSize: 15,
                //     color: Colors.red,
                //   ),
                // ),
                // Text(
                //   'This QR Code is disabled.',
                //   style: TextStyle(
                //     fontSize: 15,
                //     color: Colors.red,
                //   ),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
