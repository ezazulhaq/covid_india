import 'dart:convert';

import 'package:covidindia/widgets/ui/covid_counter.dart';
import 'package:covidindia/widgets/ui/district_wise_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as Http;

String url = 'https://api.covid19india.org/state_district_wise.json';

class StateWiseUI extends StatefulWidget {
  StateWiseUI(
      {this.state,
      this.infected,
      this.recovered,
      this.deceased,
      this.districtData});

  final String state;
  final String infected;
  final String recovered;
  final String deceased;
  final Map districtData;

  @override
  _StateWiseUIState createState() => _StateWiseUIState();
}

class _StateWiseUIState extends State<StateWiseUI> {
  Map<String, dynamic> mapStates;

  // ignore: missing_return
  Future<Map<String, dynamic>> getListOfDistricts(String url) async {
    Http.Response response = await Http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;

      mapStates = json.decode(data);
      print(mapStates);
    }
  }

  @override
  void initState() {
    super.initState();
    //getListOfDistricts(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'State Wise View',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: getListOfDistricts(url),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapShot) {
            if (snapShot.connectionState == ConnectionState.none &&
                snapShot.hasData == null) {
              return Container();
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 200.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      padding: EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Text(
                              widget.state,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CovidCounter(
                                    color: Colors.red,
                                    counter: widget.infected),
                                CovidCounter(
                                    color: Colors.green,
                                    counter: widget.recovered),
                                CovidCounter(
                                    color: Colors.blue,
                                    counter: widget.deceased),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    DistrictWiseItem(
                      stateName: widget.state,
                      mapping: mapStates,
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}