import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkCheckerProvider extends ChangeNotifier {
  InternetConnectionStatus _status = InternetConnectionStatus.disconnected;

  void listenNetwork(VoidCallback function) {
    InternetConnectionCheckerPlus().onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.connected &&
          _status == InternetConnectionStatus.disconnected) {
        _status = status;
        function();
      } else {
        _status = status;
      }
      notifyListeners();
    });
  }

  InternetConnectionStatus get state => _status;
}
