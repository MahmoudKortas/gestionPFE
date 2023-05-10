import 'dart:developer';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';
import '../models/responsable.dart';

class ApiResponsable {
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
}
