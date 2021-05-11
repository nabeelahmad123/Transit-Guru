import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transit/Performance/mainpage.dart';
import 'dart:convert';

import 'package:transit/Performance/statschart.dart';
import 'package:transit/global.dart';

class Stats extends StatefulWidget {
  @override
  _CityOperatorState createState() => _CityOperatorState();
}

class _CityOperatorState extends State<Stats> {
  var graphsresult;
  String cityid;
  final List<Feature> features = [
    Feature(
      title: "Journeys Travelled",
      color: Colors.blue,
      data: journey,
    ),
    Feature(
      title: "Stop Visited",
      color: Colors.green,
      data: stop,
    ),
    Feature(
      title: "Avg Stops/journey",
      color: Colors.red,
      data: avg,
    ),
  ];

  String _cityOperator;
  String to, from;
  List dataforcities = List();
  TextEditingController _textEditingControllerCity =
      new TextEditingController();
  TextEditingController _textEditingControllerOperator =
      new TextEditingController();
  TextEditingController _textEditingControllerFromDate =
      new TextEditingController();
  TextEditingController _textEditingControllerToDate =
      new TextEditingController();
  bool isvisible1forchart = false;
  bool isvisibleforselect = true;
  bool isvisiblefornoresults = true;
  bool isvisibleforexpanded = false;
  String token;
  Future<String> getdataforcity() async {
    SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
    token = sharedPrefrences.getString('token');
    print("object");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $token",
    };
    Uri APIURL = Uri.parse("https://portal.mytransitguru.com/api/cities");
    Map mapdata = {};
    print("json Data :$mapdata");

    http.Response response = await http.get(
      APIURL,
      headers: headers,
    );

