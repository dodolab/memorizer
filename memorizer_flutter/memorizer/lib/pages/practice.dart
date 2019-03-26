import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:memorizer/models/species_item.dart';
import 'dart:math';

import 'package:memorizer/pages/summary.dart';
import 'package:memorizer/utils/style.dart';
import 'package:memorizer/utils/switch_animation.dart';
import 'package:memorizer/utils/utils.dart';

const STATE_NEUTRAL = 1;
const STATE_ERROR = 2;
const STATE_CORRECT = 3;

class Practice extends StatefulWidget {
  Practice({Key key, this.itemsNum, this.items}) : super(key: key);
  int itemsNum;
  List<SpeciesItem> items;

  @override
  _PracticeState createState() =>
      new _PracticeState(itemsNum: itemsNum, items: items);
}

class _PracticeState extends State<Practice> with TickerProviderStateMixin {
  AnimationController _switchController;
  SwitchAnimation _switchAnimation;

  bool _evaluationPending = false;
  List<SpeciesItem> items;
  int itemsNum;
  List<SpeciesItem> failedItems = List();
  List<SpeciesItem> failedAnswers = List();
  int currentIndex = 0;
  List<SpeciesItem> offeredItems = new List();
  var offeredItemStates = [
    STATE_NEUTRAL,
    STATE_NEUTRAL,
    STATE_NEUTRAL,
    STATE_NEUTRAL
  ];
  int selectedItemIndex = 0;

  var rnd = new Random();

  _PracticeState({this.itemsNum, this.items});

  @override
  void initState() {
    super.initState();
    _switchController = new AnimationController(
        duration: new Duration(milliseconds: 2000), vsync: this);
    _switchAnimation = new SwitchAnimation(_switchController);
    shuffle(items);
    currentIndex = -1;

    goToNext();
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

  bool _canGoNext() {
    return (currentIndex < itemsNum - 1);
  }

  bool goToNext() {
    if (!_canGoNext()) return false;

    offeredItemStates = [
      STATE_NEUTRAL,
      STATE_NEUTRAL,
      STATE_NEUTRAL,
      STATE_NEUTRAL
    ];
    currentIndex++;

    var offerIndices = [];
    offerIndices.add(currentIndex);

    while (true) {
      var next = rnd.nextInt(items.length - 1);
      if (!offerIndices.contains(next)) {
        offerIndices.add(next);
      }
      if (offerIndices.length == 4) break;
    }

    shuffle(offerIndices);

    offeredItems.clear();
    offerIndices.forEach((idx) {
      offeredItems.add(items[idx]);
    });
    return true;
  }

  submitItem(SpeciesItem item, int index) {
    var correctItem = items[currentIndex];
    var isCorrect = item == correctItem;
    offeredItemStates[index] = isCorrect ? STATE_CORRECT : STATE_ERROR;
    selectedItemIndex = index;

    if (!isCorrect) {
      failedItems.add(correctItem);
      failedAnswers.add(item);
      // find correct item
      for (var i = 0; i < offeredItems.length; i++) {
        if (offeredItems[i] == correctItem) {
          offeredItemStates[i] = STATE_CORRECT;
          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
      animation: _switchController,
      builder: _buildContent,
    );
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
                  } else {
                    opacity = _switchAnimation.nextImageOpacity.value;
                  }
                }

                var imageToShow = (_switchController.isAnimating &&
                    _switchAnimation.previousImageOpacity.value == 0 &&
                    _canGoNext())
                    ? items[currentIndex + 1].imageUrls.first
                    : items[currentIndex].imageUrls.first;

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
                                      child: Image.network(imageToShow,
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
                            _buildButton(offeredItems[0], 0),
                            _buildButton(offeredItems[1], 1)
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildButton(offeredItems[2], 2),
                            _buildButton(offeredItems[3], 3)
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
    var state = offeredItemStates[index];
    var showSelectButton = _switchAnimation.selectButtonOpacity.value < 1;
    var hideSelectButton = _switchAnimation.selectButtonOpacity2.value > 0;
    var showCorrectButton = _switchAnimation.correctButtonOpacity.value > 0;
    var displayResults = _switchAnimation.selectButtonOpacity2.value != 0;
    var displayNextImage = _switchAnimation.nextImageOpacity.value != 0;
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
            item.name.getString("cs"),
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
            item.name.getString("cs"),
          ),
          onPressed: () {},
        ),
      ),
    );
  }

  _onItemPressed(SpeciesItem item, int index) async {
    _evaluationPending = true;
    submitItem(item, index);
    _playAnimation().whenComplete(() {
      _evaluationPending = false;

      if (!goToNext()) {
        // go to summary page
        _navigateToEvalPage();
      }
    });
  }

  _navigateToEvalPage() {
    Navigator.of(context).pop();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return SummaryPage(itemsNum, failedItems, failedAnswers);
    }));
  }

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) =>
      new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit the test'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    ) ?? false;
  }
}
