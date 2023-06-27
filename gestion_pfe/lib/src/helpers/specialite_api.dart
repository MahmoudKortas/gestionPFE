import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';
import '../models/specialite.dart';

class ApiSpecialite {
  Future<List<Specialite>?> getAllSpecialites() async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.specialite + ApiConstants.all);
      var response = await http.get(url);
      // log("responseresponse:${response.body}");

      if (response.statusCode == 200) {
        List<Specialite> model = specialiteFromJson(response.body);
        return model;
      }
    } catch (e) {
      log("getAllSpecialites-error::${e.toString()}");
    }
    return null;
  }

  Future<List<Specialite>?> getSpecialite({String? id = ""}) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.specialite + id!);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Specialite> model = specialiteFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<Specialite>?> addSpecialite({Specialite? specialite}) async {
    try {
      var url =
          Uri.parse("${ApiConstants.baseUrl}${ApiConstants.specialite}add");
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            "nom": specialite?.nom,
          },
        ),
      );
      log("addSpecialitestatusCode::${response.body}");
      if (response.statusCode == 200) {
        // List<Specialite> _model = SpecialiteFromJson(response.body);
        // return _model;
      }
    } catch (e) {
      log("addSpecialiteException:${e.toString()}");
    }
    return null;
  }
  Future<List<Specialite>?> updateSpecialite({Specialite? specialite}) async {
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.specialite}update");
      var response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            "idSpecialite": specialite?.idSpecialite,
            "nom": specialite?.nom,
          },
        ),
      );
      log("updateSpecialitestatusCode::${response.body}");
      if (response.statusCode == 200) {
        // List<Specialite> _model = SpecialiteFromJson(response.body);
        // return _model;
      }
    } catch (e) {
      log("updateSpecialiteException:${e.toString()}");
    }
    return null;
  }

  Future<List<Specialite>?> deleteSpecialite({required String id}) async {
    try {
      var url =
          Uri.parse("${ApiConstants.baseUrl}${ApiConstants.specialite}$id");
      // var response =
       await http.delete(
        url,
      );
      // log("deleteSpecialites::${response.body}");
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
