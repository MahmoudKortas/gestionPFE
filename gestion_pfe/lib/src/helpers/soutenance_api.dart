import 'dart:developer';
import 'package:gestion_pfe/src/models/soutenance.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';

class ApiSoutenance {
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
}
