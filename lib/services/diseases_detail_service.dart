import 'dart:convert';
import 'package:flutter/services.dart';

class DiseasesDetailService {
//to add the model details in json file and load it in hive
  static late dynamic detectDetailsJson;
  static Future<void> loadJson() async {
    var data = await rootBundle.loadString('assets/disease_details.json');
    detectDetailsJson = json.decode(data);
  }

  static Future<Map<String, dynamic>> findDiagnose(
      String plant, String name) async {
    plant = plant.split(' ').first;
    var plantData =
        detectDetailsJson.firstWhere((element) => element['plant'] == plant);
    var diagnoseList = plantData['diagnose'];
    print(plantData);
    return diagnoseList.firstWhere((diagnose) => diagnose['name'] == name);
    // return null;
  }
}
