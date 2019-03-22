import 'dart:async';

import 'package:flutter/material.dart';
import 'package:memorizer/models/species_item.dart';
import 'dart:math';

import 'package:memorizer/pages/summary.dart';

const STATE_NEUTRAL = 1;
const STATE_ERROR = 2;
const STATE_CORRECT = 3;

class Practice extends StatefulWidget {
  Practice({Key key, this.title, this.items}) : super(key: key);


  final String title;
  List<SpeciesItem> items;
  List<SpeciesItem> failedItems = List();
  List<SpeciesItem> failedAnswers = List();
  int currentIndex = 0;
  int errors = 0;

  List<SpeciesItem> offeredItems = new List();
  var offeredItemStates = [STATE_NEUTRAL, STATE_NEUTRAL,STATE_NEUTRAL, STATE_NEUTRAL];
  var rnd = new Random();

  foldItems(){
    items.sort((a1, a2) => rnd.nextInt(2)-1);
  }

  bool goToNext() {
    if(currentIndex >= items.length-1) return false;

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
    offerIndices.sort((a1, a2) => rnd.nextInt(2)-1);

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
  _PracticeState createState() => new _PracticeState();
}

class _PracticeState extends State<Practice> {

  @override
  void initState() {
    super.initState();
    widget.foldItems();
    widget.currentIndex = -1;
    widget.goToNext();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.blueGrey,
        body: OrientationBuilder(
          builder: (context, orientation) {
            return Stack(
              children: <Widget>[
                Center(child: OrientationBuilder(
                  builder: (context, orientation) {
                    return Card(
                        elevation: 8.0,
                        color: Colors.grey,
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
                                  widget.items[widget.currentIndex].imageUrls
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
                        _buildButton(widget.offeredItems[0], 0),
                        _buildButton(widget.offeredItems[1], 1)
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildButton(widget.offeredItems[2], 2),
                        _buildButton(widget.offeredItems[3], 3)
                      ],
                    ),
                  ],
                )
              ],
            );
          },
        ));
  }


  Widget _buildButton(SpeciesItem item, int index){
    var state = widget.offeredItemStates[index];
    return Expanded(
      child: new SizedBox(
        height: 50,
        child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero),
          textColor: Colors.white,
          color: state == STATE_NEUTRAL ? Colors.black : state == STATE_ERROR ? Colors.red : Colors.green,
          child: new Text(
            item.name.getString("cs"),
          ),
          onPressed: () {
            widget.submitItem(item, index);
            setState(() {

            });
            Timer(Duration(milliseconds: 1000), () {
              setState(() => {});
              if(!widget.goToNext()) {
                // go to summary page
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                return SummaryPage(widget.errors, widget.items.length, widget.failedItems, widget.failedAnswers);}
                ));
              }
            });
          },
        ),
      ),
    );
  }
}
