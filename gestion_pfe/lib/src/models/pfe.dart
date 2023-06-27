// import 'package:gestion_pfe/src/models/salle.dart';
import 'package:gestion_pfe/src/models/sujet.dart';

import 'encadrant.dart';
import 'document.dart';
import 'etudiant.dart';
import 'dart:convert';
// import 'seance_model.dart';

List<PFE> pfeFromJson(String str) =>
    List<PFE>.from(json.decode(str).map((x) => PFE.fromJson(x)));

String pfeToJson(List<PFE> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PFE {
  int? idPFE;
  String? dateDebut;
  String? dateDepot;
  Etudiant? etudiant;
  Encadrant? encadrant;
  Sujet? sujet;
  Document? document;

  PFE(
      {this.idPFE,
      this.dateDebut,
      this.dateDepot,
      this.etudiant,
      this.encadrant,
      this.sujet,
      this.document});

  PFE.fromJson(Map<String, dynamic> json) {
    idPFE = json['idPFE'];
    dateDebut = json['dateDebut'];
    dateDepot = json['dateDepot'];
    etudiant =
        json['etudiant'] != null ? Etudiant.fromJson(json['etudiant']) : null;
    encadrant = json['encadrant'] != null
        ? Encadrant.fromJson(json['encadrant'])
        : null;
    document =
        json['document'] != null ? Document.fromJson(json['document']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idPFE'] = idPFE;
    data['dateDebut'] = dateDebut;
    data['dateDepot'] = dateDepot;
    if (etudiant != null) {
      data['etudiant'] = etudiant!.idEtud;
    }
    if (encadrant != null) {
      data['encadrant'] = encadrant!.idEnc;
    }
    if (sujet != null) {
      data['sujet'] = sujet!.idSujet;
    }
    if (document != null) {
      data['document'] = document!.idDoc;
    }

    return data;
  }

  @override
  String toString() {
    return 'PFE(idPFE: $idPFE, dateDebut: $dateDebut, dateDepot: $dateDepot, etudiant: $etudiant, encadrant: $encadrant, document: $document)';
  }
}
