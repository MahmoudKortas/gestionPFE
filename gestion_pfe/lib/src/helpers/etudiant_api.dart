import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';
import '../models/etudiant.dart';

class ApiEtudiant {
  Future<List<Etudiant>?> getAllEtudiants() async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.etudiants + ApiConstants.all);

      var response = await http.get(url);

      if (response.statusCode == 200) {
        List<Etudiant> model = etudiantFromJson(response.body);
        return model;
      }
    } catch (e) {
      log("getAllEtudiants::${e.toString()}");
    }
    return null;
  }

  Future<List<Etudiant>?> getEtudiants({String? id = ""}) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.etudiants + id!);

      var response = await http.get(url);

      if (response.statusCode == 200) {
        List<Etudiant> model = etudiantFromJson(response.body);
        return model;
      }
    } catch (e) {
      log("getEtudiants::${e.toString()}");
    }
    return null;
  }

  Future<List<Etudiant>?> addEtudiants({
    Etudiant? etudiant,
  }) async {
    try {
      var url =
          Uri.parse("${ApiConstants.baseUrl}${ApiConstants.etudiants}add");
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            "nom": etudiant?.nom,
            "prenom": etudiant?.prenom,
            "tel": etudiant?.tel,
            "adresse": etudiant?.adresse,
            "niveau": etudiant?.niveau,
            "email": etudiant?.email,
            "motdepasse": etudiant?.motdepasse,
            "departement": etudiant?.departement,
            "specialite": etudiant?.specialite
          },
        ),
      );
      log("addEtudiantsstatusCode::${response.body}");
      if (response.statusCode == 200) {
        // List<Etudiant> _model = etudiantFromJson(response.body);
        // return _model;
      }
    } catch (e) {
      log("adddEtudiantException:${e.toString()}");
    }
    return null;
  }

  Future<List<Etudiant>?> updateEtudiants({Etudiant? editEtudiant}) async {
    try {
      var url = Uri.parse(
          "${ApiConstants.baseUrl}${ApiConstants.etudiants}${ApiConstants.update}");
      // var response =
      await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            "idEtud": editEtudiant?.idEtud,
            "nom": editEtudiant?.nom,
            "prenom": editEtudiant?.prenom,
            "tel": editEtudiant?.tel,
            "adresse": editEtudiant?.adresse,
            "niveau": editEtudiant?.niveau,
            "email": editEtudiant?.email,
            "motdepasse": editEtudiant?.motdepasse,
            "departement": editEtudiant?.departement,
            "specialite": editEtudiant?.specialite
          },
        ),
      );
      // log("updateEtudiants::${response.body}");
      /*if (response.statusCode == 200) {
        List<Etudiant> _model = etudiantFromJson(response.body);
        return _model;
      }*/
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<Etudiant>?> deleteEtudiant({required String id}) async {
    try {
      var url =
          Uri.parse("${ApiConstants.baseUrl}${ApiConstants.etudiants}$id");
      // var response =
      await http.delete(
        url,
      );
      // log("deleteEtudiants::${response.body}");
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
