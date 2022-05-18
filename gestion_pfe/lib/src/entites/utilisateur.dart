class Utilisateur{
  const Utilisateur(this.id, this.nom, this.prenom, this.telephone, this.adresse, this.email, this.motDePasse, this.role);

  final int id; 
  final String nom;
  final String prenom;
  final int telephone;
  final String adresse;
  final String email;
  final String motDePasse;
  final String role;
}