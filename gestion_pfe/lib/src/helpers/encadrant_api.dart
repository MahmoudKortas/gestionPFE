import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:gestion_pfe/src/models/encadrant.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';

class ApiEncadrant {
  Future<List<Encadrant>?> getAllEncadrant() async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.encadrants + ApiConstants.all);

      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Encadrant> model = encadrantFromJson(response.body);
        return model;
      }
    } catch (e) {
      log("getAllEncadrant-error::${e.toString()}");
    }
    return null;
  }

  Future<List<Encadrant>?> getEncadrant({String? id = ""}) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.encadrants + id!);

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

  Future<List<Encadrant>?> addEncadrant({Encadrant? encadrant}) async {
    try {
      var url =
          Uri.parse("${ApiConstants.baseUrl}${ApiConstants.encadrants}add");
      log("encadrantencadrant::$encadrant");
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            "nom": encadrant?.nom,
            "prenom": encadrant?.prenom,
            "tel": encadrant?.tel,
            "adresse": encadrant?.adresse,
            "email": encadrant?.email,
            "motdepasse": encadrant?.motdepasse,
            "domaine": encadrant?.domaine,
            "departement": encadrant?.departement,
          },
        ),
      );
      log("addEncadrant::${response.body}");
      if (response.statusCode == 200) {
        // List<Encadrant> model = encadrantFromJson(response.body);
        // return model;
      }
    } catch (e) {
      debugPrint("addEncadrant-exception::${e.toString()}");
    }
    return null;
  }

  Future<List<Encadrant>?> editEncadrant({Encadrant? editedEncadrant}) async {
    log("editEncadrant::$editedEncadrant");
    inspect(editedEncadrant);
    try {
      var url =
          Uri.parse("${ApiConstants.baseUrl}${ApiConstants.encadrants}update");
      var response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            "idEnc": editedEncadrant?.idEnc,
            "nom": editedEncadrant?.nom,
            "prenom": editedEncadrant?.prenom,
            "tel": editedEncadrant?.tel,
            "adresse": editedEncadrant?.adresse,
            "email": editedEncadrant?.email,
            "motdepasse": editedEncadrant?.motdepasse,
            "domaine": editedEncadrant?.domaine,
            "departement": editedEncadrant?.departement,
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
