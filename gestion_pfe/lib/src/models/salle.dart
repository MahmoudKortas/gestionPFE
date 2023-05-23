// To parse this JSON data, do
//
//     final Salle = salleFromJson(jsonString);

import 'dart:convert';

List<Salle> salleFromJson(String str) =>
    List<Salle>.from(json.decode(str).map((x) => Salle.fromJson(x)));

String salleToJson(List<Salle> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson()))); 

class Salle {
  int? idSalle;
  String? nom;

  Salle(
      {this.idSalle,
      this.nom});

  Salle.fromJson(Map<String, dynamic> json) {
    idSalle = json['idSalle'];
    nom = json['nom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idSalle'] = idSalle;
    data['nom'] = nom;
    return data;
  }

  @override
  String toString() {
    return 'Salle(idSalle: $idSalle, nom: $nom)';
  }
}
