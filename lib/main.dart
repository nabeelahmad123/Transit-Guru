import 'package:flutter/material.dart';
import 'package:transit/Login.dart';
import 'package:transit/Performance/Tabs/Performance.dart';

import 'Performance/CityOperator.dart';
import 'Performance/DepotArea.dart';
import 'Performance/Route.dart';
import 'Performance/stop.dart';
import 'Performance/statistics.dart';
import 'Performance/mainpage.dart';
import 'Performance/pichartCityOperator.dart';
import 'package:transit/Performance/statschart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Color(0xFFFD7905)),
        debugShowCheckedModeBanner: false,
        home: Login());
  }
}
