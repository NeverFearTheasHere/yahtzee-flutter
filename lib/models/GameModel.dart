import 'dart:math';
import 'package:flutter/foundation.dart';

import 'DieModel.dart';

class GameModel extends ChangeNotifier {
  static Random random = new Random();

  List<DieModel> dice;

  void rollAllUnselectedDice() {
    var diceToRoll = dice.where((die) => !die.isSelectedToKeep);

    for (var die in diceToRoll) {
      die.value = random.nextInt(6) + 1;
    }

    notifyListeners();
  }

  GameModel() {
    dice = new List.generate(
        5,
        (i) => new DieModel(
            key: i,
            value: random.nextInt(6) + 1,
            isSelectedToKeep: false,
            notifyListeners: notifyListeners));
  }
}
