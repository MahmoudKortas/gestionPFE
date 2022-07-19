import 'dart:convert';

List<Responsable> responsableFromJson(String str) => List<Responsable>.from(
    json.decode(str).map((x) => Responsable.fromJson(x)));

String responsableToJson(List<Responsable> data) =>
    json.encode(List<Responsable>.from(data.map((x) => x.toJson())));

class Responsable {
  int? idUser;
  String? login;
  String? motdepasse;

  Responsable({this.idUser, this.login, this.motdepasse});

  Responsable.fromJson(Map<String, dynamic> json) {
    idUser = json['idUser'];
    login = json['login'];
    motdepasse = json['motdepasse'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idUser'] = idUser;
    data['login'] = login;
    data['motdepasse'] = motdepasse;
    return data;
  }

  @override
  String toString() {
    return 'Responsable(idUser: $idUser, login: $login, motdepasse: $motdepasse)';
  }
}
