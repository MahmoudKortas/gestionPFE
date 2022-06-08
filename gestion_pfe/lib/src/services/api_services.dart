import 'dart:developer';
import 'package:gestion_pfe/src/entites/utilisateur.dart';
// ignore: depend_on_referenced_packages
import '../constants.dart';

class ApiService {
  Future<List<Utilisateur>?> getUsers() async {
    try {
      // ignore: unused_local_variable
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
      // var response = await http.get(url);
      // if (response.statusCode == 200) {
        // List<Utilisateur> _model = UtilisateurFromJson(response.body);
        // return _model;
      // }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
