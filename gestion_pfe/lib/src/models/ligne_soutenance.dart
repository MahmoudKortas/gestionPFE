// import 'package:gestionpfe/src/models/encadrant.dart';
import 'package:gestion_pfe/src/models/pfe.dart';

import 'dart:convert';
 

List<LigneSoutenance> ligneSoutenanceFromJson(String str) =>
    List<LigneSoutenance>.from(json.decode(str).map((x) => PFE.fromJson(x)));

String ligneSoutenanceToJson(List<LigneSoutenance> data) =>
    json.encode(List<LigneSoutenance>.from(data.map((x) => x.toJson())));

class LigneSoutenance {
  int? idLigne;
  String? noteRapport;//TODO: convert it to double
  String? noteQR;//TODO: convert it to double
  String? notePresentation;//TODO: convert it to double
  String? noteApplication; //TODO: convert it to double
  PFE? pfe;
  LigneSoutenance(
      {this.idLigne,
      this.noteRapport,
      this.noteQR,
      this.notePresentation,
      this.noteApplication, 
      this.pfe});

  LigneSoutenance.fromJson(Map<String, dynamic> json) {
    idLigne = json['idLigne'];
    noteRapport = json['Noterapport'];
    noteQR = json['NoteQR'];
    notePresentation = json['Notepresentation'];
    noteApplication = json['Notepresentation']; 
    pfe = json['pfe'] != null ? PFE.fromJson(json['pfe']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idLigne'] = idLigne;
    data['Noterapport'] = noteRapport;
    data['NoteQR'] = noteQR;
    data['Notepresentation'] = notePresentation;
    data['Noteapplication'] = noteApplication;
 
    if (pfe != null) {
      data['pfe'] = pfe!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'LigneSoutenance(idLigne: $idLigne, Noterapport: $noteRapport, Noteapplication: $noteApplication, pfe: $pfe)';
  }
}
