import 'package:gestion_pfe/src/models/enseignant.dart';
import 'package:gestion_pfe/src/models/pfe.dart';

import 'dart:convert';
 

List<LigneSoutenance> LigneSoutenanceFromJson(String str) =>
    List<LigneSoutenance>.from(json.decode(str).map((x) => PFE.fromJson(x)));

String LigneSoutenanceToJson(List<LigneSoutenance> data) =>
    json.encode(List<LigneSoutenance>.from(data.map((x) => x.toJson())));

class LigneSoutenance {
  int? idLigne;
  String? Note_rapport;//TODO: convert it to double
  String? Note_QR;//TODO: convert it to double
  String? Note_presentation;//TODO: convert it to double
  String? Note_application; //TODO: convert it to double
  PFE? pfe;
  LigneSoutenance(
      {this.idLigne,
      this.Note_rapport,
      this.Note_QR,
      this.Note_presentation,
      this.Note_application, 
      this.pfe});

  LigneSoutenance.fromJson(Map<String, dynamic> json) {
    idLigne = json['idLigne'];
    Note_rapport = json['Note_rapport'];
    Note_QR = json['Note_QR'];
    Note_presentation = json['Note_presentation'];
    Note_application = json['Note_presentation']; 
    pfe = json['pfe'] != null ? PFE.fromJson(json['pfe']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idLigne'] = idLigne;
    data['Note_rapport'] = Note_rapport;
    data['Note_QR'] = Note_QR;
    data['Note_presentation'] = Note_presentation;
    data['Note_application'] = Note_application;
 
    if (pfe != null) {
      data['pfe'] = pfe!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'LigneSoutenance(idLigne: $idLigne, Note_rapport: $Note_rapport, Note_application: $Note_application, pfe: $pfe)';
  }
}
