import 'dart:convert';
import 'dart:developer'; 
import 'package:http/http.dart' as http;
import '../constants/constants.dart';
import '../models/salle.dart'; 

class ApiSalle {
  
  Future<List<Salle>?> getAllSalles() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.salle + ApiConstants.all);
      var response = await http.get(url);
      // log("responseresponse:${response.body}");
    
      if (response.statusCode == 200) {
        List<Salle> model = salleFromJson(response.body);
        return model;
      }
    } catch (e) {
      log("getAllSalles-error::${e.toString()}");
    }
    return null;
  }
  Future<List<Salle>?> getSalle({String? id = ""}) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.salle + id!);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Salle> model = salleFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<Salle>?> addSalle({Salle? salle}) async {
    try { 
      var url =
          Uri.parse("${ApiConstants.baseUrl}${ApiConstants.salle}add");
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          { 
            "nom": salle?.nom, 
          },
        ),
      );
      log("addSallestatusCode::${response.body}");
      if (response.statusCode == 200) {
        // List<Salle> _model = SalleFromJson(response.body);
        // return _model;
      }
    } catch (e) {
      log("addSalleException:${e.toString()}");
    }
    return null;
  }

Future<List<Salle>?> updateSalle({Salle? salle}) async {
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.salle}update");
      var response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            "idSalle": salle?.idSalle,
            "nom": salle?.nom,
          },
        ),
      );
      log("updateSallestatusCode::${response.body}");
      if (response.statusCode == 200) {
        // List<Salle> _model = SalleFromJson(response.body);
        // return _model;
      }
    } catch (e) {
      log("updateSalleException:${e.toString()}");
    }
    return null;
  }
  Future<List<Salle>?> deleteSalle({required String id}) async {
    try {
      var url =
          Uri.parse("${ApiConstants.baseUrl}${ApiConstants.salle}$id");
      // var response = 
      await http.delete(
        url,
      );
      // log("deleteSalles::${response.body}");
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
