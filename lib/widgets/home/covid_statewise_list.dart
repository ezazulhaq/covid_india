import 'package:flutter/material.dart';

import 'app_data.dart';

class StateData extends StatelessWidget {
  StateData({this.states, this.infected, this.recovered, this.deceased});

  final String states;
  final String infected;
  final String recovered;
  final String deceased;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AppData(
            dataLabel: states,
            fontWeight: FontWeight.w500,
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
    );
  }
}
