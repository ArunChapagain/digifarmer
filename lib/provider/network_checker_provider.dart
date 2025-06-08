import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkCheckerProvider extends ChangeNotifier {
  InternetStatus _status = InternetStatus.disconnected;

  void listenNetwork(VoidCallback function) {
    InternetConnection().onStatusChange.listen((status) {
      if (status == InternetStatus.connected &&
          _status == InternetStatus.disconnected) {
        _status = status;
        function();
      } else {
        _status = status;
      }
      notifyListeners();
    });
  }

  InternetStatus get status => _status;
}
