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
  String? nom;

  Departement(
      {this.idDep,
      this.nom});

  Departement.fromJson(Map<String, dynamic> json) {
    idDep = json['idDep'];
    nom = json['nom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idDep'] = idDep;
    data['nom'] = nom;
    return data;
  }

  @override
  String toString() {
    return 'Departement(idDep: $idDep, nom: $nom)';
  }
}
