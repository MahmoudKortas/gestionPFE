// To parse this JSON data, do
//
//     final Departement = departementFromJson(jsonString);

import 'dart:convert';

List<Departement> departementFromJson(String str) =>
    List<Departement>.from(json.decode(str).map((x) => Departement.fromJson(x)));

String departementToJson(List<Departement> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson()))); 

class Departement {
  int? idDep;
  String? description;

  Departement(
      {this.idDep,
      this.description});

  Departement.fromJson(Map<String, dynamic> json) {
    idDep = json['idDep'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idDep'] = idDep;
    data['description'] = description;
    return data;
  }

  @override
  String toString() {
    return 'Departement(idDep: $idDep, description: $description)';
  }
}
