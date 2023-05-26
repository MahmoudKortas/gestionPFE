import 'dart:convert';
import 'dart:developer';
import 'package:gestion_pfe/src/models/document.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';
class ApiDocument {
    Future<List<Document>?> getAllDocument() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.document + ApiConstants.all);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Document> model = documentFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
    Future<List<Document>?> getDocument({String? id = ""}) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.document + id!);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Document> model = documentFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<Document>?> addDocument(
      {String? id = "",
      String? filepath = "",
      required Document document}) async {
    try {
      // var urll = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.document}add");
      String url = "${ApiConstants.baseUrl}${ApiConstants.document}add";
      Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
      };

      var request = http.MultipartRequest('POST', Uri.parse(url))
        ..fields['Document'] = json.encode(document.toJson())
        ..headers.addAll(headers)
        ..files.add(await http.MultipartFile.fromPath('file', filepath!));
      var response = await request.send();
      log(request.fields.toString());
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<Document>?> deleteDocument({String? id}) async {
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.document}$id");
      var response = await http.delete(
        url,
      );
      log("deleteDocument::${response.body}");
    } catch (e) {
      log("exceptionDeleteDocument::${e.toString()}");
    }
    return null;
  }
}