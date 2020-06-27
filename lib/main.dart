import 'package:covidindia/screens/state_wise_search.dart';
import 'package:flutter/material.dart';
import 'package:covidindia/screens/covid_home.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'COVID-19 India',
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StateWiseSearchHomePage(),
                ),
              );
            },
            child: Icon(
              Icons.search,
              size: 30.0,
            ),
          ),
        ],
      ),
      body: CovidHome(),
    );
  }
}
