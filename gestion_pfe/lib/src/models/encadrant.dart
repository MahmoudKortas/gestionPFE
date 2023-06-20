// To parse this JSON data, do
//
//     final encadrant = encadrantFromJson(jsonString);

import 'dart:convert';

import 'package:gestion_pfe/src/models/departement.dart';

List<Encadrant> encadrantFromJson(String str) =>
    List<Encadrant>.from(json.decode(str).map((x) => Encadrant.fromJson(x)));

String encadrantToJson(List<Encadrant> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Encadrant {
  Encadrant({
    this.idEns,
    this.nom,
    this.prenom,
    this.tel,
    this.adresse,
    this.domaine,
    this.email,
    this.motdepasse,
    this.departement,
  });

  int? idEns;
  String? nom;
  String? prenom;
  int? tel;
  String? adresse;
  String? domaine;
  String? email;
  String? motdepasse;
  Departement? departement;

  factory Encadrant.fromJson(Map<String, dynamic> json) => Encadrant(
        idEns: json["idEns"],
        nom: json["nom"],
        prenom: json["prenom"],
        tel: json["tel"],
        adresse: json["adresse"],
        domaine: json["domaine"],
        email: json["email"],
        motdepasse: json["motdepasse"],
        departement: json['departement'] != null
            ? Departement.fromJson(json['departement'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "idEns": idEns,
        "nom": nom,
        "prenom": prenom,
        "tel": tel,
        "adresse": adresse,
        "domaine": domaine,
        "email": email,
        "motdepasse": motdepasse,
        "departement": departement,
      };
  @override
  String toString() {
    return 'Encadrant(idEns: $idEns, nom: $nom, prenom: $prenom, tel: $tel, adresse: $adresse, domaine: $domaine, email: $email, motdepasse: $motdepasse, departement: $departement)';
  }
}
