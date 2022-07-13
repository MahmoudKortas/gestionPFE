// To parse this JSON data, do
//
//     final enseignant = enseignantFromJson(jsonString);

import 'dart:convert';

List<Enseignant> enseignantFromJson(String str) =>
    List<Enseignant>.from(json.decode(str).map((x) => Enseignant.fromJson(x)));

String enseignantToJson(List<Enseignant> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Enseignant {
  Enseignant({
    this.idEns,
    this.nom,
    this.prenom,
    this.tel,
    this.adresse,
    this.domaine,
    this.email,
    this.motdepasse,
  });

  int? idEns;
  String? nom;
  String? prenom;
  int? tel;
  String? adresse;
  String? domaine;
  String? email;
  String? motdepasse;

  factory Enseignant.fromJson(Map<String, dynamic> json) => Enseignant(
        idEns: json["idEns"],
        nom: json["nom"],
        prenom: json["prenom"],
        tel: json["tel"],
        adresse: json["adresse"],
        domaine: json["domaine"],
        email: json["email"],
        motdepasse: json["motdepasse"],
      );

  Map<String, dynamic> toJson() => {
        "idEns": idEns,
        "nom": nom,
        "prenom": prenom,
        "tel": tel,
        "adresse": adresse,
        "domaine": domaine,
        "email": email,
        "motdepasse": motdepasse,
      };
  @override
  String toString() {
    return 'Enseignant(idEns: $idEns, nom: $nom, prenom: $prenom, tel: $tel, adresse: $adresse, domaine: $domaine, email: $email, motdepasse: $motdepasse)';
  }
}
