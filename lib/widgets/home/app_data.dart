import 'package:flutter/material.dart';

class AppData extends StatelessWidget {
  AppData({@required this.dataLabel, this.fontWeight, this.colour});

  final String dataLabel;
  final FontWeight fontWeight;
  final Color colour;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Text(
        dataLabel,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15.0,
          fontWeight: fontWeight,
          color: colour,
        ),
      ),
    );
  }
}
