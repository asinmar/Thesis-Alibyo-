import 'package:alibyo_qr_scanner/screen/resident_scanner_screen.dart';
import 'package:flutter/material.dart';

import '../screen/relief_scanner_screen.dart';

class ResidentScreen extends StatefulWidget {
  static const routeName = '/resident-screen';

  @override
  _ResidentScreenState createState() => _ResidentScreenState();
}

class _ResidentScreenState extends State<ResidentScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final residentData =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final residentId = residentData['res_id'];
    final residentName = residentData['res_last_name'];
    final residentFName = residentData['res_first_name'];
    final residentMName = residentData['res_middle_name'];
    final residentStatus = residentData['res_qrcode_status'];
    final residentPurok = residentData['res_purok'];

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Resident'),
      ),
      drawer: Drawer(),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(
              height: size.height * .12,
            ),
            Container(
              width: size.width * .3,
              height: size.height * .10,
              //padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Image.asset(
                'assets/images/alibyo_logo.png',
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: size.height * .03),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(color: Colors.blue, width: 1.0),
                ),
                child: Container(
                  height: size.height * .24,
                  width: size.width * .9,
                  padding: EdgeInsets.all(
                    30,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Resident Information',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: size.height * .02,
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                'Name: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: size.height * .01,
                              ),
                              Text(
                                'Purok: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: size.height * .01,
                              ),
                              Text(
                                'Status: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '$residentName, $residentFName $residentMName'),
                              SizedBox(
                                height: size.height * .01,
                              ),
                              Text(residentPurok),
                              SizedBox(
                                height: size.height * .01,
                              ),
                              Text(residentStatus),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //Text(res.res[0].status),
            SizedBox(height: size.height * .04),
            Container(
              alignment: Alignment.topRight,
              padding: EdgeInsets.symmetric(horizontal: size.width * .05),
              child: residentStatus == 'Enabled'
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          textColor: Colors.white,
                          padding: const EdgeInsets.all(0),
                          onPressed: () {
                            Navigator.of(context).pop(
                              ResidentScannerScreen.routeName,
                            );
                          },
                          child: Container(
                            width: size.width * .4,
                            alignment: Alignment.center,
                            height: 50.0,
                            decoration: new BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                gradient: new LinearGradient(colors: [
                                  Color.fromARGB(255, 255, 40, 0),
                                  Color.fromARGB(60, 255, 100, 0),
                                ])),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.camera_enhance,
                                  color: Colors.black54,
                                ),
                                Text(
                                  'Scan Again',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    //color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          textColor: Colors.white,
                          padding: const EdgeInsets.all(0),
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                                ReliefScannerScreen.routeName,
                                arguments: {
                                  'res_id': residentId,
                                  'res_last_name': residentName,
                                  'res_first_name': residentFName,
                                  'res_middle_name': residentMName,
                                  'res_purok': residentPurok
                                });
                          },
                          child: Container(
                            width: size.width * .4,
                            height: 50.0,
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
                                  'Scan Relief',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    //color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(
                      width: size.width * .9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '*This qr code is currently unavailable for recieving relief goods.',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(
                            height: size.height * .05,
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(0),
                            onPressed: () {
                              Navigator.of(context).popAndPushNamed(
                                  ResidentScannerScreen.routeName,
                                  arguments: residentId);
                            },
                            child: Container(
                              width: size.width * .4,
                              alignment: Alignment.center,
                              height: 50.0,
                              decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  gradient: new LinearGradient(colors: [
                                    Color.fromARGB(255, 10, 140, 255),
                                    Color.fromARGB(60, 5, 160, 255),
                                  ])),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.camera_enhance,
                                    color: Colors.black54,
                                  ),
                                  Text(
                                    'Scan Again',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      //color: Colors.black,
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
          ],
        ),
      ),
    );
  }
}
