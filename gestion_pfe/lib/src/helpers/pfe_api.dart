import 'dart:convert';
import 'dart:developer';
import 'package:gestion_pfe/src/models/pfe.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';

class ApiPfe {
  Future<List<PFE>?> getPFE({String? id = ""}) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.pfe + id!);

      var response = await http.get(url);
      if (response.statusCode == 200) {
        // log("response.body::${response.body}");
        List<PFE> model = pfeFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<PFE>?> addPFE({
    String? nom = "",
    String? prenom = "",
    String? telephone = "",
    String? adresse = "",
    String? email = "",
    String? motDePasse = "",
    String? note = "",
    String? titre = "",
    String? domaine = "",
    String? encadreur = "",
    String? president = "",
    String? rapporteur = "",
    String? etudiant = "",
    String? dateDebut = "",
    String? dateFin = "",
    String? dateSoutenance = "",
    String? salle = "",
    String? seance = "",
    String? document = "",
  }) async {
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.pfe}add");
      if (telephone != null) {
        telephone.isEmpty ? telephone = "-1" : telephone = telephone;
      }
      if (note != null) {
        note.isEmpty ? note = "-2" : note = note;
      }

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            "nom": nom,
            "prenom": prenom,
            "telephone": int.parse(telephone!),
            "adresse": adresse,
            "email": email,
            "motDePasse": motDePasse,
            "note": int.parse(note!),
            "titre": titre,
            "domaine": domaine,
            "encadreur": encadreur,
            "president": president,
            "rapporteur": rapporteur,
            "etudiant": etudiant,
            "dateDebut": dateDebut,
            "dateFin": dateFin,
            "dateSoutenance": dateSoutenance,
            "salle": salle,
            "seance": seance,
            "document": document,
          },
        ),
      );
      log("addPFE::${response.body}");
      if (response.statusCode == 200) {
        List<PFE> model = pfeFromJson(response.body);
        return model;
      }
    } catch (e) {
      log("addPFE-exception::${e.toString()}");
    }
    return null;
  }
}
