
import 'dart:math';

import 'package:memorizer/entities/species_item.dart';
import 'package:memorizer/utils/utils.dart';

const STATE_NEUTRAL = 1;
const STATE_ERROR = 2;
const STATE_CORRECT = 3;

class PracticeModel {
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
  var rnd = new Random();

  PracticeModel({this.itemsNum, this.items});

  void init() {
    shuffle(items);
    currentIndex = -1;
    goToNext();
  }

  bool canGoNext() {
    return (currentIndex < itemsNum - 1);
  }

  bool goToNext() {
    if (!canGoNext()) return false;

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
}