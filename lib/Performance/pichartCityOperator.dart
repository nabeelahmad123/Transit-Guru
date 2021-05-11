import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:transit/Performance/CityOperator.dart';
import 'package:transit/Performance/mainpage.dart';

class ChartforCityOperator extends StatefulWidget {
  var jsondata;

  ChartforCityOperator({Key key, this.jsondata}) : super(key: key);

  @override
  _ChartforCityOperatorState createState() => _ChartforCityOperatorState();
}

class _ChartforCityOperatorState extends State<ChartforCityOperator> {
  // ignore: deprecated_member_use
  List<PieChartSectionData> _section = List<PieChartSectionData>();
  @override
  void initState() {
    super.initState();

    print("ya wala" + widget.jsondata.toString());
    print("abc");
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
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData _mediaQueryData;
    _mediaQueryData = MediaQuery.of(context);
    double width = _mediaQueryData.size.width;
    double height = _mediaQueryData.size.height;
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
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
                          "City operator",
                          style: TextStyle(
                              fontSize: 27, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
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
                                Navigator.pop(context);
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
                                text: widget.jsondata['early'].toString(),
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
                                text: widget.jsondata['onTime'].toString(),
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
                                text: widget.jsondata['late'].toString(),
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
                          widget.jsondata['avgEarlyTime'].toString(),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(widget.jsondata['avgLateTime'].toString(),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