    var jsondata = null;
    print(response.statusCode);
    if (response.statusCode == 200) {
      jsondata = json.decode(response.body);

      print(jsondata.length);
      setState(() {
        dataforcities = jsondata;
      });
      print(jsondata);
      print('yes good');
    } else if (response.statusCode == 203) {
    } else {
      print('no no no ');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdataforcity();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData _mediaQueryData;
    _mediaQueryData = MediaQuery.of(context);
    double width = _mediaQueryData.size.width;
    double height = _mediaQueryData.size.height;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white30),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 0,
                        blurRadius: 7,
                        offset: Offset(0, .01), // changes position of shadow
                      ),
                    ]),
                width: width,
                height: height / 8,
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            "PEROFORMANCE",
                            style: TextStyle(
                                fontSize: 12,
                                letterSpacing: 1.5,
                                color: Colors.orange,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Mainpage()));
                            },
                            child: Text(
                              "Back",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          "Daily Statistics",
                          style: TextStyle(
                              fontSize: 27, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height / 25,
              ),
              Visibility(
                visible: isvisibleforselect,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white30),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 0,
                            blurRadius: 7,
                            offset:
                                Offset(0, .01), // changes position of shadow
                          ),
                        ]),
                    width: width * .9,
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                            width: width * 1,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 0.0),
                              child: InkWell(
                                onTap: () async {},
                                child: Container(
                                  child: InkWell(
                                    onTap: () {
                                      getdataforcity();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(),
                                      child: DropdownButton(
                                        hint: Text("   Select City"),
                                        isExpanded: true,
                                        items: dataforcities.map((item) {
                                          return new DropdownMenuItem(
                                            onTap: () {
                                              cityid = item['id'];
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      12, 0, 12, 0),
                                              child:
                                                  Text(item['name'].toString()),
                                            ),
                                            value: item['name'].toString(),
                                          );
                                        }).toList(),
                                        onChanged: (val) {
                                          setState(
                                            () {
                                              _cityOperator = val;
                                            },
                                          );

                                          print(_cityOperator);
                                          print(cityid);
                                        },
                                        value: _cityOperator,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextFormField(
                            controller: _textEditingControllerFromDate,
                            decoration: InputDecoration(
                              hintText: "From",
                              suffixIcon: IconButton(
                                onPressed: () => print(DatepickerFrom(
                                    context, _textEditingControllerFromDate)),
                                icon: Icon(Icons.calendar_today),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextFormField(
                            controller: _textEditingControllerToDate,
                            decoration: InputDecoration(
                              hintText: "To",
                              suffixIcon: IconButton(
                                onPressed: () => print(DatepickerTo(
                                    context, _textEditingControllerToDate)),
                                icon: Icon(Icons.calendar_today),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height / 55,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: TextButton(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15.0, 0, 15, 0),
                                child: Text("Generate"),
                              ),
                              onPressed: () async {
                                await chartCitydata();
                                setState(() {
                                  isvisible1forchart = true;
                                  isvisibleforselect = false;
                                  isvisiblefornoresults = false;
                                  isvisibleforexpanded = true;
                                });
                              },

                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.deepOrangeAccent),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                              ),

                              //    style,: RoundedRectangleBorder(
                              //      borderRadius: new BorderRadius.circular(10.0)
                              // )
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: height / 50),
              Visibility(
                visible: isvisiblefornoresults,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white30),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 0,
                            blurRadius: 7,
                            offset:
                                Offset(0, .01), // changes position of shadow
                          ),
                        ]),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "No Results Found",
                        style: TextStyle(color: Colors.grey, fontSize: 22),
                      ),
                    ),
                    width: width * .9,
                    height: height / 2,
                  ),
                ),
              ),
              Visibility(
                visible: isvisibleforexpanded,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white30),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ]),
                  width: width * .9,
                  height: height / 12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          "Daily Static Form",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: InkWell(
                          child: Image.asset(
                            'images/expanded.png',
                          ),
                          onTap: () {
                            setState(() {
                              isvisible1forchart = true;
                              isvisibleforselect = true;
                              isvisiblefornoresults = false;
                              isvisibleforexpanded = false;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Visibility(
                visible: isvisible1forchart,
                child: Column(
                  children: [
                    Text(
                      'Daily Total Journey',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Travel and Stops Visited',
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: LineGraph(
                        features: features,
                        size: Size(420, 450),
                        labelX: ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN'],
                        labelY: ['25%', '45%', '65%', '75%', '85%', '100%'],
                        showDescription: true,
                        graphColor: Colors.black87,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> DatepickerTo(context, TextEditingController controller) async {
    DateTime selectedDate = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        to = selectedDate.toString();
      });

    controller.text = "${selectedDate.toLocal()}".split(' ')[0];
    print(selectedDate);
  }

  Future<void> DatepickerFrom(context, TextEditingController controller) async {
    DateTime selectedDate = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        from = selectedDate.toString();
      });

    controller.text = "${selectedDate.toLocal()}".split(' ')[0];
    print(selectedDate);
  }

  Future chartCitydata() async {
    Uri APIURL = Uri.parse(
        "https://portal.mytransitguru.com/api/performance/daily-statistics");

    final mapdata = {"cityId": cityid, "startDate": from, "endDate": to};
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $token",
    };
    print("json Data :$mapdata");
    http.Response response =
        await http.post(APIURL, headers: headers, body: jsonEncode(mapdata));

    var jsondata;
    if (response.statusCode == 200) {
      jsondata = json.decode(response.body);
      print('yes good');
      print(jsondata);
      graphsresult = jsondata;
      journey.clear();
      stop.clear();
      avg.clear();
      jsondata.forEach((f) {
        setState(() {
          journey.add(f['totalJourneys'] / 100000);
          stop.add(f['totalStops'] / 10000000);
          avg.add(f['avgStopsPerJourney'] / 100);
        });
      });
      print(journey.toString());
      print(stop.toString());
      print(avg.toString());
      print("this" + graphsresult.toString());
    } else if (response.statusCode == 406) {
    } else {
      print('no no no ');
    }
  }
}
