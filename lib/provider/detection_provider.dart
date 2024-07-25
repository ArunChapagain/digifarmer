import 'package:digifarmer/services/diseases_detail_service.dart';
import 'package:flutter/foundation.dart';

class DetectionProvider extends ChangeNotifier {
  bool _isDetecting = false;
  String _class = '';
  String _details = '';
  Map<String, dynamic> json = {};

  void getDetectionDetail(String plant, String disease) async {
    print('Plant: $plant, Disease: $disease');
    setDetection = true;
    json = await DiseasesDetailService.findDiagnose(plant, disease);
    print(json);
    _class = json['class'] ?? '';
    _details = json['description'] ?? '';
    setDetection = false;
  }

  set setDetection(bool value) {
    _isDetecting = value;
    notifyListeners();
  }

  bool get isDetectionLoading => _isDetecting;
  String get classDetection => _class;
  String get details => _details;
}
