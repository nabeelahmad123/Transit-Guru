import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';
import 'package:transit/Login.dart';
import 'package:http/http.dart' as http;
import 'package:transit/Widgets/suffix_icon.dart';
import 'package:transit/logic/APIController.dart';

import 'logic/validation.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String email;
  String password;
  String confirmPassword;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool isLoading = false;

  bool isEmailCorrect  = false;
  bool isPasswordCorrect  = false;
  bool isConfirmPasswordCorrect  = false;
  bool enableContinue =false;

  bool viewConfirmPassword = true;

  bool viewPassword = true;


  Future registerUser() async {
    setState(() {
      isLoading = true;
    });
    http.Response response = await ApiController.registerUser(email, password, confirmPassword);
    var jsondata;
    if (response.statusCode == 200) {
      jsondata = json.decode(response.body);
      print('yes good');
      Toast.show("User Registered", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );

    } else if (response.statusCode  == 406) {
      Toast.show("This Email already taken", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      print('no no no ');
      Toast.show("Server Error", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }

    setState(() {
      isLoading = false;
      // sharedPrefrences.setString('token', jsondata['token']);
      //  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => HomePage()), (Route<dynamic> route) => false);
    });


  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: isLoading ? Center(child: CircularProgressIndicator(),) : Column(
            children: <Widget>[
              Stack(
                children: <Widget>[

                  // Positioned(child: Image.asset('images/header/bg_3_x.png',width: width+300,height:height+800,),
                  // top: -height,
                  //   left: 0,
                  //   right: 0,
                  // ),

                  Container(
                    decoration: BoxDecoration(
                         color: theme.primaryColor, boxShadow: [
                      BoxShadow(
                        color: Colors.grey[400],
                        blurRadius: 4,
                        offset: Offset(4, 8),
                      ),
                   ]
                    ),
                    width: width,
                    height: height / 5,
                    //child: Image.asset('images/header/bg.png'),
                  ),
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: height / 6.5,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 50.0,
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Image.asset('images/logo.png'),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: height / 70.0,
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'My',
                          style: TextStyle(
                            color: theme.primaryColor,
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
                            color: theme.primaryColor,
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
                      height: height / 40.0,
                    ),
                    Text(
                      'Mass transit',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    SizedBox(
                      height: width / 40.0,
                    ),
                    Text(
                      'Registration',
                      style:  theme.textTheme.bodyText1.copyWith(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold),

                    ),
                    SizedBox(
                      height: height / 70.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (value) {
                          email = value;
                          if(email!=null && Validation.validateEmail(email)){
                            isEmailCorrect = true;
                            enableContinue = Validation.validateAllInputsRegistration(isEmailCorrect, isPasswordCorrect, isConfirmPasswordCorrect);
                            setState(()=>{});
                          }
                        },
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
                          suffixIcon: Icon(FontAwesomeIcons.checkCircle,color: isEmailCorrect? Colors.orange:Colors.grey[700],),
                        ),

                      ),
                    ),
                    SizedBox(
                      height: height / 70.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        obscureText: viewPassword,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please Enter your Password';
                          }
                          return null;
                        },
                        onChanged: (val) {
                          password = val;
                          if(password!=null && password.length>6){
                            isPasswordCorrect = true;
                            enableContinue = Validation.validateAllInputsRegistration(isEmailCorrect, isPasswordCorrect, isConfirmPasswordCorrect);
                            setState(()=>{});
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Minimum 6 alpha numeric characters  ',
                          hintStyle:
                          TextStyle(fontSize: 14.0, color: Colors.grey[700]),
                          labelText: 'Password',
                          labelStyle:
                          TextStyle(fontSize: 20.0, color: Colors.grey[700]),
                          suffixIcon: InkWell(
                              child: Icon(FontAwesomeIcons.eye,color:viewPassword==false ? Colors.orange:Colors.grey[700],),
                          onTap: (){
                            viewPassword = !viewPassword;
                            setState(()=>{});
                          },

                          ),

                        ),
                      ),
                    ),
                    SizedBox(
                      height: height / 70.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (val) {
                          confirmPassword = val;
                          if(confirmPassword==password){
                            isConfirmPasswordCorrect = true;
                            enableContinue = Validation.validateAllInputsRegistration(isEmailCorrect, isPasswordCorrect, isConfirmPasswordCorrect);
                            setState(()=>{});
                          }
                        },
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please a Enter your Password';
                          }
                          if (value.length < 6) {
                            return 'Password must be atleast 6 characters';
                          }
                          if (value != password) {
                            return 'Password does not match ';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        obscureText: viewConfirmPassword,
                        decoration: InputDecoration(
                          hintText: 'Confirm Password ',
                          hintStyle:
                          TextStyle(fontSize: 14.0, color: Colors.grey[700]),
                          labelText: 'Confirm Password',
                          labelStyle:
                          TextStyle(fontSize: 20.0, color: Colors.grey[700]),
                          suffixIcon: InkWell(
                              child: Icon(FontAwesomeIcons.eye,color: viewConfirmPassword ==false ? Colors.orange:Colors.grey[700],),
                              onTap: (){
                                viewConfirmPassword = !viewConfirmPassword;
                                setState(()=>{});
                              },

                          ),

                        ),
                      ),
                    ),
                    SizedBox(
                      height: height / 40.0,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (_formkey.currentState.validate()) {
                            registerUser();
                          }
                        });
                      },
                      child: Container(
                        height: height / 18.0,
                        width: width * .6,
                        decoration: BoxDecoration(
                          color:enableContinue? Theme.of(context).primaryColor : Colors.grey,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Continue',
                            style: TextStyle(
                                color:   Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height / 60.0,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(' Already Have an Account ?'),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            'LOGIN',
                            style: TextStyle(color: Colors.orange),
                          )
                        ],
                      ),
                    ), SizedBox(height: 18,)
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
