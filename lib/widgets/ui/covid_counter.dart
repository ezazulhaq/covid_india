import 'package:flutter/material.dart';

class CovidCounter extends StatelessWidget {
  CovidCounter({this.color, this.counter});

  final Color color;
  final String counter;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(6.0),
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(0.26),
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(
                  color: color,
                  width: 4,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            counter,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.0,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
