import 'package:gestion_pfe/src/models/encadrant.dart';
import 'package:gestion_pfe/src/models/pfe.dart';

import 'dart:convert';

import 'package:gestion_pfe/src/models/salle.dart';
import 'package:gestion_pfe/src/models/seance_model.dart';

List<Soutenance> soutenanceFromJson(String str) =>
    List<Soutenance>.from(json.decode(str).map((x) => PFE.fromJson(x)));

String soutenanceToJson(List<Soutenance> data) =>
    json.encode(List<Soutenance>.from(data.map((x) => x.toJson())));

class Soutenance {
  int? idSout;
  String? date;
  String? description;
  String? etat;
  Encadrant? rapporteur;
  Encadrant? president;
  Salle? salle;
  Seance? seance;
  PFE? pfe;
  Soutenance(
      {this.idSout,
      this.date,
      this.description,
      this.etat,
      this.rapporteur,
      this.president,
      this.salle,
      this.seance,
      this.pfe});

  Soutenance.fromJson(Map<String, dynamic> json) {
    idSout = json['idSout'];
    date = json['date'];
    description = json['description'];
    etat = json['etat'];
    rapporteur = json['rapporteur'] != null
        ? Encadrant.fromJson(json['rapporteur'])
        : null;
    president = json['president'] != null
        ? Encadrant.fromJson(json['president'])
        : null;
    salle = Salle.fromJson(json['salle']);
    seance = Seance.fromJson(json['seance']);
    pfe = json['pfe'] != null ? PFE.fromJson(json['pfe']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idSout'] = idSout;
    data['date'] = date;
    data['description'] = description;
    data['etat'] = etat;
    if (rapporteur != null) {
      data['rapporteur'] = rapporteur!.toJson();
    }
    if (president != null) {
      data['president'] = president!.toJson();
    }
    data['salle'] = salle;
    data['seance'] = seance;
    if (pfe != null) {
      data['pfe'] = pfe!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'Soutenance(idSout: $idSout, date: $date, salle: $salle, rapporteur: $rapporteur, president: $president, pfe: $pfe)';
  }
}
