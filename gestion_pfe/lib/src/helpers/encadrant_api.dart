import 'dart:convert';
import 'dart:developer';
import 'package:gestion_pfe/src/models/encadrant.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';

class ApiEncadrant {
  Future<List<Encadrant>?> getAllEncadrant() async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.encadrants + ApiConstants.all);

      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Encadrant> model = encadrantFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
  Future<List<Encadrant>?> getEncadrant({String? id = ""}) async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.encadrants + id!);

      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Encadrant> model = encadrantFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<Encadrant>?> addEncadrant({
    String? nom = "",
    String? prenom = "",
    String? telephone = "",
    String? adresse = "",
    String? email = "",
    String? motDePasse = "",
    String? domaine = "",
    String? departement = "",
  }) async {
    try {
      var url =
          Uri.parse("${ApiConstants.baseUrl}${ApiConstants.encadrants}add");
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
            "departement": departement,
          },
        ),
      );
      // log("addEncadrant::${response.body}");
      if (response.statusCode == 200) {
        List<Encadrant> model = encadrantFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<Encadrant>?> editEncadrant({    
    String? id = "",
    String? nom = "",
    String? prenom = "",
    String? telephone = "",
    String? adresse = "",
    String? email = "",
    String? motDePasse = "",
    String? domaine = "",
    String? departement = "",
  }) async {
    try {
      var url =
          Uri.parse("${ApiConstants.baseUrl}${ApiConstants.encadrants}add");
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
            "departement": departement,
          },
        ),
      );
      // log("addEncadrant::${response.body}");
      if (response.statusCode == 200) {
        List<Encadrant> model = encadrantFromJson(response.body);
        return model;
      }
    } catch (e) {
      log("editEncadrant::${e.toString()}");
    }
    return null;
  }

  Future<List<Encadrant>?> deleteEncadrant(String? id) async {
    try {
      var url =
          Uri.parse("${ApiConstants.baseUrl}${ApiConstants.encadrants}$id");
      // var response = 
      await http.delete(
        url,
      );
      // log("deleteEncadrant::${response.body}");
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
