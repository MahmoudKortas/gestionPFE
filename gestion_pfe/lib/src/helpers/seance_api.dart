import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';
import '../models/seance_model.dart';

class ApiSeance {
  Future<List<Seance>?> getAllSeances() async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.seance + ApiConstants.all);
      var response = await http.get(url);
      // log("responseresponse:${response.body}");

      if (response.statusCode == 200) {
        List<Seance> model = seanceFromJson(response.body);
        return model;
      }
    } catch (e) {
      log("getAllSeances-error::${e.toString()}");
    }
    return null;
  }

  Future<List<Seance>?> getSeance({String? id = ""}) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.seance + id!);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Seance> model = seanceFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<Seance>?> addSeance({Seance? seance}) async {
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.seance}add");
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            "description": seance?.nom,
          },
        ),
      );
      log("addSeancestatusCode::${response.body}");
      if (response.statusCode == 200) {
        // List<Seance> _model = SeanceFromJson(response.body);
        // return _model;
      }
    } catch (e) {
      log("addSeanceException:${e.toString()}");
    }
    return null;
  }

  Future<List<Seance>?> updateSeance({Seance? seance}) async {
    try {
      var url =
          Uri.parse("${ApiConstants.baseUrl}${ApiConstants.seance}update");
      var response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            "idSeance": seance?.idSeance,
            "nom": seance?.nom,
          },
        ),
      );
      log("updateSeancestatusCode::${response.body}");
      if (response.statusCode == 200) {
        // List<Seance> _model = SeanceFromJson(response.body);
        // return _model;
      }
    } catch (e) {
      log("updateSeanceException:${e.toString()}");
    }
    return null;
  }
  Future<List<Seance>?> deleteSeance({required String id}) async {
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.seance}$id");
      // var response = 
      await http.delete(
        url,
      );
      // log("deleteSeances::${response.body}");
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}

 
