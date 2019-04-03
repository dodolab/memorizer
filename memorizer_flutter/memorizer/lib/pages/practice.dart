import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:memorizer/lang/sit_localizations.dart';
import 'package:memorizer/entities/species_item.dart';
import 'package:memorizer/models/practice_model.dart';
import 'package:memorizer/pages/summary.dart';
import 'package:memorizer/utils/shared_preferences.dart';
import 'package:memorizer/utils/style.dart';
import 'package:memorizer/utils/switch_animation.dart';


class Practice extends StatefulWidget {
  Practice({Key key, this.itemsNum, this.items}) : super(key: key);
  int itemsNum;
  List<SpeciesItem> items;

  @override
  _PracticeState createState() =>
      new _PracticeState(model: PracticeModel(itemsNum: itemsNum, items: items));
}

class _PracticeState extends State<Practice> with TickerProviderStateMixin {
  AnimationController _switchController;
  SwitchAnimation _switchAnimation;

  bool _evaluationPending = false;
  String langCode;
  int selectedItemIndex = 0;
  PracticeModel model;

  _PracticeState({this.model});

  @override
  void initState() {
    super.initState();
    _switchController = new AnimationController(
        duration: new Duration(milliseconds: 2000), vsync: this);
    _switchAnimation = new SwitchAnimation(_switchController);
    model.init();
  }

  @override
  void dispose() {
    _switchController.dispose();
    super.dispose();
  }

  Future<Null> _playAnimation() async {
    try {
      await _switchController.forward(from: 0);
    } on TickerCanceled {}
  }

  selectItem(SpeciesItem item, int index) {
    selectedItemIndex = index;
    model.submitItem(item, index);
  }

  @override
  Widget build(BuildContext context) {
    return new SharedPreferencesBuilder(
        pref: PREF_LANG_CODE,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          langCode = snapshot.data;
          return new AnimatedBuilder(
            animation: _switchController,
            builder: _buildContent,
          );
        });
  }

  Widget _buildContent(BuildContext context, Widget child) {
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            backgroundColor: defaultBgr,
            body: OrientationBuilder(
              builder: (context, orientation) {
                var opacity = 1.0;
                if (_switchController.isAnimating) {
                  if (_switchAnimation.previousImageOpacity.value > 0) {
                    opacity = _switchAnimation.previousImageOpacity.value;
                  } else if(model.canGoNext()) {
                    opacity = _switchAnimation.nextImageOpacity.value;
                  } else {
                    opacity = 0;
                  }
                }

                var imageToShow = (_switchController.isAnimating &&
                    _switchAnimation.previousImageOpacity.value == 0 &&
                    model.canGoNext())
                    ? model.items[model.currentIndex + 1].imageUrls.first
                    : model.items[model.currentIndex].imageUrls.first;

                return Stack(
                  children: <Widget>[
                    Center(child: OrientationBuilder(
                      builder: (context, orientation) {
                        return Card(
                            elevation: 8.0,
                            margin: new EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 6.0),
                            child: Padding(
                                padding: EdgeInsets.all(2),
                                child: Container(
                                  width: orientation == Orientation.landscape
                                      ? MediaQuery
                                      .of(context)
                                      .size
                                      .width
                                      : MediaQuery
                                      .of(context)
                                      .size
                                      .height,
                                  height: orientation == Orientation.landscape
                                      ? MediaQuery
                                      .of(context)
                                      .size
                                      .height
                                      : MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(64, 75, 96, .9)),
                                  child: Opacity(
                                      opacity: opacity,
                                      child: CachedNetworkImage(imageUrl: imageToShow,
                                          fit: BoxFit.cover)),
                                )));
                      },
                    )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildButton(model.offeredItems[0], 0),
                            _buildButton(model.offeredItems[1], 1)
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildButton(model.offeredItems[2], 2),
                            _buildButton(model.offeredItems[3], 3)
                          ],
                        ),
                      ],
                    )
                  ],
                );
              },
            ))
    );
  }

  Widget _buildButton(SpeciesItem item, int index) {
    var state = model.offeredItemStates[index];
    var showSelectButton = _switchAnimation.selectButtonOpacity.value < 1;
    var hideSelectButton = _switchAnimation.selectButtonOpacity2.value > 0;
    var showCorrectButton = _switchAnimation.correctButtonOpacity.value > 0;
    Color buttonColor;

    if (index == this.selectedItemIndex &&
        (showSelectButton || hideSelectButton)) {
      buttonColor = Color.fromARGB(
          ((showSelectButton
              ? _switchAnimation.selectButtonOpacity.value
              : _switchAnimation.selectButtonOpacity2.value)
              * 255).toInt(),
          255,
          125,
          0);
    } else {
      if (state == STATE_ERROR) {
        buttonColor = Color.fromARGB(
            (_switchAnimation.correctButtonOpacity.value * 255).toInt(),
            255,
            0,
            0);
      } else if (state == STATE_CORRECT) {
        buttonColor = Color.fromARGB(
            (_switchAnimation.correctButtonOpacity.value * 255).toInt(),
            0,
            255,
            0);
      }
    }

    return Expanded(
      child: new SizedBox(
        height: 50,
        child: (state == STATE_NEUTRAL ||
            (_switchController.isAnimating && !showCorrectButton))
            ? OutlineButton(
          borderSide: BorderSide(color: Colors.grey[700]),
          textColor: Colors.white,
          child: new Text(
            item.name.getString(langCode),
          ),
          onPressed: _evaluationPending
              ? null
              : () {
            _onItemPressed(item, index);
          },
        )
            : FlatButton(
          textColor: Colors.white,
          color: buttonColor,
          child: new Text(
            item.name.getString(langCode),
          ),
          onPressed: () {},
        ),
      ),
    );
  }

  _onItemPressed(SpeciesItem item, int index) async {
    _evaluationPending = true;
    selectItem(item, index);
    _playAnimation().whenComplete(() {
      _evaluationPending = false;

      if (!model.goToNext()) {
        // go to summary page
        _navigateToEvalPage();
      }
    });
  }

  _navigateToEvalPage() {
    Navigator.of(context).pop();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return SummaryPage(model.itemsNum, model.failedItems, model.failedAnswers);
    }));
  }

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) =>
      new AlertDialog(
        title: new Text(SitLocalizations.of(context).exitdialog_title),
        content: new Text(SitLocalizations.of(context).exitdialog_message),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text(SitLocalizations.of(context).answer_no),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text(SitLocalizations.of(context).answer_yes),
          ),
        ],
      ),
    ) ?? false;
  }
}
