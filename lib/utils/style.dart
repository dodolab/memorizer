
import 'dart:ui';

import 'package:flutter/material.dart';

Color get defaultBgr { Color.fromRGBO(58, 66, 86, 1.0);}
Color get colorDecor { Color.fromRGBO(64, 75, 96, .9); }
LinearGradient get detailGradient {
  new LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: [0.1, 0.5, 0.7, 0.9],
    colors: [
      Colors.grey[800],
      Colors.grey[700],
      Colors.grey[600],
      Colors.grey[400],
    ],
  );
}


class SquareClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return new Rect.fromLTWH(0.0, 0.0, size.width, size.width);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}