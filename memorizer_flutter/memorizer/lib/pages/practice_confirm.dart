import 'dart:async';

import 'package:flutter/material.dart';
import 'package:memorizer/models/category_content.dart';
import 'package:memorizer/models/species_item.dart';
import 'package:memorizer/pages/species_detail.dart';
import 'package:memorizer/widgets/StaggerAnimation.dart';
import 'package:memorizer/widgets/bottom_gradient.dart';
import 'package:memorizer/widgets/species_item.dart';
import 'package:memorizer/widgets/FancyButton.dart';

class PracticeConfirmPage extends StatefulWidget {
  final CategoryContent category;

  PracticeConfirmPage(this.category);

  @override
  _PracticeConfirmPageState createState() => new _PracticeConfirmPageState();
}

class _PracticeConfirmPageState extends State<PracticeConfirmPage> with TickerProviderStateMixin {
  double dogAvatarSize = 150.0;
  double _sliderValue = 10.0;
  var animationStatus = 0;
  AnimationController _loginButtonController;
  @override
  void initState() {
    super.initState();
    _loginButtonController = new AnimationController(
        duration: new Duration(milliseconds: 3000), vsync: this);
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  Future<Null> _playAnimation() async {
    try {
      await _loginButtonController.forward();
      await _loginButtonController.reverse();
    } on TickerCanceled {}
  }


  Widget get dogProfile {
    return new Container(
      padding: new EdgeInsets.symmetric(vertical: 32.0),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            Colors.indigo[800],
            Colors.indigo[700],
            Colors.indigo[600],
            Colors.indigo[400],
          ],
        ),
      ),
      child: ClipRect(
        clipper: _SquareClipper(),
        child: Image.network(widget.category.items.first.imageUrl,
            fit: BoxFit.cover),
      ),
    );
  }



  Widget get addYourRating {
    return new Column(
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16.0,
          ),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Flexible(
                flex: 1,
                child: new Slider(
                  activeColor: Colors.indigoAccent,
                  min: 0.0,
                  max: 15.0,
                  onChanged: (newRating) => updateSlider(newRating),
                  value: _sliderValue,
                ),
              ),
              new Container(
                width: 50.0,
                alignment: Alignment.center,
                child: new Text('${_sliderValue.toInt()}',
                    style: Theme.of(context).textTheme.display1),
              ),
            ],
          ),
        ),
        submitRatingButton,
      ],
    );
  }

  Widget get submitRatingButton {
    return animationStatus == 0
        ? new Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: new InkWell(
          onTap: () {
            setState(() {
              animationStatus = 1;
            });
            _playAnimation();
          },
          child: new FancyButton()),
    )
        : new StaggerAnimation(
        buttonController:
        _loginButtonController.view);
  }

  void updateSlider(double newRating) {
    setState(() => _sliderValue = newRating);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
        title: Text('List Page'),
    ),
    body: Column(
    mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        dogProfile,
        addYourRating
      ],
    ));
  }
}

class _SquareClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return new Rect.fromLTWH(0.0, 0.0, size.width, size.width);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}