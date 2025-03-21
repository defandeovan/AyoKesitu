import 'package:flutter/material.dart';

class LoadingController extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void startLoading() {
    _isLoading = true;
    notifyListeners();

    Future.delayed(Duration(seconds: 5), () {
      _isLoading = false;
      notifyListeners();
    });
  }
}
