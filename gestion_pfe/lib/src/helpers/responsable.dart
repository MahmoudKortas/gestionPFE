import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';
import '../models/responsable.dart';

class ApiResponsable {
  
  Future<List<Responsable>?> getAllResponsable() async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.responsable + ApiConstants.all);

      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Responsable> model = responsableFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
  Future<List<Responsable>?> getResponsable({String? id = ""}) async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.responsable + id!);

      var response = await http.get(url);
      if (response.statusCode == 200) {
        // log("response.body::${response.body}");
        List<Responsable> model = responsableFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
  
  Future<List<Responsable>?> addResponsable({Responsable? responsable}) async {
    try {
      var url =
          Uri.parse("${ApiConstants.baseUrl}${ApiConstants.responsable}add");
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          { 
        "email": responsable?.email,
        "motdepasse": responsable?.motdepasse,
        "departement": responsable?.departement?.idDep,
        "tel": responsable?.tel,
        "prenom": responsable?.prenom,
        "date_responsabilite": responsable?.Date_responsabilite,
        "nom": responsable?.nom
    },
        ),
      );
      log("addResponsablestatusCode::${response.body}");
      if (response.statusCode == 200) {
        // List<Responsable> _model = ResponsableFromJson(response.body);
        // return _model;
      }
    } catch (e) {
      log("addResponsableException:${e.toString()}");
    }
    return null;
  }

  Future<List<Responsable>?> deleteResponsable({required String id}) async {
    try {
      var url =
          Uri.parse("${ApiConstants.baseUrl}${ApiConstants.responsable}$id");
      var response = await http.delete(
        url,
      );
      // log("deleteResponsables::${response.body}");
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

}