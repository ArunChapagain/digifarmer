import 'dart:developer';

import 'package:digifarmer/models/alert_model.dart';
import 'package:digifarmer/services/alert_service.dart';
import 'package:flutter/material.dart';

class AlertProvider extends ChangeNotifier {
  List<Alert> _alerts = [];
  List<Alert> _filteredAlerts = [];
  bool _isLoading = false;
  AlertService alertService = AlertService();

  List<Alert> get alerts => _alerts;
  List<Alert> get filteredAlerts => _filteredAlerts;
  bool get isLoading => _isLoading;

  Future<void> getAlerts() async {
    _isLoading = true;
    notifyListeners();

    final response = await alertService.fetchAlert();
    // _alerts = response;
    _filterAlertsLast36Hours(response);

    _isLoading = false;
    notifyListeners();
  }

  void _filterAlertsLast36Hours(List<Alert>? alerts) {
    final now = DateTime.now();
    final cutoffTime = now.subtract(const Duration(hours: 36));

    _filteredAlerts =
        alerts!.where((alert) {
          if (alert.startedOn != null) {
            return alert.startedOn!.isAfter(cutoffTime);
          }
          return false;
        }).toList();

    // Sort by creation date (newest first)
    _filteredAlerts.sort((a, b) {
      if (a.startedOn == null && b.startedOn == null) return 0;
      if (a.startedOn == null) return 1;
      if (b.startedOn == null) return -1;
      return b.startedOn!.compareTo(a.startedOn!);
    });

    _alerts = _filteredAlerts;

    log(
      'Filtered ${_filteredAlerts.length} alerts from last 36 hours out of ${_alerts.length} total alerts',
    );
  }

  // Method to manually refresh the filter if needed
  void refreshFilter() {
    _filterAlertsLast36Hours([]);
    notifyListeners();
  }
}
