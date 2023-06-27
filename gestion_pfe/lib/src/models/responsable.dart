import 'dart:convert';

import 'package:gestion_pfe/src/models/departement.dart';

List<Responsable> responsableFromJson(String str) => List<Responsable>.from(
    json.decode(str).map((x) => Responsable.fromJson(x)));

String responsableToJson(List<Responsable> data) =>
    json.encode(List<Responsable>.from(data.map((x) => x.toJson())));

class Responsable {
  int? idUser;
  String? email; //
  String? motdepasse; //
  String? tel; //
  String? prenom; //
  String? nom; //
  String? dateResponsabilite; //
  Departement? departement;

  Responsable({
    this.idUser,
    this.email,
    this.motdepasse,
    this.tel,
    this.prenom,
    this.nom,
    this.dateResponsabilite,
    this.departement,
  });

  factory Responsable.fromJson(Map<String, dynamic> json) => Responsable(
        idUser: json['idUser'],
        email: json['email'],
        motdepasse: json['motdepasse'],
        tel: json['tel'],
        prenom: json['prenom'],
        nom: json['nom'],
        dateResponsabilite: json['Dateresponsabilite'],
        departement: json['departement'] != null
            ? Departement.fromJson(json['departement'])
            : null,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idUser'] = idUser;
    data['email'] = email;
    data['motdepasse'] = motdepasse;
    data['tel'] = tel;
    data['prenom'] = prenom;
    data['nom'] = nom;
    data['Dateresponsabilite'] = dateResponsabilite;
    data['departement'] = departement?.idDep;
    return data;
  }

  @override
  String toString() {
    return 'Responsable(idUser: $idUser, email: $email, motdepasse: $motdepasse, departement: $departement, tel: $tel, prenom: $prenom, nom: $nom, Dateresponsabilite: $dateResponsabilite)';
  }
}
