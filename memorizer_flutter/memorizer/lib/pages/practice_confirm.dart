import 'dart:async';

import 'package:flutter/material.dart';
import 'package:memorizer/lang/sit_localizations.dart';
import 'package:memorizer/entities/category_content.dart';
import 'package:memorizer/pages/practice.dart';
import 'package:memorizer/widgets/stagger_animation.dart';
import 'package:memorizer/widgets/fancy_button.dart';

class PracticeConfirmPage extends StatefulWidget {
  final CategoryContent category;

  PracticeConfirmPage(this.category);

  @override
  _PracticeConfirmPageState createState() => new _PracticeConfirmPageState();
}

class _PracticeConfirmPageState extends State<PracticeConfirmPage>
    with TickerProviderStateMixin {
  double _sliderValue = 1;
  var animationStatus = 0;
  AnimationController _loginButtonController;

  @override
  void initState() {
    super.initState();
    _loginButtonController = new AnimationController(
        duration: new Duration(milliseconds: 3000), vsync: this);
    _sliderValue = widget.category.items.length.toDouble();
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  Future<Null> _playAnimation() async {
    try {
      await _loginButtonController.forward();

      Navigator.of(context).pop();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return new Practice(itemsNum: _sliderValue.toInt(), items: widget.category.items);
      }));
    } on TickerCanceled {}
  }

  void updateSlider(double newRating) {
    setState(() => _sliderValue = newRating);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(SitLocalizations.of(context).practice),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildImage(),
            Row(
              children: <Widget>[
                Container(
                    padding: new EdgeInsets.symmetric(
                      horizontal: 26.0,
                    ),
                    child: new Text(SitLocalizations.of(context).select, style: TextStyle(fontSize: 16))
                )
              ],
            ),
            _buildSlider(),
            new Container(
              margin: EdgeInsets.only(bottom: 20),
              color: Colors.redAccent,
              height: 1,
            ),
            _buildSubmitButton()
          ],
        ));
  }

  Widget _buildImage() {
    return new Hero(
      tag: widget.category.items.first.imageUrl,
      child: new Container(
        height:200,
        margin: EdgeInsets.only(top: 100, bottom: 50),
        constraints: new BoxConstraints(),
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          image: new DecorationImage(
            fit: BoxFit.contain,
            image: new AssetImage("assets/img_practice.png"),
          ),
        ),
      ),
    );
  }

  Widget _buildSlider() {
    return new Container(
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
                min: 1,
                max: widget.category.items.length.toDouble(),
                onChanged: (newRating) => updateSlider(newRating),
                value: _sliderValue,
              ),
            ),
            new Container(
              width: 80.0,
              alignment: Alignment.center,
              child: new Text('${_sliderValue.toInt()}',
                  style: Theme.of(context).textTheme.display1),
            ),
          ],
        ));
  }

  Widget _buildSubmitButton() {
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
                child:
                    new FancyButton(title: SitLocalizations.of(context).start)),
          )
        : new StaggerAnimation(
            title: SitLocalizations.of(context).start,
            buttonController: _loginButtonController.view);
  }
}
