// To parse this JSON data, do
//
//     final document = documentFromJson(jsonString);

import 'dart:convert';

List<Document> documentFromJson(String str) =>
    List<Document>.from(json.decode(str).map((x) => Document.fromJson(x)));

String documentToJson(List<Document> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Document {
  Document({
     this.idDoc,
     this.titre,
     this.description,
     this.proprietaire,
     this.dateDepot,
     required this.documents,
  });

  int? idDoc;
  String? titre;
  String? description;
  String? proprietaire;
  DateTime? dateDepot;
  List<dynamic> documents;

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        idDoc: json["idDoc"],
        titre: json["titre"],
        description: json["description"],
        proprietaire: json["proprietaire"],
        dateDepot: DateTime.parse(json["dateDepot"]),
        documents: List<dynamic>.from(json["documents"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "idDoc": idDoc,
        "titre": titre,
        "description": description,
        "proprietaire": proprietaire,
        "dateDepot": dateDepot?.toIso8601String(),
        "documents": List<dynamic>.from(documents.map((x) => x)),
      };
  @override
  String toString() {
    return 'Document(idDoc: $idDoc, titre: $titre, description: $description, proprietaire: $proprietaire, dateDepot: $dateDepot, documents: $documents)';
  }
}
