import 'package:flutter/material.dart';

class BottomGradient extends StatelessWidget {
  final double offset;
  final double width;
  final double height;

  BottomGradient({this.offset: 0.95, this.width : 10000, this.height: 100});

  @override
  Widget build(BuildContext context) {
    return new Container(
        width: width,
        height: height,
        child: DecoratedBox(
          decoration: BoxDecoration(
          gradient: LinearGradient(
            end: FractionalOffset(0.0, 0.0),
            begin: FractionalOffset(0.0, offset),
            colors: <Color>[
              Color(0xff222128),
              Color(0x442C2B33),
              Color(0x002C2B33)
            ],
          )),
    ));
  }
}
