import 'dart:convert';
import 'dart:developer';

import 'package:gestion_pfe/src/models/document.dart';
import 'package:gestion_pfe/src/models/enseignant.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../constants/constants.dart';
import '../models/etudiant.dart';

class ApiService {
  Future<List<Etudiant>?> getEtudiants({String? id = ""}) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.etudiants + id!);

      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Etudiant> _model = etudiantFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<Etudiant>?> addEtudiants({
    String? nom = "",
    String? prenom = "",
    String? telephone = "",
    String? adresse = "",
    String? email = "",
    String? motDePasse = "",
    String? diplome = "",
    String? departement = "",
    String? niveau = "",
    String? specialite = "",
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
            "adresse": adresse,
            "diplome": diplome,
            "email": email,
            "motdepasse": motDePasse,
            "niveau": niveau,
            "nom": nom,
            "prenom": prenom,
            "tel": int.parse(telephone!),
            "departement": departement,
            "specialite": specialite,
            "etudiants": []
          },
        ),
      );
      log("addEtudiants::${response.body}");
      /*if (response.statusCode == 200) {
        List<Etudiant> _model = etudiantFromJson(response.body);
        return _model;
      }*/
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<Etudiant>?> updateEtudiants(String? id) async {
    try {
      var url =
          Uri.parse("${ApiConstants.baseUrl}${ApiConstants.etudiants}update/");

      var response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            "id_etud": 3,
            "adresse": "aaaaa",
            "diplome": "d",
            "email": "e",
            "motdepasse": "m",
            "niveau": "n",
            "nom": "n",
            "prenom": "p",
            "tel": 1,
            "departement": "d",
            "specialite": "s",
            "etudiants": []
          },
        ),
      );
      log("updateEtudiants::${response.body}");
      /*if (response.statusCode == 200) {
        List<Etudiant> _model = etudiantFromJson(response.body);
        return _model;
      }*/
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<Etudiant>?> deleteEtudiants(String? id) async {
    try {
      var url =
          Uri.parse("${ApiConstants.baseUrl}${ApiConstants.etudiants}$id");

      var response = await http.delete(
        url,
      );
      log("deleteEtudiants::${response.body}");
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<Document>?> getDocument({String? id = ""}) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.document + id!);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Document> _model = documentFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<Document>?> addDocument({String? id = ""}) async {
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.document}add");

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            "dateDepot": "2022-06-30T12:57:27.000+00:00",
            "description": "d",
            "proprietaire": "e",
            "titre": "m",
            "documents": []
          },
        ),
      );
      log("addDocument::${response.body}");
      /*if (response.statusCode == 200) {
        List<Etudiant> _model = etudiantFromJson(response.body);
        return _model;
      }*/
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<Document>?> deleteDocument(String? id) async {
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.document}$id");

      var response = await http.delete(
        url,
      );
      log("deleteDocument::${response.body}");
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<Enseignant>?> getEnseignant({String? id = ""}) async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.enseignants + id!);

      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Enseignant> _model = enseignantFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
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
      log("addEnseignant::${response.body}");
      /*if (response.statusCode == 200) {
        List<Etudiant> _model = etudiantFromJson(response.body);
        return _model;
      }*/
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<Enseignant>?> deleteEnseignant(String? id) async {
    try {
      var url =
          Uri.parse("${ApiConstants.baseUrl}${ApiConstants.enseignants}$id");

      var response = await http.delete(
        url,
      );
      log("deleteEnseignant::${response.body}");
    } catch (e) {
      log(e.toString());
    }
  }
}
