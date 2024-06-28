import 'dart:convert';
import 'package:flutter/services.dart';

class  DiseasesDetailService{
  

//to add the model details in json file and load it in hive
 static Future<dynamic> loadJson() async {
  String jsonString =
      await rootBundle.loadString('assets/disease_details.json');
  return jsonDecode(jsonString);
  
}


static Future< Map<String, dynamic>?> findDiagnose(String plant, String name)async {
  var data = await loadJson();
    var plantData = data.firstWhere((element) => element['plant'] == plant, orElse: () => null);
    if (plantData != null) {
      var diagnoseList = plantData['diagnose'];
      return diagnoseList.firstWhere((diagnose) => diagnose['name'] == name, orElse: () => null);
    }
    return null;
  }
}