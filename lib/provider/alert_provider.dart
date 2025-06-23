import 'dart:developer';

import 'package:digifarmer/models/alert_model.dart';
import 'package:digifarmer/services/alert_service.dart';
import 'package:flutter/material.dart';

class AlertProvider extends ChangeNotifier {
  final List<Alert> _alerts = [];
  bool _isLoading = false;
  AlertService alertService = AlertService();

  Future<void> getAlerts() async {
    _isLoading = true;
    notifyListeners();

    final response = await alertService.fetchAlert();
    log('Response: ${response.length}');

    _isLoading = false;
    notifyListeners();
  }
}
