// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:developer';

import 'package:gestion_pfe/src/models/document.dart';
import 'package:gestion_pfe/src/models/enseignant.dart';
import 'package:gestion_pfe/src/models/pfe.dart';
import 'package:gestion_pfe/src/models/soutenance.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';
import '../models/etudiant.dart';
import '../models/responsable.dart';

class ApiService {
  Future<List<Etudiant>?> getEtudiants({String? id = ""}) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.etudiants + id!);

      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Etudiant> model = etudiantFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
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
            "specialite": specialite
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
            "specialite": "s"
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

  Future<List<Etudiant>?> deleteEtudiants(String? id) async {
    try {
      var url =
          Uri.parse("${ApiConstants.baseUrl}${ApiConstants.etudiants}$id");
      var response = await http.delete(
        url,
      );
      // log("deleteEtudiants::${response.body}");
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<Document>?> getDocument({String? id = ""}) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.document + id!);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Document> model = documentFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<Document>?> addDocument(
      {String? id = "",
      String? filepath = "",
      required Document document}) async {
    try {
      // var urll = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.document}add");
      String url = "${ApiConstants.baseUrl}${ApiConstants.document}add";
      Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
      };

      var request = http.MultipartRequest('POST', Uri.parse(url))
        ..fields['Document'] = json.encode(document.toJson())
        ..headers.addAll(headers)
        ..files.add(await http.MultipartFile.fromPath('file', filepath!));
      var response = await request.send();
      log(request.fields.toString());
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<Document>?> deleteDocument({String? id}) async {
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.document}$id");
      var response = await http.delete(
        url,
      );
       log("deleteDocument::${response.body}");
    } catch (e) {
      log("exceptionDeleteDocument::${e.toString()}");
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
    String? etudiant = "",
    String? dateDebut = "",
    String? dateFin = "",
    String? dateSoutenance = "",
    String? document = "",
  }) async {
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.pfe}add");

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            "nom": nom,
            "prenom": prenom,
            "telephone": int.parse(telephone ?? "-1"),
            "adresse": adresse,
            "email": email,
            "motDePasse": motDePasse,
            "note": int.parse(note ?? "-1"),
            "titre": titre,
            "domaine": domaine,
            "encadreur": encadreur,
            "etudiant": etudiant,
            "dateDebut": dateDebut,
            "dateFin": dateFin,
            "dateSoutenance": dateSoutenance,
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
      log(e.toString());
    }
    return null;
  }

  Future<List<Soutenance>?> getSoutenance({String? id = ""}) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.soutenance + id!);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        log("response.body::${response.body}");
        List<Soutenance> model = soutenanceFromJson(response.body);
        return model;
      }
    } catch (e) {
      log("soutenanceException::${e.toString()}");
    }
    return null;
  }
  
  Future<List<Soutenance>?> deleteSoutenance({String? id = ""}) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.soutenance + id!);
      var response = await http.delete(url);
      if (response.statusCode == 200) {
        log("response.body::${response.body}");
        List<Soutenance> model = soutenanceFromJson(response.body);
        return model;
      }
    } catch (e) {
      log("soutenanceException::${e.toString()}");
    }
    return null;
  }
  

  Future<List<Responsable>?> getResponsable({String? id = ""}) async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.responsable + id!);

      var response = await http.get(url);
      if (response.statusCode == 200) {
        // log("response.body::${response.body}");
        List<Responsable> model = responsableFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  /*Future<String> uploadImageToS3(MultipartFile multipartFile) async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.responsable );
      final formData = FormData.fromMap({
        'file': multipartFile,
        'bucket': "hubscategoriesicons2/profilePictures"
      });
      final response = await uploadImageDio.post(url, data: formData);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }*/

}
