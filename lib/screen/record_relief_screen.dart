import 'dart:convert';
import 'package:alibyo_qr_scanner/screen/relief_scanner_screen.dart';
import 'package:alibyo_qr_scanner/screen/resident_scanner_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'home_screen.dart';

class RecordReliefScreen extends StatefulWidget {
  static const routeName = '/record-screen';
  @override
  _RecordReliefScreenState createState() => _RecordReliefScreenState();
}

Future<void> recordRelief(residentId, reliefId, BuildContext context) async {
  print('asasas');
  print(residentId);
  print(reliefId);
  final url = 'http://192.168.43.201:8000/recieved_relief';
  try {
    final response = await http.put(url,
        body: json.encode({
          "res_id": residentId,
          "rel_id": reliefId,
        }),
        headers: {'Content-type': 'application/json'});
    print('sddsds');
    print(response.body);

    //final responseData = json.decode(response.body) as Map<String, dynamic>;
    // if (responseData == null) {
    //   return;
    // }
    print(response.body);

    Navigator.of(context).pushNamed(HomeScreen.routeName);
  } catch (error) {
    print('yatiiii');
    print(error);
    throw (error);
  }
}

void _showRecordPassDialog(res_id, rel_id, BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text('Record Relief'),
      content: Text('Confirm relief distribution?'),
      actions: [
        FlatButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('Confirm'),
          onPressed: () {
            recordRelief(res_id, rel_id, context);
          },
        ),
      ],
    ),
  );
}

class _RecordReliefScreenState extends State<RecordReliefScreen> {
  @override
  Widget build(BuildContext context) {
    final reliefData =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final residentId = reliefData['res_id'];
    final residentName = reliefData['res_last_name'];
    final residentFName = reliefData['res_first_name'];
    final residentMName = reliefData['res_middle_name'];
    final residentPurok = reliefData['res_purok'];
    final reliefId = reliefData['relief_id'];
    final reliefName = reliefData['relief_name'];
    final reliefDesc = reliefData['relief_description'];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Resident'),
      // ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(
              height: size.height * .22,
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
                  height: size.height * .3,
                  width: size.width * .9,
                  padding: EdgeInsets.all(
                    30,
                  ),
                  child: Column(
                    children: [
                      Text(
                        reliefName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: size.height * .02,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'To be recieved by:',
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: size.height * .01,
                              ),
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
                                'Relief Desc:  ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: size.height * .01,
                              ),
                              Text(
                                  '$residentName, $residentFName $residentMName'),
                              SizedBox(
                                height: size.height * .01,
                              ),
                              Text(residentPurok),
                              SizedBox(
                                height: size.height * .01,
                              ),
                              Text(reliefDesc),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * .04),
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
                onPressed: () =>
                    {_showRecordPassDialog(residentId, reliefId, context)},
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
                    'Recieved Relief',
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
      ),
      // Center(
      //   child: Column(
      //     children: [
      //       Text(reliefName),
      //       Text(residentId),
      //       Text(reliefId),
      //       //Text(res.res[0].status),
      //       Container(
      //         width: size.width * .4,
      //         height: size.height * .06,
      //         //color: Colors.red,
      //         padding: const EdgeInsets.all(0),
      //         child: RaisedButton(
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(50),
      //           ),
      //           textColor: Colors.white,
      //           padding: const EdgeInsets.all(0),
      //           onPressed: () => {recordRelief(residentId, reliefId, context)},
      //           child: Container(
      //             alignment: Alignment.center,
      //             height: 50.0,
      //             decoration: new BoxDecoration(
      //                 borderRadius: BorderRadius.circular(50),
      //                 gradient: new LinearGradient(colors: [
      //                   Color.fromARGB(255, 10, 140, 255),
      //                   Color.fromARGB(60, 5, 160, 255),
      //                 ])),
      //             child: Text(
      //               'Recieved Relief',
      //               textAlign: TextAlign.center,
      //               style: TextStyle(
      //                 fontWeight: FontWeight.bold,
      //                 //color: Colors.black,
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
