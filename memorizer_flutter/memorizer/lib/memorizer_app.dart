

import 'package:flutter/material.dart';

class MemorizerApp extends StatelessWidget {
  final String title;

  MemorizerApp(this.title);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(this.title),
        ),
        body: new Container(
          child: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  'Hello world!',
                ),
                // updated
              ],
            ),
          ),
        ),
    );
  }
}