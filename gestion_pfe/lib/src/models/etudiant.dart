// To parse this JSON data, do
//
//     final etudiant = etudiantFromJson(jsonString);

import 'dart:convert';

import 'package:gestion_pfe/src/models/departement.dart';
import 'package:gestion_pfe/src/models/specialite.dart';

List<Etudiant> etudiantFromJson(String str) =>
    List<Etudiant>.from(json.decode(str).map((x) => Etudiant.fromJson(x)));

String etudiantToJson(List<Etudiant> data) =>
    json.encode(List<Etudiant>.from(data.map((x) => x.toJson())));

class Etudiant {
  Etudiant({
    this.idEtud,
    this.nom,
    this.prenom,
    this.tel,
    this.adresse,
    this.niveau,
    this.email,
    this.motdepasse,
    this.specialite,
    this.departement,
  });

  int? idEtud;
  String? nom;
  String? prenom;
  int? tel;
  String? adresse;
  String? niveau;
  String? email;
  String? motdepasse;
  Specialite? specialite;
  Departement? departement;

  factory Etudiant.fromJson(Map<String, dynamic> json) => Etudiant(
        idEtud: json["idEtud"],
        nom: json["nom"],
        prenom: json["prenom"],
        tel: json["tel"],
        adresse: json["adresse"],
        niveau: json["niveau"],
        email: json["email"],
        motdepasse: json["motdepasse"],
        specialite: json['specialite'] != null
            ? Specialite.fromJson(json['specialite'])
            : null,
        departement: json['departement'] != null
            ? Departement.fromJson(json['departement'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "idEtud": idEtud,
        "nom": nom,
        "prenom": prenom,
        "tel": tel,
        "adresse": adresse,
        "niveau": niveau,
        "email": email,
        "motdepasse": motdepasse,
        "specialite": specialite,
        "departement": departement,
      };
  @override
  String toString() {
    return 'Etudiant(idEtud: $idEtud, nom: $nom, prenom: $prenom, tel: $tel, adresse: $adresse, niveau: $niveau, email: $email, motdepasse: $motdepasse, specialite: $specialite, departement: $departement)';
  }
}
