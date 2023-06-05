import 'package:gestion_pfe/src/models/salle.dart';
import 'enseignant.dart';
import 'document.dart';
import 'etudiant.dart';
import 'dart:convert';
import 'seance_model.dart';

List<PFE> pfeFromJson(String str) =>
    List<PFE>.from(json.decode(str).map((x) => PFE.fromJson(x)));

String pfeToJson(List<PFE> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PFE {
  int? idPFE;
  String? title;
  String? description;
  String? dateDebut;
  String? dateDepot;
  String? domaine;
  double? note;
  Etudiant? etudiant;
  Enseignant? encadreur;
  Document? document;

  PFE(
      {this.idPFE,
      this.title,
      this.description,
      this.dateDebut,
      this.dateDepot,
      this.domaine,
      this.note,
      this.etudiant,
      this.encadreur,
      this.document});

  PFE.fromJson(Map<String, dynamic> json) {
    idPFE = json['idPFE'];
    title = json['title'];
    dateDebut = json['dateDebut'];
    dateDepot = json['dateDepot'];
    domaine = json['domaine'];
    note = json['note'];
    etudiant =
        json['etudiant'] != null ? Etudiant.fromJson(json['etudiant']) : null;
    encadreur = json['encadreur'] != null
        ? Enseignant.fromJson(json['encadreur'])
        : null;
 document =
        json['document'] != null ? Document.fromJson(json['document']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idPFE'] = idPFE;
    data['title'] = title;
    data['dateDebut'] = dateDebut;
    data['dateDepot'] = dateDepot;
    data['domaine'] = domaine;
    data['note'] = note;
    if (etudiant != null) {
      data['etudiant'] = etudiant!.idEtud;
    }
    if (encadreur != null) {
      data['encadreur'] = encadreur!.idEns;
    } 
    if (document != null) {
      data['document'] = document!.idDoc;
    }

    return data;
  }

  @override
  String toString() {
    return 'PFE(idPFE: $idPFE, title: $title, dateDebut: $dateDebut, dateDepot: $dateDepot, domaine: $domaine, note: $note, etudiant: $etudiant, encadreur: $encadreur, document: $document)';
  }
}
