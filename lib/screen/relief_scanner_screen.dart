import 'dart:convert';

import 'package:alibyo_qr_scanner/screen/record_relief_screen.dart';
//import 'package:alibyo_qr_scanner/screen/resident_screen.dart';
import 'package:alibyo_qr_scanner/widgets/home_drawer.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
//import 'package:qr_code_scanner/src/qr_scanner_overlay_shape.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReliefScannerScreen extends StatefulWidget {
  static const routeName = '/relief-scanner-screen';

  @override
  _ReliefScannerScreenState createState() => _ReliefScannerScreenState();
}

String reliefId;
String reliefName;
String reliefDesc;

Future<void> scanRelief(qr, resId, residentPurok, residentMName, residentFName,
    residentName, BuildContext context) async {
  // static Future<List<Residentt>> scanResident(int qr) async {
  final url = 'http://192.168.43.201:8000/relief_qr/$qr';
  try {
    final response = await http.get(
      url,
    );
    final responseData = json.decode(response.body) as Map<String, dynamic>;
    // if (responseData == null) {
    //   return;
    // }
    print(response.body);

    print(responseData['relief_id']);
    print(responseData['relief_name']);
    print(responseData['relief_description']);
    reliefId = responseData['relief_id'].toString();
    reliefName = responseData['relief_name'];
    reliefDesc = responseData['relief_description'];
    print(residentName);
    print(residentFName);
    print(residentMName);
    print(residentPurok);
    print(response.body);
    Navigator.of(context).pushNamed(RecordReliefScreen.routeName, arguments: {
      "res_id": resId,
      "res_last_name": residentName,
      "res_first_name": residentFName,
      "res_middle_name": residentMName,
      "res_purok": residentPurok,
      "relief_id": reliefId,
      "relief_name": reliefName,
      "relief_description": reliefDesc,
    });
  } catch (error) {
    print('yatiiii');
    print(error);
    throw (error);
  }
}

class _ReliefScannerScreenState extends State<ReliefScannerScreen> {
  bool _flashOn = false;
  bool _frontCamera = false;
  GlobalKey _qrKey = GlobalKey();

  QRViewController _controller;
  @override
  Widget build(BuildContext context) {
    final residentData =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final residentId = residentData['res_id'];
    final residentName = residentData['res_last_name'];
    final residentFName = residentData['res_first_name'];
    final residentMName = residentData['res_middle_name'];
    final residentPurok = residentData['res_purok'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Alibyo'),
      ),
      drawer: HomeDrawer(),
      body: Stack(
        children: [
          QRView(
            key: _qrKey,
            overlay: QrScannerOverlayShape(
                borderColor: Colors.blue,
                borderRadius: 20,
                borderLength: 50,
                borderWidth: 5,
                cutOutSize: 300),
            onQRViewCreated: (QRViewController controller) {
              this._controller = controller;
              controller.scannedDataStream.listen((val) {
                if (mounted) {
                  _controller.dispose();
                  scanRelief(val.code, residentId, residentPurok, residentMName,
                      residentFName, residentName, context);
                }
              });
            },
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 60),
              child: Text(
                'Scan Relief',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ButtonBar(
              alignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  color: Colors.white,
                  icon: Icon(_flashOn ? Icons.flash_on : Icons.flash_off),
                  onPressed: () {
                    setState(() {
                      _flashOn = !_flashOn;
                    });
                    _controller.toggleFlash();
                  },
                ),
                IconButton(
                  color: Colors.white,
                  icon: Icon(
                      _frontCamera ? Icons.camera_front : Icons.camera_rear),
                  onPressed: () {
                    setState(() {
                      _frontCamera = !_frontCamera;
                    });
                    _controller.flipCamera();
                  },
                ),
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
