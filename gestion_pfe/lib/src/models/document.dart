// To parse this JSON data, do
//
//     final document = documentFromJson(jsonString);

import 'dart:convert';

import 'package:gestion_pfe/src/models/encadrant.dart';
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
  String? date;
  String? photo; //file
  Etudiant? etudiant;
  Responsable? responsable;
  Encadrant? encadrant;

  Document(
      {this.idDoc,
      this.titre,
      this.description,
      this.date,
      this.photo,
      this.etudiant,
      this.responsable,
      this.encadrant});

  Document.fromJson(Map<String, dynamic> json) {
    idDoc = json['idDoc'];
    titre = json['titre'];
    description = json['description'];
    date = json['date'];
    photo = json['photo'];
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
    data['idDoc'] = idDoc;
    data['titre'] = titre;
    data['description'] = description;
    data['date'] = date;
    data['photo'] = photo;
    data['etudiant'] = etudiant?.idEtud;
    data['responsable'] = responsable?.idUser;
    data['encadrant'] = encadrant?.idEnc;
    return data;
  }

  @override
  String toString() {
    return 'Document(idDoc: $idDoc, titre: $titre, description: $description, date: $date, photo: $photo, etudiant: $etudiant, responsable: $responsable, encadrant: $encadrant)';
  }
}
