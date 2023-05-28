import 'dart:convert';

import 'package:gestion_pfe/src/models/departement.dart';

List<Responsable> responsableFromJson(String str) => List<Responsable>.from(
    json.decode(str).map((x) => Responsable.fromJson(x)));

String responsableToJson(List<Responsable> data) =>
    json.encode(List<Responsable>.from(data.map((x) => x.toJson())));

class Responsable {
  int? idUser;
  String? email;//
  String? motdepasse;//
  Departement? departement;
  String? tel;//
  String? prenom;//
  String? nom;//
  String? Date_responsabilite;//

  Responsable(
      {this.idUser,
      this.email,
      this.motdepasse,
      this.departement,
      this.tel,
      this.prenom,
      this.nom,
      this.Date_responsabilite});

  Responsable.fromJson(Map<String, dynamic> json) {
    idUser = json['idUser'];
    email = json['email'];
    motdepasse = json['motdepasse'];
    departement = Departement.fromJson(json['departement']);
    tel = json['tel'];
    prenom = json['prenom'];
    nom = json['nom'];
    Date_responsabilite = json['Date_responsabilite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idUser'] = idUser;
    data['email'] = email;
    data['motdepasse'] = motdepasse;
    data['departement'] = departement?.idDep;
    data['tel'] = tel;
    data['prenom'] = prenom;
    data['nom'] = nom;
    data['Date_responsabilite'] = Date_responsabilite;
    return data;
  }

  @override
  String toString() {
    return 'Responsable(idUser: $idUser, email: $email, motdepasse: $motdepasse, departement: $departement, tel: $tel, prenom: $prenom, nom: $nom, Date_responsabilite: $Date_responsabilite)';
  }
}
