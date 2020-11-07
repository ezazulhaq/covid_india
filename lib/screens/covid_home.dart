import 'package:covidindia/screens/state_wise_ui.dart';
import 'package:covidindia/widgets/home/app_data.dart';
import 'package:covidindia/widgets/home/covid_statewise_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as Http;
import 'dart:convert';

String url = 'https://api.covid19india.org/data.json';
String url1 = 'https://api.covid19india.org/state_district_wise.json';

List<StateData> statesData = [];

class CovidHome extends StatefulWidget {
  static Map<String, dynamic> map;

  @override
  _CovidHomeState createState() => _CovidHomeState();
}

class _CovidHomeState extends State<CovidHome> {
  int stateCount = 0;

  Future<List<dynamic>> getCovidDataStates(String url) async {
    Http.Response dataResponse = await Http.get(url);

    List<dynamic> dataStats;

    if (dataResponse.statusCode == 200) {
      String dataResp = dataResponse.body;

      CovidHome.map = json.decode(dataResp);
      dataStats = CovidHome.map['statewise'];

      stateCount = dataStats.length;
    } else {
      var dataJson = dataResponse.statusCode.toString();
      print(dataJson);
    }

    return dataStats;
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      getCovidDataStates(url);
      getListOfDistricts(url1);
    });
    return null;
  }

  @override
  void initState() {
    super.initState();
    getListOfDistricts(url1);
  }

  Map<String, dynamic> mapStates;

  // ignore: missing_return
  Future<Map<String, dynamic>> getListOfDistricts(String url) async {
    Http.Response response = await Http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;

      mapStates = json.decode(data);
      //print(mapStates);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      color: Colors.white,
      child: FutureBuilder(
        future: getCovidDataStates(url),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapShot) {
          if (snapShot.connectionState == ConnectionState.none &&
              snapShot.hasData == null) {
            return Container();
          } else {
            return SingleChildScrollView(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AppData(
                          dataLabel: 'States',
                          fontWeight: FontWeight.w700,
                        ),
                        AppData(
                          dataLabel: 'Confirmed',
                          fontWeight: FontWeight.w700,
                          colour: Colors.redAccent,
                        ),
                        AppData(
                          dataLabel: 'Recovered',
                          fontWeight: FontWeight.w700,
                          colour: Colors.green,
                        ),
                        AppData(
                          dataLabel: 'Deaths',
                          fontWeight: FontWeight.w700,
                          colour: Colors.blueAccent,
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  ListView.separated(
                    itemCount: stateCount,
                    separatorBuilder: (context, index) => Divider(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    controller: ScrollController(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: StateData(
                          states: snapShot.data[index]['state'],
                          infected: snapShot.data[index]['confirmed'],
                          recovered: snapShot.data[index]['recovered'],
                          deceased: snapShot.data[index]['deaths'],
                        ),
                        onTap: () {
                          if (snapShot.data[index]['state'] != 'Total') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StateWiseUI(
                                  state: snapShot.data[index]['state'],
                                  infected: snapShot.data[index]['confirmed'],
                                  recovered: snapShot.data[index]['recovered'],
                                  deceased: snapShot.data[index]['deaths'],
                                  districtData: mapStates,
                                ),
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
