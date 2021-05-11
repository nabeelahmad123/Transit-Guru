import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:toast/toast.dart';
import 'package:transit/ForgetPassword.dart';
import 'package:transit/Performance/Tabs/Performance.dart';
import 'package:transit/Performance/mainpage.dart';
import 'package:transit/Signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  var Userid;
  bool isLoading = false;

  bool isEmailCorrect = false;
  bool isPasswordCorrect = false;
  bool isConfirmPasswordCorrect = false;
  bool enableContinue = false;

  bool viewConfirmPassword = true;

  bool viewPassword = true;
  Future<void> login() async {
    print(email);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    Uri APIURL =
        Uri.parse("https://portal.mytransitguru.com/api/account/login");
    Map mapdata = {
      'email': email.text,
      'password': password.text,
    };
    print("json Data :$mapdata");
    SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
    http.Response response =
        await http.post(APIURL, headers: headers, body: jsonEncode(mapdata));

    var jsondata = null;
    print(response.statusCode);
    if (response.statusCode == 200) {
      var token = sharedPrefrences.setString(
          'token', json.decode(response.body)['token']);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Mainpage()),
      );
      // Userid = json.decode(response.body)['user']['id'];

      // sharedPrefrences.setInt(
      //     'customerid', json.decode(response.body)['user']['id']);
      jsondata = json.decode(response.body);
      // sharedPrefrences.setString(
      //     'customerName', json.decode(response.body)['user']['username']);
      print('yes good');
      Toast.show("Login Successfully", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

      //
      //  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => HomePage()), (Route<dynamic> route) => false);

    } else if (response.statusCode == 203) {
      Toast.show("Invalid Credentials", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      print('no no no ');
      Toast.show("Server Error", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(color: Colors.orange, boxShadow: [
                      BoxShadow(
                        color: Colors.grey[400],
                        blurRadius: 4,
                        offset: Offset(4, 8),
                      )
                    ]),
                    width: double.infinity,
                    height: height / 5,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: height / 6.5,
                      ),
                      Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 50.0,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.asset('images/logo.png'),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: height / 70.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'My',
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 36.0,
                    ),
                  ),
                  SizedBox(
                    width: width / 40.0,
                  ),
                  Text(
                    'Transit',
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 36.0,
                    ),
                  ),
                  SizedBox(
                    width: width / 40.0,
                  ),
                  Text(
                    'Guru',
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 36.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height / 70.0,
              ),
              Text(
                'Mass transit',
                style: TextStyle(color: Colors.grey[700]),
              ),
              SizedBox(
                height: height / 70.0,
              ),
              Text(
                'LOGIN ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: width / 16.0,
                ),
              ),
              SizedBox(
                height: height / 70.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: email,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please Enter your Email';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle:
                        TextStyle(fontSize: 14.0, color: Colors.grey[700]),
                    labelText: 'Email',
                    labelStyle:
                        TextStyle(fontSize: 20.0, color: Colors.grey[700]),
                  ),
                ),
              ),
              SizedBox(
                height: height / 70.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: true,
                  controller: password,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please Enter your Password';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Password ',
                    hintStyle:
                        TextStyle(fontSize: 14.0, color: Colors.grey[700]),
                    labelText: 'Password',
                    labelStyle:
                        TextStyle(fontSize: 20.0, color: Colors.grey[700]),
                  ),
                ),
              ),
              SizedBox(
                height: height / 70.0,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgetPassword()));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 170.0),
                  child: Text('Forget Password'),
                ),
              ),
              SizedBox(
                height: height / 70.0,
              ),
              Container(
                height: height / 18.0,
                width: width * .6,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (_formkey.currentState.validate()) {
                        login();
                      }
                    });
                  },
                  child: Center(
                    child: Text(
                      'Continue',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 14.0,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Signup()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(' Dont Have an Account ?'),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      'Signup',
                      style: TextStyle(color: Colors.orange),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
