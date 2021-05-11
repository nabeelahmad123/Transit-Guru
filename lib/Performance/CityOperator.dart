import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transit/Performance/mainpage.dart';
import 'package:transit/Performance/pichartCityOperator.dart';

class CityOperator extends StatefulWidget {
  @override
  CityOperatorState createState() => CityOperatorState();
}

class CityOperatorState extends State<CityOperator> {
  var jsondata;
  String _city;
  String _cityOperator;
  String to;
  String from;
  var graphsresult;
  String token;
  TextEditingController _textEditingControllerFromDate =
      new TextEditingController();
  TextEditingController _textEditingControllerToDate =
      new TextEditingController();
  String endDay;
  List dataforcities = List();
  List dataforOperators = List();

  String cityid;
  String operatorid;
  String id;
  bool isvisible1forchart = false;
  bool isvisibleforselect = true;
  bool isvisiblefornoresults = true;
  bool isvisibleforexpanded = false;

  List<PieChartSectionData> _section = List<PieChartSectionData>();
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
      id = jsondata[0]['id'];
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
    super.initState();
    PieChartSectionData _item1 = PieChartSectionData(
        color: Colors.red,
        title: "Late",
        value: 30,
        radius: 50,
        titleStyle: TextStyle(color: Colors.white, fontSize: 15));
    PieChartSectionData _item2 = PieChartSectionData(
        color: Colors.blue,
        title: "Early",
        value: 40,
        radius: 50,
        titleStyle: TextStyle(color: Colors.white, fontSize: 15));
    PieChartSectionData _item3 = PieChartSectionData(
        color: Colors.green,
        title: "On-time",
        value: 30,
        radius: 50,
        titleStyle: TextStyle(color: Colors.white, fontSize: 15));
    _section = [_item1, _item2, _item3];

    getdataforcity();
  }

  Future<String> getDataForOperators() async {
    print("object");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $token",
    };
    Uri APIURL =
        Uri.parse("https://portal.mytransitguru.com/api/cities/$id/operators");
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
      print(jsondata);

      print(jsondata.length);
      setState(() {
        dataforOperators = jsondata;
      });
      print("this " + dataforOperators.toString());
      print('yes good');
    } else if (response.statusCode == 203) {
    } else {
      print('no no no ');
    }
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
          child: Column(children: [
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
                        "City Operator",
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
            Container(
              child: Column(
                children: [
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
                                offset: Offset(
                                    0, .01), // changes position of shadow
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
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          12, 0, 12, 0),
                                                  child: Text(
                                                      item['name'].toString()),
                                                ),
                                                value: item['name'].toString(),
                                                onTap: () {
                                                  cityid = item['id'];
                                                },
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
                            Center(
                              child: Container(
                                width: width * 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 0.0),
                                  child: InkWell(
                                    onTap: () {
                                      getDataForOperators();
                                    },
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(),
                                        child: DropdownButton(
                                          hint: Text("   Select Operator"),
                                          isExpanded: true,
                                          items: dataforOperators.map((item) {
                                            return new DropdownMenuItem(
                                              onTap: () {
                                                operatorid = item['id'];
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        12, 0, 12, 0),
                                                child: Text(
                                                    item['name'].toString()),
                                              ),
                                              value: item['name'].toString(),
                                            );
                                          }).toList(),
                                          onChanged: (val) {
                                            setState(
                                              () {
                                                _city = val;
                                              },
                                            );
                                            print(_city);
                                            print(operatorid);
                                          },
                                          value: _city,
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
                                  hintText: " From",
                                  suffixIcon: IconButton(
                                    onPressed: () => print(DatepickerFrom(
                                        context,
                                        _textEditingControllerFromDate)),
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
                                  hintText: " To",
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
                                    padding: const EdgeInsets.fromLTRB(
                                        15.0, 0, 15, 0),
                                    child: Text("Generate"),
                                  ),
                                  onPressed: () async {
                                    await chartCityOperator();
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             ChartforCityOperator(
                                    //               jsondata: graphsresult,
                                    //             )));
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
                                offset: Offset(
                                    0, .01), // changes position of shadow
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
                                offset:
                                    Offset(0, 3), // changes position of shadow
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
                                "City Operator Form",
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
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: isvisible1forchart,
                    child: Column(
                      children: [
                        //till here

                        Container(
                            child: AspectRatio(
                          aspectRatio: 1,
                          child: FlChart(
                            chart: PieChart(PieChartData(sections: _section)),
                          ),
                        )),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 15, 30, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Early"),
                                Text("On-time"),
                                Text("Late"),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                  text: TextSpan(
                                      text: jsondata == null
                                          ? "Loading"
                                          : jsondata['early'].toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      children: <TextSpan>[
                                    TextSpan(
                                        text: ' 30%',
                                        style: TextStyle(
                                            color: Colors.deepOrangeAccent,
                                            fontSize: 18))
                                  ])),
                              RichText(
                                text: TextSpan(
                                    text: jsondata == null
                                        ? "Loading"
                                        : jsondata['onTime'].toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: ' 30%',
                                        style: TextStyle(
                                            color: Colors.deepOrangeAccent,
                                            fontSize: 18),
                                      ),
                                    ]),
                              ),
                              RichText(
                                  text: TextSpan(
                                      text: jsondata == null
                                          ? "Loading"
                                          : jsondata['late'].toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      children: <TextSpan>[
                                    TextSpan(
                                      text: ' 30%',
                                      style: TextStyle(
                                          color: Colors.deepOrangeAccent,
                                          fontSize: 18),
                                    )
                                  ])),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 30, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Avg Early (Mm:Ss) "),
                              Text("Avg Late (Mm:Ss) "),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 30, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                jsondata == null
                                    ? "Loading"
                                    : jsondata['avgEarlyTime'].toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  jsondata == null
                                      ? "Loading"
                                      : jsondata['avgLateTime'].toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Future chartCityOperator() async {
    Uri APIURL = Uri.parse(
        "https://portal.mytransitguru.com/api/performance/city-operator");

    final mapdata = {
      "cityId": cityid,
      "operatorId": operatorid,
      "startDate": from,
      "endDate": to
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $token",
    };
    print("json Data :$mapdata");
    http.Response response =
        await http.post(APIURL, headers: headers, body: jsonEncode(mapdata));

    // var data = jsonDecode(response.body);
    // print("Data :$data");

    if (response.statusCode == 200) {
      jsondata = json.decode(response.body);
      print('yes good');
      print(jsondata);
      graphsresult = jsondata;
      print("this" + graphsresult.toString());
      setState(() {
        // sharedPrefrences.setString('token', jsondata['token']);
        //  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => HomePage()), (Route<dynamic> route) => false);
      });
    } else if (response.statusCode == 406) {
      print("Issue");
    } else {
      print('no no no ');
    }
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
}
