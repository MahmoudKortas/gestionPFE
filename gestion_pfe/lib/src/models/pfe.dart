import 'enseignant.dart';

import 'document.dart';
import 'etudiant.dart';

import 'dart:convert';

List<PFE> pfeFromJson(String str) =>
    List<PFE>.from(json.decode(str).map((x) => PFE.fromJson(x)));

String pfeToJson(List<PFE> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PFE {
  int? idPFE;
  String? title;
  String? dateDebut;
  String? dateFin;
  String? domaine;
  double? note;
  Etudiant? etudiant;
  Enseignant? encadreur;
  Enseignant? president;
  Enseignant? rapporteur;
  String? salle;
  String? seance;
  Document? document;

  PFE(
      {this.idPFE,
      this.title,
      this.dateDebut,
      this.dateFin,
      this.domaine,
      this.note,
      this.etudiant,
      this.encadreur,
      this.president,
      this.rapporteur,
      this.salle,
      this.seance,
      this.document});

  PFE.fromJson(Map<String, dynamic> json) {
    idPFE = json['idPFE'];
    title = json['title'];
    dateDebut = json['dateDebut'];
    dateFin = json['dateFin'];
    domaine = json['domaine'];
    note = json['note'];
    etudiant =
        json['etudiant'] != null ? Etudiant.fromJson(json['etudiant']) : null;
    encadreur = json['encadreur'] != null
        ? Enseignant.fromJson(json['encadreur'])
        : null;
    encadreur = json['president'] != null
        ? Enseignant.fromJson(json['president'])
        : null;
    encadreur = json['rapporteur'] != null
        ? Enseignant.fromJson(json['rapporteur'])
        : null;
    title = json['salle'];
    title = json['seance'];
    document =
        json['document'] != null ? Document.fromJson(json['document']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idPFE'] = idPFE;
    data['title'] = title;
    data['dateDebut'] = dateDebut;
    data['dateFin'] = dateFin;
    data['domaine'] = domaine;
    data['note'] = note;
    if (etudiant != null) {
      data['etudiant'] = etudiant!.toJson();
    }
    if (encadreur != null) {
      data['encadreur'] = encadreur!.toJson();
    }
    if (encadreur != null) {
      data['president'] = encadreur!.toJson();
    }
    if (encadreur != null) {
      data['rapporteur'] = encadreur!.toJson();
    }
    data['salle'] = title;
    data['seance'] = title;
    if (document != null) {
      data['document'] = document!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'PFE(idPFE: $idPFE, title: $title, dateDebut: $dateDebut, dateFin: $dateFin, domaine: $domaine, note: $note, etudiant: $etudiant, encadreur: $encadreur, president: $president, rapporteur: $rapporteur, salle: $salle, seance: $seance, document: $document)';
  }
}
