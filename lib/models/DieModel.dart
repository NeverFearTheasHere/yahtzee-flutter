import 'package:flutter/foundation.dart';

class DieModel {
  int key;
  int value;
  bool isSelectedToKeep;
  bool canChangeSelection = true;
  Function notifyListeners;

  DieModel({
    @required this.key,
    @required this.value,
    @required this.isSelectedToKeep,
    @required this.notifyListeners,
  });

  void toggleSelected() {
    if (!canChangeSelection) {
      return;
    }
    if (isSelectedToKeep) {
      isSelectedToKeep = false;
    } else {
      isSelectedToKeep = true;
    }

    notifyListeners();
  }
}
