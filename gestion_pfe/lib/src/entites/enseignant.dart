import 'package:gestion_pfe/src/entites/utilisateur.dart';

class Enseignant extends Utilisateur {
  final String fonction;

  Enseignant(super.id, super.nom, super.prenom, super.telephone, super.adresse,
      super.email, super.motDePasse, super.role, this.fonction);
}
