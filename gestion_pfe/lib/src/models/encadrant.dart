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
    this.idEnc,
    this.nom,
    this.prenom,
    this.tel,
    this.adresse,
    this.email,
    this.motdepasse,
    this.domaine,
    this.departement,
  });

  int? idEnc;
  String? nom;
  String? prenom;
  int? tel;
  String? adresse;
  String? domaine;
  String? email;
  String? motdepasse;
  Departement? departement;

  Encadrant.fromJson(Map<String, dynamic> json) {
    idEnc = json["idEnc"];
    nom = json["nom"];
    prenom = json["prenom"];
    tel = json["tel"];
    adresse = json["adresse"];
    domaine = json["domaine"];
    email = json["email"];
    motdepasse = json["motdepasse"];
    departement = json['departement'] != null
        ? Departement.fromJson(json['departement'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idEnc'] = idEnc;
    data['nom'] = nom;
    data['prenom'] = prenom;
    data['tel'] = tel;
    data['adresse'] = adresse;
    data['domaine'] = domaine;
    data['email'] = email;
    data['motdepasse'] = motdepasse;
    data['departement'] = departement;
    return data;
  }

  @override
  String toString() {
    return 'Encadrant(idEnc: $idEnc, nom: $nom, prenom: $prenom, tel: $tel, adresse: $adresse, domaine: $domaine, email: $email, motdepasse: $motdepasse, departement: $departement)';
  }
}
