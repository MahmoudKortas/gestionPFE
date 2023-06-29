import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';
import '../models/sujet.dart';

class ApiSujet {
  Future<List<Sujet>?> getAllSujets() async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.sujets + ApiConstants.all);

      var response = await http.get(url);

      if (response.statusCode == 200) {
        List<Sujet> model = sujetFromJson(response.body);
        return model;
      }
    } catch (e) {
      log("getAllSujets::${e.toString()}");
    }
    return null;
  }

  Future<List<Sujet>?> getSujets({String? id = ""}) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.sujets + id!);

      var response = await http.get(url);

      if (response.statusCode == 200) {
        List<Sujet> model = sujetFromJson(response.body);
        return model;
      }
    } catch (e) {
      log("getSujets::${e.toString()}");
    }
    return null;
  }

  Future<List<Sujet>?> addSujets({Sujet? sujet}) async {
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.sujets}add");
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            "titre": sujet?.titre,
            "description": sujet?.description,
            "date": sujet?.date,
            "etudiant": sujet?.etudiant,
            "responsable": sujet?.responsable,
            "encadrant": sujet?.encadrant,
          },
        ),
      );
      log("addSujetsstatusCode::${response.body}");
      if (response.statusCode == 200) {
        // List<Sujet> _model = sujetFromJson(response.body);
        // return _model;
      }
    } catch (e) {
      log("adddSujetException:${e.toString()}");
    }
    return null;
  }

  Future<List<Sujet>?> updateSujets({Sujet? editedSujet}) async {
    try {
      var url = Uri.parse(
          "${ApiConstants.baseUrl}${ApiConstants.sujets}${ApiConstants.update}");
      // var response =
      await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            "idSujet": editedSujet?.idSujet,
            "titre": editedSujet?.titre,
            "description": editedSujet?.description,
            "date": editedSujet?.date,
            "etudiant": editedSujet?.etudiant,
            "responsable": editedSujet?.responsable,
            "encadrant": editedSujet?.encadrant,
          },
        ),
      );
      // log("updateSujets::${response.body}");
      /*if (response.statusCode == 200) {
        List<Sujet> _model = sujetFromJson(response.body);
        return _model;
      }*/
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<Sujet>?> deleteSujet({required String id}) async {
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.sujets}$id");
      // var response =
      await http.delete(
        url,
      );
      // log("deleteSujets::${response.body}");
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
