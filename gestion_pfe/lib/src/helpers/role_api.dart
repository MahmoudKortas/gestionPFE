import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';
import '../models/role.dart';

class ApiRole {
  Future<List<Role>?> getAllRoles() async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.role + ApiConstants.all);
      var response = await http.get(url);
      // log("responseresponse:${response.body}");

      if (response.statusCode == 200) {
        List<Role> model = roleFromJson(response.body);
        return model;
      }
    } catch (e) {
      log("getAllRoles-error::${e.toString()}");
    }
    return null;
  }

  Future<List<Role>?> getRole({String? id = ""}) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.role + id!);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Role> model = roleFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<Role>?> addRole({Role? role}) async {
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.role}add");
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            "nom": role?.nom,
          },
        ),
      );
      log("addRolestatusCode::${response.body}");
      if (response.statusCode == 200) {
        // List<Role> _model = RoleFromJson(response.body);
        // return _model;
      }
    } catch (e) {
      log("addRoleException:${e.toString()}");
    }
    return null;
  }

  Future<List<Role>?> updateRole({Role? role}) async {
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.role}update");
      var response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            "idRole": role?.idRole,
            "nom": role?.nom,
          },
        ),
      );
      log("updateRolestatusCode::${response.body}");
      if (response.statusCode == 200) {
        // List<Role> _model = RoleFromJson(response.body);
        // return _model;
      }
    } catch (e) {
      log("updateRoleException:${e.toString()}");
    }
    return null;
  }

  Future<List<Role>?> deleteRole({required String id}) async {
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.role}$id");
      // var response = 
      await http.delete(
        url,
      );
      // log("deleteRoles::${response.body}");
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
