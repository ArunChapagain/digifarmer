import 'package:digifarmer/services/diseases_detail_service.dart';
import 'package:flutter/foundation.dart';

class DetectionProvider extends ChangeNotifier {
  bool _isDetection = false;
  String _class = '';
  String _details = '';
  var  json;

void getDetectionDetail(String plant, String disease)async {
  _isDetection = true;
  json= await DiseasesDetailService.findDiagnose(plant, disease);
 _class = json!['class'];
  _details = json['details'];
  _isDetection = false;
    notifyListeners();
  }



  bool get isDetection => _isDetection;
  String get classDetection => _class;
  String get details => _details;

}
