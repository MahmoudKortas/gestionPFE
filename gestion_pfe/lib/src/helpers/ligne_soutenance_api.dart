import 'dart:convert';
import 'dart:developer';
import 'package:gestion_pfe/src/models/ligne_soutenance.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';

class ApiLigneSoutenance {
  Future<List<LigneSoutenance>?> getAllLigneSoutenances() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl +
          ApiConstants.ligneSoutenance +
          ApiConstants.all);

      var response = await http.get(url);

      if (response.statusCode == 200) {
        List<LigneSoutenance> model = ligneSoutenanceFromJson(response.body);
        return model;
      }
    } catch (e) {
      log("getAllLigneSoutenances::${e.toString()}");
    }
    return null;
  }

  Future<List<LigneSoutenance>?> getLigneSoutenances({String? id = ""}) async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.ligneSoutenance + id!);

      var response = await http.get(url);

      if (response.statusCode == 200) {
        List<LigneSoutenance> model = ligneSoutenanceFromJson(response.body);
        return model;
      }
    } catch (e) {
      log("getLigneSoutenances::${e.toString()}");
    }
    return null;
  }

  Future<List<LigneSoutenance>?> addLigneSoutenances(
      {LigneSoutenance? ligneSoutenance}) async { 
    try {
      var url = Uri.parse(
          "${ApiConstants.baseUrl}${ApiConstants.ligneSoutenance}add");
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            "noterapport": ligneSoutenance?.noterapport,
            "noteQR": ligneSoutenance?.noteQR,
            "notepresentation": ligneSoutenance?.notepresentation,
            "noteapplication": ligneSoutenance?.noteapplication,
            "soutenance": ligneSoutenance?.soutenance,
          },
        ),
      );
      log("addLigneSoutenancesstatusCode::${response.body}");
      if (response.statusCode == 200) {
        // List<LigneSoutenance> _model = ligneSoutenanceFromJson(response.body);
        // return _model;
      }
    } catch (e) {
      log("adddLigneSoutenanceException:${e.toString()}");
    }
    return null;
  }

  Future<List<LigneSoutenance>?> updateLigneSoutenances(
      LigneSoutenance ligneSoutenance) async {
    try {
      var url = Uri.parse(
          "${ApiConstants.baseUrl}${ApiConstants.ligneSoutenance}/${ligneSoutenance.idLigne}");
      // var response =
      await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            "idLigne": ligneSoutenance.idLigne,
            "noterapport": ligneSoutenance.noterapport,
            "noteQR": ligneSoutenance.noteQR,
            "notepresentation": ligneSoutenance.notepresentation,
            "noteapplication": ligneSoutenance.noteapplication.toString(),
            "soutenance": ligneSoutenance.soutenance?.idSout.toString(),
          },
        ),
      );
      // log("updateLigneSoutenances::${response.body}");
      /*if (response.statusCode == 200) {
        List<LigneSoutenance> _model = ligneSoutenanceFromJson(response.body);
        return _model;
      }*/
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<LigneSoutenance>?> deleteLigneSoutenance(
      {required String id}) async {
    try {
      var url = Uri.parse(
          "${ApiConstants.baseUrl}${ApiConstants.ligneSoutenance}$id");
      // var response =
      await http.delete(
        url,
      );
      // log("deleteLigneSoutenances::${response.body}");
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
