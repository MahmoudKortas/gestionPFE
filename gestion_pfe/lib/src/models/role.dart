// To parse this JSON data, do
//
//     final Role = roleFromJson(jsonString);

import 'dart:convert';

List<Role> roleFromJson(String str) =>
    List<Role>.from(json.decode(str).map((x) => Role.fromJson(x)));

String roleToJson(List<Role> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson()))); 

class Role {
  int? idRole;
  String? nom;

  Role(
      {this.idRole,
      this.nom});

  Role.fromJson(Map<String, dynamic> json) {
    idRole = json['idRole'];
    nom = json['nom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idRole'] = idRole;
    data['nom'] = nom;
    return data;
  }

  @override
  String toString() {
    return 'Role(idRole: $idRole, nom: $nom)';
  }
}
