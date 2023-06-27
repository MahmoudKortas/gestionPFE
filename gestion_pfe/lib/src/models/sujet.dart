// To parse this JSON data, do
//
//     final sujet = sujetFromJson(jsonString);

import 'dart:convert';

import 'package:gestion_pfe/src/models/encadrant.dart';
import 'package:gestion_pfe/src/models/etudiant.dart';
import 'package:gestion_pfe/src/models/responsable.dart';

List<Sujet> sujetFromJson(String str) =>
    List<Sujet>.from(json.decode(str).map((x) => Sujet.fromJson(x)));

String sujetToJson(List<Sujet> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
String sujetToJsonn(List<Sujet> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sujet {
  int? idSujet;
  String? titre;
  String? description;
  String? date; 
  Etudiant? etudiant;
  Responsable? responsable;
  Encadrant? encadrant;

  Sujet(
      {this.idSujet,
      this.titre,
      this.description,
      this.date, 
      this.etudiant,
      this.responsable,
      this.encadrant});

  Sujet.fromJson(Map<String, dynamic> json) {
    idSujet = json['idSujet'];
    titre = json['titre'];
    description = json['description'];
    date = json['date']; 
    etudiant =
        json['etudiant'] != null ? Etudiant.fromJson(json['etudiant']) : null;
    responsable = json['responsable'] != null
        ? Responsable.fromJson(json['responsable'])
        : null;
    encadrant = json['encadrant'] != null
        ? Encadrant.fromJson(json['encadrant'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idSujet'] = idSujet;
    data['titre'] = titre;
    data['description'] = description;
    data['date'] = date; 
    data['etudiant'] = etudiant?.idEtud;
    data['responsable'] = responsable?.idUser;
    data['encadrant'] = encadrant?.idEnc;
    return data;
  }

  @override
  String toString() {
    return 'Sujet(idSujet: $idSujet, titre: $titre, description: $description, date: $date, etudiant: $etudiant, responsable: $responsable, encadrant: $encadrant)';
  }
}
