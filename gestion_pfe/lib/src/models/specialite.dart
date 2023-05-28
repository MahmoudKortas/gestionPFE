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
  String? Nom;

  Specialite(
      {this.idSpecialite,
      this.Nom});

  Specialite.fromJson(Map<String, dynamic> json) {
    idSpecialite = json['idSpecialite'];
    Nom = json['Nom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idSpecialite'] = idSpecialite;
    data['Nom'] = Nom;
    return data;
  }

  @override
  String toString() {
    return 'Specialite(idSpecialite: $idSpecialite, Nom: $Nom)';
  }
}
