import 'package:flutter/material.dart';
import 'package:transit/Widgets/ForgetDialoge.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
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
                  height: 150,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(120.0, 120.0, 20.0, 0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 50.0,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 14.0,
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 48.0),
                  child: Text(
                    'My',
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 36.0,
                    ),
                  ),
                ),
                SizedBox(
                  width: 14.0,
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
                  width: 14.0,
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
              height: 14.0,
            ),
            Text(
              'Mass transit',
              style: TextStyle(color: Colors.grey[700]),
            ),
            SizedBox(
              height: 14.0,
            ),
            Text('Enter YOur Email to Get A verfication Code '),
            SizedBox(
              height: 24.0,
            ),
            Text(
              'Forget Password ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28.0,
              ),
            ),
            SizedBox(
              height: 14.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(fontSize: 14.0, color: Colors.grey[700]),
                  labelText: 'Email',
                  labelStyle:
                      TextStyle(fontSize: 20.0, color: Colors.grey[700]),
                ),
              ),
            ),
            SizedBox(
              height: 80.0,
            ),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NoDriverDialog();
                    });
              },
              child: Container(
                height: 40.0,
                width: 250.0,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Recover Password',
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
          ],
        ),
      )),
    );
  }
}
