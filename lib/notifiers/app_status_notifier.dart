import 'package:book_app/pages/home_page.dart';
import 'package:flutter/material.dart';

class AppStatusNotifier extends ChangeNotifier {
  Status _status = Status.animeManga;
  Status get status => _status;

  void updateView(int index) {
    _status = Status.values[index];
    notifyListeners();
  }
}

