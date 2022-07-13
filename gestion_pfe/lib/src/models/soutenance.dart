import 'package:gestion_pfe/src/models/enseignant.dart';
import 'package:gestion_pfe/src/models/pfe.dart';

import 'dart:convert';

List<Soutenance> soutenanceFromJson(String str) =>
    List<Soutenance>.from(json.decode(str).map((x) => PFE.fromJson(x)));

String soutenanceToJson(List<Soutenance> data) =>
    json.encode(List<Soutenance>.from(data.map((x) => x.toJson())));

class Soutenance {
  int? idSout;
  String? date;
  String? heuredebut;
  String? heurefin;
  String? salle;
  Enseignant? rapporteur;
  Enseignant? president;
  PFE? pfe;

  Soutenance(
      {this.idSout,
      this.date,
      this.heuredebut,
      this.heurefin,
      this.salle,
      this.rapporteur,
      this.president,
      this.pfe});

  Soutenance.fromJson(Map<String, dynamic> json) {
    idSout = json['idSout'];
    date = json['date'];
    heuredebut = json['heuredebut'];
    heurefin = json['heurefin'];
    salle = json['salle'];
    rapporteur = json['rapporteur'] != null
        ? Enseignant.fromJson(json['rapporteur'])
        : null;
    president = json['president'] != null
        ? Enseignant.fromJson(json['president'])
        : null;
    pfe = json['pfe'] != null ? PFE.fromJson(json['pfe']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idSout'] = idSout;
    data['date'] = date;
    data['heuredebut'] = heuredebut;
    data['heurefin'] = heurefin;
    data['salle'] = salle;
    if (rapporteur != null) {
      data['rapporteur'] = rapporteur!.toJson();
    }
    if (president != null) {
      data['president'] = president!.toJson();
    }
    if (pfe != null) {
      data['pfe'] = pfe!.toJson();
    }
    return data;
  }
}
