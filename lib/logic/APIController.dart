
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class ApiController{

  static const _baseUrl = "https://portal.mytransitguru.com";

  static Future<http.Response> registerUser(email,password,confirmPassword) async {
    Uri APIURL = Uri.parse("$_baseUrl/api/account/register");

    final mapdata = {
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    print("json Data :$mapdata");
    http.Response response =
    await http.post(APIURL, headers: headers, body: jsonEncode(mapdata));

    var data = jsonDecode(response.body);
    print("Data :$data");
    var jsondata;

    return response;
  }




}