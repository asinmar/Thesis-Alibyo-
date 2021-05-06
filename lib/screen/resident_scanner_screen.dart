import 'dart:convert';

import 'package:alibyo_qr_scanner/screen/resident_screen.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResidentScannerScreen extends StatefulWidget {
  static const routeName = '/resident-scanner-screen';
  @override
  _ResidentScannerScreenState createState() => _ResidentScannerScreenState();
}

String residentId;
String residentName;
String residentStatus;

Future<void> scanResident(qr, BuildContext context, disId) async {
  final url = 'http://murmuring-plains-43014.herokuapp.com/scanned_qr/$qr';
  try {
    final response = await http.get(
      url,
    );
    final responseData = json.decode(response.body) as Map<String, dynamic>;
    print(response.body);
    print(responseData['res_id']);
    print(responseData['res_last_name']);
    print(responseData['res_first_name']);
    print(responseData['res_middle_name']);
    print(responseData['res_qrcode_status']);
    print('${responseData['res_purok']}');

    residentId = responseData['res_id'].toString();
    residentName = responseData['res_last_name'];
    String residentFName = responseData['res_first_name'];
    String residentMName = responseData['res_middle_name'];
    residentStatus = responseData['res_qrcode_status'];
    String residentPurok = responseData['res_purok'];
    Navigator.of(context).popAndPushNamed(ResidentScreen.routeName, arguments: {
      "res_id": residentId,
      "res_last_name": residentName,
      "res_first_name": residentFName,
      "res_middle_name": residentMName,
      "res_qrcode_status": residentStatus,
      "res_purok": residentPurok,
      "dis_id": disId,
    });
  } catch (error) {
    print(error);
    throw (error);
  }
}

class _ResidentScannerScreenState extends State<ResidentScannerScreen> {
  bool _flashOn = false;
  bool _frontCamera = false;
  GlobalKey _qrKey = GlobalKey();

  QRViewController _controller;
  @override
  Widget build(BuildContext context) {
    final disId = ModalRoute.of(context).settings.arguments as String;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                  scanResident(val.code, context, disId);
                }
              });
            },
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: size.height * .13),
              child: Text(
                'Scan Resident',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade300,
                ),
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
