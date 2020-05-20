import 'dart:math';
import 'package:flutter/foundation.dart';

import 'DieModel.dart';

class GameModel extends ChangeNotifier {
  static Random random = new Random();

  List<DieModel> dice;
  int numberOfRollsTaken;

  void rollAllUnselectedDice() {
    if (!canRollDice()) {
      return;
    }
    var diceToRoll = dice.where((die) => !die.isSelectedToKeep);

    for (var die in diceToRoll) {
      die.value = random.nextInt(6) + 1;
    }

    numberOfRollsTaken += 1;
    if (numberOfRollsTaken == 3) {

      for (var die in dice) {
        die.isSelectedToKeep = false;
        die.canChangeSelection = false;
      }

    }
    notifyListeners();
  }

  bool canRollDice() {
    return numberOfRollsTaken < 3 && dice.any((die) => !die.isSelectedToKeep);
  }

  GameModel() {
    numberOfRollsTaken = 1;
    dice = new List.generate(
        5,
        (i) => new DieModel(
            key: i,
            value: random.nextInt(6) + 1,
            isSelectedToKeep: false,
            notifyListeners: notifyListeners));
  }
}
