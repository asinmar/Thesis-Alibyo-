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
    final disId = ModalRoute.of(context).settings.arguments as String;

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Alibyo'),
      ),
      drawer: HomeDrawer(disId),
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
                  padding: const EdgeInsets.all(0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(0),
                    onPressed: () => (Navigator.of(context).pushNamed(
                        ResidentScannerScreen.routeName,
                        arguments: disId)),
                    child: Container(
                      width: size.width * .4,
                      alignment: Alignment.center,
                      height: size.height * .06,
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: new LinearGradient(colors: [
                            Color.fromARGB(255, 10, 140, 255),
                            Color.fromARGB(60, 5, 160, 255),
                          ])),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.camera_enhance,
                            color: Colors.black54,
                          ),
                          Text(
                            'Scan Resident',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
