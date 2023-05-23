import 'dart:convert';
import 'dart:developer';
import 'package:gestion_pfe/src/models/enseignant.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';

class ApiEnseignant {
  Future<List<Enseignant>?> getAllEnseignant() async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.enseignants + ApiConstants.all);

      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Enseignant> model = enseignantFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
  Future<List<Enseignant>?> getEnseignant({String? id = ""}) async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.enseignants + id!);

      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Enseignant> model = enseignantFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<Enseignant>?> addEnseignant({
    String? nom = "",
    String? prenom = "",
    String? telephone = "",
    String? adresse = "",
    String? email = "",
    String? motDePasse = "",
    String? domaine = "",
  }) async {
    try {
      var url =
          Uri.parse("${ApiConstants.baseUrl}${ApiConstants.enseignants}add");
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            "domaine": domaine,
            "adresse": adresse,
            "email": email,
            "motdepasse": motDePasse,
            "nom": nom,
            "prenom": prenom,
            "tel": int.parse(telephone!),
          },
        ),
      );
      // log("addEnseignant::${response.body}");
      if (response.statusCode == 200) {
        List<Enseignant> _model = enseignantFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<Enseignant>?> editEnseignant({    
    String? id = "",
    String? nom = "",
    String? prenom = "",
    String? telephone = "",
    String? adresse = "",
    String? email = "",
    String? motDePasse = "",
    String? domaine = "",
  }) async {
    try {
      var url =
          Uri.parse("${ApiConstants.baseUrl}${ApiConstants.enseignants}add");
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            "id": int.parse(id!),
            "domaine": domaine,
            "adresse": adresse,
            "email": email,
            "motdepasse": motDePasse,
            "nom": nom,
            "prenom": prenom,
            "tel": int.parse(telephone!),
          },
        ),
      );
      // log("addEnseignant::${response.body}");
      if (response.statusCode == 200) {
        List<Enseignant> _model = enseignantFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log("editEnseignant::${e.toString()}");
    }
    return null;
  }

  Future<List<Enseignant>?> deleteEnseignant(String? id) async {
    try {
      var url =
          Uri.parse("${ApiConstants.baseUrl}${ApiConstants.enseignants}$id");
      var response = await http.delete(
        url,
      );
      // log("deleteEnseignant::${response.body}");
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
