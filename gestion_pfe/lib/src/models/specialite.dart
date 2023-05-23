// To parse this JSON data, do
//
//     final Specialite = specialiteFromJson(jsonString);

import 'dart:convert';

List<Specialite> specialiteFromJson(String str) =>
    List<Specialite>.from(json.decode(str).map((x) => Specialite.fromJson(x)));

String specialiteToJson(List<Specialite> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson()))); 

class Specialite {
  int? idSpecialite;
  String? description;

  Specialite(
      {this.idSpecialite,
      this.description});

  Specialite.fromJson(Map<String, dynamic> json) {
    idSpecialite = json['idSpecialite'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idSpecialite'] = idSpecialite;
    data['description'] = description;
    return data;
  }

  @override
  String toString() {
    return 'Specialite(idSpecialite: $idSpecialite, description: $description)';
  }
}
