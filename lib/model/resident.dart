import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/http_exception.dart';

class Resident {
  var map = Map<String, dynamic>();
  Future<void> scanResident(int qr) async {
    //isLogin = false;
    final url = 'http://127.0.0.1:8000/api/resident';
    try {
      final response = await http.get(
        url,
      );
      print(json.decode(response.body));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']);
      }
      // else if (){

      // }

    } catch (error) {
      print('EROOORRR');
      print(error);

      throw (error);
    }
  }
}
