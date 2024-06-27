// To parse this JSON data, do
//
//     final plantDiagnosis = plantDiagnosisFromJson(jsonString);

import 'dart:convert';

List<PlantDiagnosis> plantDiagnosisFromJson(String str) => List<PlantDiagnosis>.from(json.decode(str).map((x) => PlantDiagnosis.fromJson(x)));

String plantDiagnosisToJson(List<PlantDiagnosis> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlantDiagnosis {
    String plant;
    List<Diagnose> diagnose;

    PlantDiagnosis({
        required this.plant,
        required this.diagnose,
    });

    factory PlantDiagnosis.fromJson(Map<String, dynamic> json) => PlantDiagnosis(
        plant: json["plant"],
        diagnose: List<Diagnose>.from(json["diagnose"].map((x) => Diagnose.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "plant": plant,
        "diagnose": List<dynamic>.from(diagnose.map((x) => x.toJson())),
    };
}

class Diagnose {
    String name;
    Class diagnoseClass;
    String description;

    Diagnose({
        required this.name,
        required this.diagnoseClass,
        required this.description,
    });

    factory Diagnose.fromJson(Map<String, dynamic> json) => Diagnose(
        name: json["name"],
        diagnoseClass: classValues.map[json["class"]]!,
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "class": classValues.reverse[diagnoseClass],
        "description": description,
    };
}

enum Class {
    BACTERIA,
    EMPTY,
    FUNGUS,
    INSECT,
    VIRUS
}

final classValues = EnumValues({
    "Bacteria": Class.BACTERIA,
    "": Class.EMPTY,
    "Fungus": Class.FUNGUS,
    "Insect": Class.INSECT,
    "Virus": Class.VIRUS
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
