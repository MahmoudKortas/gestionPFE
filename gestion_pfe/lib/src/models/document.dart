// To parse this JSON data, do
//
//     final document = documentFromJson(jsonString);

import 'dart:convert';

import 'package:gestion_pfe/src/models/enseignant.dart';
import 'package:gestion_pfe/src/models/etudiant.dart';
import 'package:gestion_pfe/src/models/responsable.dart';

List<Document> documentFromJson(String str) =>
    List<Document>.from(json.decode(str).map((x) => Document.fromJson(x)));

String documentToJson(List<Document> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
String documentToJsonn(List<Document> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Document {
  int? idDoc;
  String? titre;
  String? description;
  String? datedepot;
  String? photo; //file
  Etudiant? etudiant;
  Responsable? responsable;
  Enseignant? enseignant;

  Document(
      {this.idDoc,
      this.titre,
      this.description,
      this.datedepot,
      this.photo,
      this.etudiant,
      this.responsable,
      this.enseignant});

  Document.fromJson(Map<String, dynamic> json) {
    idDoc = json['idDoc'];
    titre = json['titre'];
    description = json['description'];
    datedepot = json['datedepot'];
    photo = json['photo'];
    etudiant =
        json['etudiant'] != null ? Etudiant.fromJson(json['etudiant']) : null;
    responsable = json['responsable'] != null
        ? Responsable.fromJson(json['responsable'])
        : null;
    enseignant = json['enseignant'] != null
        ? Enseignant.fromJson(json['enseignant'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idDoc'] = idDoc;
    data['titre'] = titre;
    data['description'] = description;
    data['datedepot'] = datedepot;
    data['photo'] = photo;
    data['etudiant'] = etudiant?.idEtud;
    data['responsable'] = responsable?.idUser;
    data['enseignant'] = enseignant?.idEns;
    return data;
  }

  @override
  String toString() {
    return 'Document(idDoc: $idDoc, titre: $titre, description: $description, dateDepot: $datedepot, photo: $photo, etudiant: $etudiant, responsable: $responsable, enseignant: $enseignant)';
  }
}
