// To parse this JSON data, do
//
//     final document = documentFromJson(jsonString);

import 'dart:convert';

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
  String? proprietaire;
  String? datedepot;
  String? photo;

  Document(
      {this.idDoc,
      this.titre,
      this.description,
      this.proprietaire,
      this.datedepot,
      this.photo});

  Document.fromJson(Map<String, dynamic> json) {
    idDoc = json['idDoc'];
    titre = json['titre'];
    description = json['description'];
    proprietaire = json['proprietaire'];
    datedepot = json['datedepot'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idDoc'] = idDoc;
    data['titre'] = titre;
    data['description'] = description;
    data['proprietaire'] = proprietaire;
    data['datedepot'] = datedepot;
    data['photo'] = photo;
    return data;
  }

  @override
  String toString() {
    return 'Document(idDoc: $idDoc, titre: $titre, description: $description, proprietaire: $proprietaire, dateDepot: $datedepot, photo: $photo)';
  }
}
