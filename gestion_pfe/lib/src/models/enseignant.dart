// To parse this JSON data, do
//
//     final enseignant = enseignantFromJson(jsonString);

import 'dart:convert';

import 'package:gestion_pfe/src/models/departement.dart';

List<Enseignant> enseignantFromJson(String str) =>
    List<Enseignant>.from(json.decode(str).map((x) => Enseignant.fromJson(x)));

String enseignantToJson(List<Enseignant> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Enseignant {
  Enseignant({
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

  factory Enseignant.fromJson(Map<String, dynamic> json) => Enseignant(
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
    return 'Enseignant(idEns: $idEns, nom: $nom, prenom: $prenom, tel: $tel, adresse: $adresse, domaine: $domaine, email: $email, motdepasse: $motdepasse, departement: $departement)';
  }
}
