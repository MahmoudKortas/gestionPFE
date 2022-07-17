// To parse this JSON data, do
//
//     final etudiant = etudiantFromJson(jsonString);

import 'dart:convert';

List<Etudiant> etudiantFromJson(String str) =>
    List<Etudiant>.from(json.decode(str).map((x) => Etudiant.fromJson(x)));

String etudiantToJson(List<Etudiant> data) =>
    json.encode(List<Etudiant>.from(data.map((x) => x.toJson())));

class Etudiant {
  Etudiant({
    this.idEtud,
    this.nom,
    this.prenom,
    this.tel,
    this.adresse,
    this.niveau,
    this.specialite,
    this.diplome,
    this.departement,
    this.email,
    this.motdepasse,
  });

  int? idEtud;
  String? nom;
  String? prenom;
  int? tel;
  String? adresse;
  String? niveau;
  String? specialite;
  String? diplome;
  String? departement;
  String? email;
  String? motdepasse;

  factory Etudiant.fromJson(Map<String, dynamic> json) => Etudiant(
        idEtud: json["idEtud"],
        nom: json["nom"],
        prenom: json["prenom"],
        tel: json["tel"],
        adresse: json["adresse"],
        niveau: json["niveau"],
        specialite: json["specialite"],
        diplome: json["diplome"],
        departement: json["departement"],
        email: json["email"],
        motdepasse: json["motdepasse"],
      );

  Map<String, dynamic> toJson() => {
        "idEtud": idEtud,
        "nom": nom,
        "prenom": prenom,
        "tel": tel,
        "adresse": adresse,
        "niveau": niveau,
        "specialite": specialite,
        "diplome": diplome,
        "departement": departement,
        "email": email,
        "motdepasse": motdepasse,
      };
  @override
  String toString() {
    return 'Etudiant(idEtud: $idEtud, nom: $nom, prenom: $prenom, tel: $tel, adresse: $adresse, niveau: $niveau, specialite: $specialite, diplome: $diplome, departement: $departement, email: $email, motdepasse: $motdepasse)';
  }
}
