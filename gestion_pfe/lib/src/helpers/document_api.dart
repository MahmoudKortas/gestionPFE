import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:gestion_pfe/src/models/document.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';

class ApiDocument {
  Future<List<Document>?> getAllDocument() async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.document + ApiConstants.all);
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
      {String? id = "", String? filepath, required Document document}) async {
    String url = "${ApiConstants.baseUrl}${ApiConstants.document}add";
    try {
      // var urll = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.document}add");

      Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
      };
      var request;
      try {
        request = http.MultipartRequest('POST', Uri.parse(url))
          ..fields['Document'] = json.encode(document.toJson())
          ..headers.addAll(headers)
          ..files.add(await http.MultipartFile.fromPath(
              'file',
              filepath ??
                  "https://www.episup.com/sites/default/files/logo-epi.svg"));
      } catch (e) {
        request = http.MultipartRequest('POST', Uri.parse(url))
          ..fields['Document'] = json.encode(document.toJson())
          ..headers.addAll(headers);
      }

      // var response =
      await request.send();
      log("addDocument-request::${request.fields.toString()}");
    } catch (e) {
      debugPrint("addDocument-exception1::${e.toString()}");
      try {
        http.MultipartRequest request =
            http.MultipartRequest("POST", Uri.parse(url));

        http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
            'file',
            filepath ??
                "https://www.episup.com/sites/default/files/logo-epi.svg");

        request.files.add(multipartFile);

        http.StreamedResponse response = await request.send();

        debugPrint(response.toString());
      } catch (e) {
        debugPrint("addDocument-exception2::${e.toString()}");
      }
    }
    return null;
  }

  Future<List<Document>?> updateDocument(
      {String? id = "", String? filepath, Document? document}) async {
    String url = "${ApiConstants.baseUrl}${ApiConstants.document}update";
    filepath = filepath ?? document?.photo;
    id = id ?? document?.idDoc.toString();
    try {
      // var urll = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.document}add");

      Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
      };
      var request;
      try {
        request = http.MultipartRequest('PUT', Uri.parse(url))
          ..fields['Document'] = json.encode(document?.toJson())
          ..headers.addAll(headers)
          ..files.add(await http.MultipartFile.fromPath(
              'file',
              filepath ??
                  "https://www.episup.com/sites/default/files/logo-epi.svg"));
      } catch (e) {
        request = http.MultipartRequest('PUT', Uri.parse(url))
          ..fields['Document'] = json.encode(document?.toJson())
          ..headers.addAll(headers);
      }

      // var response =
      await request.send();
      log("addDocument-request::${request.fields.toString()}");
    } catch (e) {
      debugPrint("addDocument-exception1::${e.toString()}");
      try {
        http.MultipartRequest request =
            http.MultipartRequest("PUT", Uri.parse(url));

        http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
            'file',
            filepath ??
                "https://www.episup.com/sites/default/files/logo-epi.svg");

        request.files.add(multipartFile);

        http.StreamedResponse response = await request.send();

        debugPrint(response.toString());
      } catch (e) {
        debugPrint("addDocument-exception2::${e.toString()}");
      }
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
