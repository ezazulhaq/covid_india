import 'package:flutter/material.dart';

import 'app_data.dart';

class DistrictData extends StatelessWidget {
  DistrictData({this.districts, this.infected, this.recovered, this.deceased});

  final String districts;
  final String infected;
  final String recovered;
  final String deceased;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AppData(
                dataLabel: districts,
                fontWeight: FontWeight.w500,
                colour: Colors.black,
              ),
              AppData(
                dataLabel: infected,
                colour: Colors.redAccent,
              ),
              AppData(
                dataLabel: recovered,
                colour: Colors.green,
              ),
              AppData(
                dataLabel: deceased,
                colour: Colors.blueAccent,
              ),
            ],
          ),
          Divider(
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
