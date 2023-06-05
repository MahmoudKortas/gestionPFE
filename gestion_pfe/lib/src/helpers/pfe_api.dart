import 'dart:convert';
import 'dart:developer';
import 'package:gestion_pfe/src/models/pfe.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';

class ApiPfe {
  Future<List<PFE>?> getAllPFE() async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.pfe + ApiConstants.all);

      var response = await http.get(url);
      // inspect(response);
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

  Future<List<PFE>?> addPFE({PFE? pfe}) async {
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.pfe}add");

      /*if (pfe?.note != null) {
        pfe?.note.isEmpty ? pfe?.note = "-2" as double? : pfe?.note = pfe.note;
      }*/
 
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          
            "title": pfe?.title,
            "dateDebut": pfe?.dateDebut,
            "dateDepot": pfe?.dateDepot,
            "domaine": pfe?.domaine,
            "note": pfe?.note,
            "etudiant": pfe?.etudiant,
            "encadreur": pfe?.encadreur,
            "document": pfe?.document, 
        }),
      );
      log("addPFE::${response.body}");
      if (response.statusCode == 200) {
        List<PFE> model = pfeFromJson(response.body);
        return model;
      }
    } catch (e) {
      log("addPFE-exception::${e.toString()}");
    }
    return null;
  }

  Future<List<PFE>?> deletePFE({String? id = ""}) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.pfe + id!);
      var response = await http.delete(url);
      if (response.statusCode == 200) {
        log("response.body::${response.body}");
        List<PFE> model = pfeFromJson(response.body);
        return model;
      }
    } catch (e) {
      log("PFEException::${e.toString()}");
    }
    return null;
  }
}
