import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transit/Performance/mainpage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:transit/global.dart';

class Stop extends StatefulWidget {
  @override
  _CityOperatorState createState() => _CityOperatorState();
}

class _CityOperatorState extends State<Stop> {
  String _cDAGroup;
  List dataforCDA = List();
  List dataforRoute = List();
  //List dataforjourney = List();
  var dataforjourney;
  String route;
  String routeid;
  String _token;
  String journeyvalue;
  String journeyid;
  TextEditingController _textEditingControllerCity =
      new TextEditingController();
  TextEditingController _textEditingControllerOperator =
      new TextEditingController();
  TextEditingController _textEditingControllerFromDate =
      new TextEditingController();
  TextEditingController _textEditingControllerToDate =
      new TextEditingController();
  Future<String> getDataForCDA() async {
    SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
    _token = sharedPrefrences.getString('token');
    print("object");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $_token",
    };
    Uri APIURL = Uri.parse("https://portal.mytransitguru.com/api/codagroups");
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
        dataforCDA = jsondata;
      });
      print(jsondata);
      print('yes good');
    } else if (response.statusCode == 203) {
    } else {
      print('no no no ');
    }
  }

  Future<String> getDataForRoute() async {
    SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
    _token = sharedPrefrences.getString('token');
    print("object");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $_token",
    };
    print(operatorID);
    print(areaID);
    Uri APIURL = Uri.parse(
        "https://portal.mytransitguru.com/api/codagroups/routes?cityOperatorId=$operatorID&depotAreaId=$areaID");
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

      setState(() {
        dataforRoute = jsondata;
      });
      print(jsondata);
      print('yes good');
    } else if (response.statusCode == 203) {
    } else {
      print('no no no ');
    }
  }

  Future<String> getDataForJourney() async {
    SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
    _token = sharedPrefrences.getString('token');
    print("object");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $_token",
    };

    Uri APIURL = Uri.parse("https://portal.mytransitguru.com/api/journeys");
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

      setState(() {
        // dataforjourney = jsondata;
        dataforjourney = ['All journey'];
        dataforjourney = dataforjourney + jsondata;
        print(dataforjourney);
      });
      print('yes good');
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
    getDataForCDA();
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
                          "Stop",
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
              Center(
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
                          offset: Offset(0, .01), // changes position of shadow
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
                              onTap: () {
                                getDataForCDA();
                              },
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(),
                                  child: DropdownButton(
                                    hint: Text("   Select CDA Group"),
                                    isExpanded: true,
                                    items: dataforCDA.map((item) {
                                      return new DropdownMenuItem(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              12, 0, 12, 0),
                                          child: Text(
                                            item['name'].toString(),
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                        value: item['name'].toString(),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      setState(
                                        () {
                                          _cDAGroup = val;
                                        },
                                      );
                                      print(_cDAGroup);
                                    },
                                    value: _cDAGroup,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
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
                                    getDataForRoute();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(),
                                    child: DropdownButton(
                                      hint: Text("   Select Route"),
                                      isExpanded: true,
                                      items: dataforRoute.map((item) {
                                        return new DropdownMenuItem(
                                          onTap: () {
                                            routeid = item['id'] == null
                                                ? "a"
                                                : item['id'].toString();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                12, 0, 12, 0),
                                            child: Text(item['name'] == null
                                                ? "a"
                                                : item['name'].toString()),
                                          ),
                                          value: item['name'] == null
                                              ? "a"
                                              : item['name'].toString(),
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        setState(
                                          () {
                                            route = val;
                                          },
                                        );
                                        print(route);
                                        print(routeid);
                                      },
                                      value: route,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
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
                                    getDataForJourney();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(),
                                    child: DropdownButton(
                                      hint: Text("   Select Journey"),
                                      isExpanded: true,
                                      items: dataforjourney.map((String item) {
                                        return new DropdownMenuItem(
                                          onTap: () {
                                            journeyid = item.toString();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                12, 0, 12, 0),
                                            child: Text(item),
                                          ),
                                          value: item,
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        setState(
                                          () {
                                            journeyvalue = val;
                                          },
                                        );
                                        print(journeyvalue);
                                        print(journeyid);
                                      },
                                      value: journeyvalue,
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
                          controller: _textEditingControllerOperator,
                          decoration: InputDecoration(
                            hintText: "Select Stop",
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  _textEditingControllerOperator.clear(),
                              icon: Icon(Icons.arrow_drop_down),
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
                              onPressed: () => print(Datepicker(
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
                              onPressed: () => print(Datepicker(
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
                            onPressed: null,

                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.deepOrangeAccent),
                              foregroundColor: MaterialStateProperty.all<Color>(
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
              SizedBox(height: height / 50),
              Center(
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
                          offset: Offset(0, .01), // changes position of shadow
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
            ],
          ),
        ),
      ),
    );
  }

  Future<void> Datepicker(context, TextEditingController controller) async {
    DateTime selectedDate = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });

    controller.text = "${selectedDate.toLocal()}".split(' ')[0];
    print(selectedDate);
  }
}
