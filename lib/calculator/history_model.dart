import 'package:flutter/material.dart';

class HistoryModel extends ChangeNotifier {
  List<String> _calculations = [];

  List<String> get calculations => _calculations;

  void addCalculation(String calculation) {
    _calculations.add(calculation);
    notifyListeners();
  }

  void clearHistory() {
    _calculations.clear();
    notifyListeners();
  }
}
