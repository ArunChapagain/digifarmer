// To parse this JSON data, do
//
//     final alert = alertFromJson(jsonString);

import 'dart:convert';

AlertModel alertFromJson(String str) => AlertModel.fromJson(json.decode(str));

String alertToJson(AlertModel data) => json.encode(data.toJson());

class AlertModel {
  final double? count;
  final String? next;
  final dynamic previous;
  final List<Alert>? results;

  AlertModel({this.count, this.next, this.previous, this.results});

  factory AlertModel.fromJson(Map<String, dynamic> json) => AlertModel(
    count: json["count"]?.toDouble(),
    next: json["next"],
    previous: json["previous"],
    results:
        json["results"] == null
            ? []
            : List<Alert>.from(
              json["results"]!.map((x) => Alert.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results":
        results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
  };
}

class Alert {
  final int? id;
  final String? title;
  final List<int>? wards;
  final Point? point;
  final DateTime? createdOn;
  final dynamic titleNe;
  final String? source;
  final String? description;
  final bool? verified;
  final bool? public;
  final DateTime? startedOn;
  final DateTime? expireOn;
  final Polygon? polygon;
  final dynamic referenceType;
  final dynamic referenceData;
  final dynamic referenceId;
  final dynamic region;
  final dynamic regionId;
  final dynamic createdBy;
  final dynamic updatedBy;
  final int? hazard;
  final int? event;

  Alert({
    this.id,
    this.title,
    this.wards,
    this.point,
    this.createdOn,
    this.titleNe,
    this.source,
    this.description,
    this.verified,
    this.public,
    this.startedOn,
    this.expireOn,
    this.polygon,
    this.referenceType,
    this.referenceData,
    this.referenceId,
    this.region,
    this.regionId,
    this.createdBy,
    this.updatedBy,
    this.hazard,
    this.event,
  });

  factory Alert.fromJson(Map<String, dynamic> json) => Alert(
    id: json["id"],
    title: json["title"],
    wards:
        json["wards"] == null
            ? []
            : List<int>.from(json["wards"]!.map((x) => x)),
    point: json["point"] == null ? null : Point.fromJson(json["point"]),
    createdOn:
        json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
    titleNe: json["titleNe"],
    source: json["source"],
    description: json["description"],
    verified: json["verified"],
    public: json["public"],
    startedOn:
        json["startedOn"] == null ? null : DateTime.parse(json["startedOn"]),
    expireOn:
        json["expireOn"] == null ? null : DateTime.parse(json["expireOn"]),
    polygon: json["polygon"] == null ? null : Polygon.fromJson(json["polygon"]),
    referenceType: json["referenceType"],
    referenceData: json["referenceData"],
    referenceId: json["referenceId"],
    region: json["region"],
    regionId: json["regionId"],
    createdBy: json["createdBy"],
    updatedBy: json["updatedBy"],
    hazard: json["hazard"],
    event: json["event"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "wards": wards == null ? [] : List<dynamic>.from(wards!.map((x) => x)),
    "point": point?.toJson(),
    "createdOn": createdOn?.toIso8601String(),
    "titleNe": titleNe,
    "source": source,
    "description": description,
    "verified": verified,
    "public": public,
    "startedOn": startedOn?.toIso8601String(),
    "expireOn": expireOn?.toIso8601String(),
    "polygon": polygon?.toJson(),
    "referenceType": referenceType,
    "referenceData": referenceData,
    "referenceId": referenceId,
    "region": region,
    "regionId": regionId,
    "createdBy": createdBy,
    "updatedBy": updatedBy,
    "hazard": hazard,
    "event": event,
  };
}

class Point {
  final String? type;
  final List<double>? coordinates;

  Point({this.type, this.coordinates});

  factory Point.fromJson(Map<String, dynamic> json) => Point(
    type: json["type"],
    coordinates:
        json["coordinates"] == null
            ? []
            : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates":
        coordinates == null
            ? []
            : List<dynamic>.from(coordinates!.map((x) => x)),
  };
}

class Polygon {
  final String? type;
  final List<List<List<List<double>>>>? coordinates;

  Polygon({this.type, this.coordinates});

  factory Polygon.fromJson(Map<String, dynamic> json) => Polygon(
    type: json["type"],
    coordinates:
        json["coordinates"] == null
            ? []
            : List<List<List<List<double>>>>.from(
              json["coordinates"]!.map(
                (x) => List<List<List<double>>>.from(
                  x.map(
                    (x) => List<List<double>>.from(
                      x.map(
                        (x) => List<double>.from(x.map((x) => x?.toDouble())),
                      ),
                    ),
                  ),
                ),
              ),
            ),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates":
        coordinates == null
            ? []
            : List<dynamic>.from(
              coordinates!.map(
                (x) => List<dynamic>.from(
                  x.map(
                    (x) => List<dynamic>.from(
                      x.map((x) => List<dynamic>.from(x.map((x) => x))),
                    ),
                  ),
                ),
              ),
            ),
  };
}
