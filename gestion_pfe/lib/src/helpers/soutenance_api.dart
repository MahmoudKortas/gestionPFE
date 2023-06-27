import 'dart:convert';
import 'dart:developer';
import 'package:gestion_pfe/src/models/soutenance.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';

class ApiSoutenance {
  Future<List<Soutenance>?> getAllSoutenance() async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.soutenance + ApiConstants.all);

      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Soutenance> model = soutenanceFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<Soutenance>?> addSoutenance({Soutenance? soutenance}) async {
    try {
      var url =
          Uri.parse("${ApiConstants.baseUrl}${ApiConstants.soutenance}add");
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            "date": soutenance?.date,
            "description": soutenance?.description,
            "etat": soutenance?.etat,
            "rapporteur": soutenance?.rapporteur?.idEnc,
            "president": soutenance?.president?.idEnc,
            "salle": soutenance?.salle?.idSalle,
            "seance": soutenance?.seance?.idSeance,
            "pfe": soutenance?.pfe?.idPFE
          },
        ),
      );
      log("addSoutenancestatusCode::${response.body}");
      if (response.statusCode == 200) {
        // List<Soutenance> _model = SoutenanceFromJson(response.body);
        // return _model;
      }
    } catch (e) {
      log("addSoutenanceException:${e.toString()}");
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

  Future<List<Soutenance>?> updateSoutenance({Soutenance? soutenance}) async {
    try {
      var url =
          Uri.parse("${ApiConstants.baseUrl}${ApiConstants.soutenance}update");
      var response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            "idDep": soutenance?.idSout,
            "nom": soutenance?.description,
          },
        ),
      );
      log("updateSoutenancestatusCode::${response.body}");
      if (response.statusCode == 200) {
        // List<Soutenance> _model = SoutenanceFromJson(response.body);
        // return _model;
      }
    } catch (e) {
      log("updateSoutenanceException:${e.toString()}");
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
}
