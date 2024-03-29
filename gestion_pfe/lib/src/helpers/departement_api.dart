import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';
import '../models/departement.dart';

class ApiDepartement {
  Future<List<Departement>?> getAllDepartements() async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.departement + ApiConstants.all);
      var response = await http.get(url);
      // log("responseresponse:${response.body}");

      if (response.statusCode == 200) {
        List<Departement> model = departementFromJson(response.body);
        return model;
      }
    } catch (e) {
      log("getAllDepartements-error::${e.toString()}");
    }
    return null;
  }

  Future<List<Departement>?> getDepartement({String? id = ""}) async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.departement + id!);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Departement> model = departementFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<Departement>?> addDepartement({Departement? departement}) async {
    try {
      var url =
          Uri.parse("${ApiConstants.baseUrl}${ApiConstants.departement}add");
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            "nom": departement?.nom,
          },
        ),
      );
      log("addDepartementstatusCode::${response.body}");
      if (response.statusCode == 200) {
        // List<Departement> _model = DepartementFromJson(response.body);
        // return _model;
      }
    } catch (e) {
      log("addDepartementException:${e.toString()}");
    }
    return null;
  }

  Future<List<Departement>?> updateDepartement(
      {Departement? departement}) async {
    try {
      var url =
          Uri.parse("${ApiConstants.baseUrl}${ApiConstants.departement}update");
      var response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            "idDep": departement?.idDep,
            "nom": departement?.nom,
          },
        ),
      );
      log("updateDepartementstatusCode::${response.body}");
      if (response.statusCode == 200) {
        // List<Departement> _model = DepartementFromJson(response.body);
        // return _model;
      }
    } catch (e) {
      log("updateDepartementException:${e.toString()}");
    }
    return null;
  }

  Future<String> deleteDepartement({required String id}) async {
    var response;
    try {
      var url =
          Uri.parse("${ApiConstants.baseUrl}${ApiConstants.departement}$id");

      response = await http.delete(
        url,
      );
      log("deleteDepartements::${response.body}");
    } catch (e) {
      log(e.toString());
    }
    return response.body;
  }
}
