import 'package:flutter/material.dart';

class SwitchAnimation {
  SwitchAnimation(this.controller)
      : selectButtonOpacity = new Tween(begin: 0.0, end: 1.0).animate(
          new CurvedAnimation(
            parent: controller,
            curve: new Interval(
              0.000,
              0.100,
              curve: Curves.easeIn,
            ),
          ),
        ),
        selectButtonOpacity2 = new Tween(begin: 1.0, end: 0.0).animate(
          new CurvedAnimation(
            parent: controller,
            curve: new Interval(
              0.350,
              0.400,
              curve: Curves.easeOut,
            ),
          ),
        ),
        correctButtonOpacity = new Tween(begin: 0.0, end: 1.0).animate(
          new CurvedAnimation(
            parent: controller,
            curve: new Interval(
              0.400,
              0.500,
              curve: Curves.easeIn,
            ),
          ),
        ),
        previousImageOpacity = new Tween(begin: 1.0, end: 0.0).animate(
          new CurvedAnimation(
            parent: controller,
            curve: new Interval(
              0.600,
              0.800,
              curve: Curves.easeIn,
            ),
          ),
        ),
        nextImageOpacity = new Tween(begin: 0.0, end: 1.0).animate(
          new CurvedAnimation(
            parent: controller,
            curve: new Interval(
              0.800,
              1.000,
              curve: Curves.easeIn,
            ),
          ),
        );

  final AnimationController controller;
  final Animation<double> selectButtonOpacity;
  final Animation<double> selectButtonOpacity2;
  final Animation<double> correctButtonOpacity;
  final Animation<double> previousImageOpacity;
  final Animation<double> nextImageOpacity;
}
