 

import 'package:gestion_pfe/src/models/soutenance.dart'; 

import 'dart:convert';
 
 

List<LigneSoutenance> ligneSoutenanceFromJson(String str) =>
    List<LigneSoutenance>.from(json.decode(str).map((x) => LigneSoutenance.fromJson(x)));

String ligneSoutenanceToJson(List<LigneSoutenance> data) =>
    json.encode(List<LigneSoutenance>.from(data.map((x) => x.toJson())));

class LigneSoutenance {
  int? idLigne;
  double? noterapport;//TODO: convert it to double
  double? noteQR;//TODO: convert it to double
  double? notepresentation;//TODO: convert it to double
  double? noteapplication; //TODO: convert it to double
  Soutenance? soutenance;
  LigneSoutenance(
      {this.idLigne,
      this.noterapport,
      this.noteQR,
      this.notepresentation,
      this.noteapplication, 
      this.soutenance});

  LigneSoutenance.fromJson(Map<String, dynamic> json) {
    idLigne = json['idLigne'];
    noterapport = json['noterapport'];
    noteQR = json['noteQR'];
    notepresentation = json['notepresentation'];
    noteapplication = json['notepresentation']; 
    soutenance = json['soutenance'] != null ? Soutenance.fromJson(json['soutenance']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idLigne'] = idLigne;
    data['noterapport'] = noterapport;
    data['noteQR'] = noteQR;
    data['notepresentation'] = notepresentation;
    data['noteapplication'] = noteapplication;
 
    if (soutenance != null) {
      data['soutenance'] = soutenance!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'LigneSoutenance(idLigne: $idLigne, noterapport: $noterapport, noteapplication: $noteapplication, soutenance: $soutenance)';
  }
}
