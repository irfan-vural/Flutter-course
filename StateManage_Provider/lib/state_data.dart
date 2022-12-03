import 'package:flutter/material.dart';

class StateData extends ChangeNotifier {
  String sehir = 'Adana';

  void newCity(String city) {
    sehir = city;
    notifyListeners();
  }
}
