import 'dart:async';

import 'package:flutter/material.dart';
import 'package:memorizer/models/species_item.dart';
import 'dart:math';

import 'package:memorizer/pages/summary.dart';
import 'package:memorizer/utils/style.dart';
import 'package:memorizer/utils/utils.dart';

const STATE_NEUTRAL = 1;
const STATE_ERROR = 2;
const STATE_CORRECT = 3;

class Practice extends StatefulWidget {
  Practice({Key key, this.itemsNum, this.items}) : super(key: key);
  int itemsNum;
  List<SpeciesItem> items;

  @override
  _PracticeState createState() => new _PracticeState(itemsNum: itemsNum, items: items);
}

class _PracticeState extends State<Practice> {

  List<SpeciesItem> items;
  int itemsNum;
  List<SpeciesItem> failedItems = List();
  List<SpeciesItem> failedAnswers = List();
  int currentIndex = 0;
  int errors = 0;
  List<SpeciesItem> offeredItems = new List();
  var offeredItemStates = [STATE_NEUTRAL, STATE_NEUTRAL,STATE_NEUTRAL, STATE_NEUTRAL];
  var rnd = new Random();

  _PracticeState({this.itemsNum, this.items});

  @override
  void initState() {
    super.initState();
    shuffle(items);
    currentIndex = -1;
    goToNext();
  }

  bool goToNext() {
    if(currentIndex >= itemsNum-1) return false;

    offeredItemStates = [STATE_NEUTRAL, STATE_NEUTRAL,STATE_NEUTRAL, STATE_NEUTRAL];
    currentIndex++;

    var offerIndices = [];
    offerIndices.add(currentIndex);

    while(true){
      var next = rnd.nextInt(items.length-1);
      if(!offerIndices.contains(next)){
        offerIndices.add(next);
      }
      if(offerIndices.length == 4) break;
    }

    shuffle(offerIndices);

    offeredItems.clear();
    offerIndices.forEach((idx){
      offeredItems.add(items[idx]);
    });
    return true;
  }

  submitItem(SpeciesItem item, int index) {
    var correctItem = items[currentIndex];
    var isCorrect = item == correctItem;
    offeredItemStates[index] = isCorrect ? STATE_CORRECT : STATE_ERROR;

    if(!isCorrect){
      errors++;
      failedItems.add(item);
      // find correct item
      for(var i=0; i<offeredItems.length; i++){
        if(offeredItems[i] == correctItem){
          offeredItemStates[i] = STATE_CORRECT;
          break;
        }
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: defaultBgr,
        body: OrientationBuilder(
          builder: (context, orientation) {
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
                                  ? MediaQuery.of(context).size.width
                                  : MediaQuery.of(context).size.height,
                              height: orientation == Orientation.landscape
                                  ? MediaQuery.of(context).size.height
                                  : MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(64, 75, 96, .9)),
                              child: Image.network(
                                  items[currentIndex].imageUrls
                                      .first,
                                  fit: BoxFit.cover),
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
        ));
  }


  Widget _buildButton(SpeciesItem item, int index) {
    var state = offeredItemStates[index];
    return Expanded(
      child: new SizedBox(
        height: 50,
        child: state == STATE_NEUTRAL ? OutlineButton (
          borderSide: BorderSide(color: Colors.grey[700]),
          textColor: Colors.white,
          color:  state == STATE_NEUTRAL ? Colors.black: state == STATE_ERROR ? Colors.red : Colors.green,
          child: new Text(
            item.name.getString("cs"),
          ),
          onPressed: () {_onItemPressed(item, index);},
        ) :
        FlatButton (
          textColor: Colors.white,
          color:  state == STATE_ERROR ? Colors.red : Colors.green,
          child: new Text(
            item.name.getString("cs"),
          ),
          onPressed: () {_onItemPressed(item, index);},
        ),
      ),
    );
  }

  _onItemPressed(SpeciesItem item, int index){
    submitItem(item, index);
    setState(() { });
    Timer(Duration(milliseconds: 1000), () {
      setState(() => {});
      if(!goToNext()) {
        // go to summary page
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return SummaryPage(errors, items.length, failedItems, failedAnswers);}
        ));
      }
    });
  }
}
