
import 'dart:ui';

import 'package:flutter/material.dart';

Color get defaultBgr { Color.fromRGBO(58, 66, 86, 1.0);}
Color get colorDecor { Color.fromRGBO(64, 75, 96, .9); }

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