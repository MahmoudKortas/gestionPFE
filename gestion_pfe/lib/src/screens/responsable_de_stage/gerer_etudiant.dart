import 'dart:developer';

import 'package:flutter/material.dart';

import '../../helpers/api_service.dart';
import '../../models/etudiant.dart';
import '../../resize_widget.dart';

/// Displays detailed information about a SampleItem.
class GererEtudiant extends StatefulWidget {
  const GererEtudiant({Key? key}) : super(key: key);

  static const routeName = '/GererEtudiant';
  @override
  State<GererEtudiant> createState() => _GererEtudiantState();
}

class _GererEtudiantState extends State<GererEtudiant> {
  final _items = ['Informatique', 'Mecanique', 'Electrique', 'Genie civile'];
  final _niveauItems = [
    'Licence',
    'Ingenieurie',
    'Mastère',
  ];
  late List<Etudiant>? _etudiant = [];

  String? diplomeValue;
  String? departementValue;
  String? niveauValue;
  String? specialiteValue;
  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final telephoneController = TextEditingController();
  final adresseController = TextEditingController();
  final emailController = TextEditingController();
  final motDePasseController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    nomController.dispose();
    prenomController.dispose();
    telephoneController.dispose();
    adresseController.dispose();
    emailController.dispose();
    motDePasseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gérer Etudiants'),
      ),
      body: SingleChildScrollView(
        // controller: controller,
        physics: const ScrollPhysics(),
        child: Center(
          child: resiseWidget(
            context: context,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Saisir votre nom',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Entrez votre nom';
                    }
                    return null;
                  },
                  controller: nomController,
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Saisir votre prenom',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Entrez votre prenom';
                    }
                    return null;
                  },
                  controller: prenomController,
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    hintText: 'Saisir votre telephone',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Entrez votre telephone';
                    }
                    return null;
                  },
                  controller: telephoneController,
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.location_city),
                    hintText: 'Saisir votre adresse',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Entrez votre adresse';
                    }
                    return null;
                  },
                  controller: adresseController,
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Saisir votre email',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Entrez votre email';
                    }
                    return null;
                  },
                  controller: emailController,
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: 'Saisir votre password',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Entrez votre password';
                    }
                    return null;
                  },
                  controller: motDePasseController,
                ),
                DropdownButton<String>(
                  hint: const Text("choisir votre diplome"),
                  value: diplomeValue,
                  iconSize: 36,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                  items: _items.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(() => diplomeValue = value),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                DropdownButton<String>(
                  hint: const Text("choisir votre departement"),
                  value: departementValue,
                  iconSize: 36,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                  items: _items.map(buildMenuItem).toList(),
                  onChanged: (value) =>
                      setState(() => departementValue = value),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                DropdownButton<String>(
                  hint: const Text("choisir votre niveau"),
                  value: niveauValue,
                  iconSize: 36,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                  items: _niveauItems.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(() => niveauValue = value),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                DropdownButton<String>(
                  hint: const Text("choisir votre specialité"),
                  value: specialiteValue,
                  iconSize: 36,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                  items: _items.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(() => specialiteValue = value),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                ElevatedButton(
                  onPressed: () {
                    log("${nomController.text} ${prenomController.text} ${telephoneController.text} ${adresseController.text} ${emailController.text} ${motDePasseController.text}  $diplomeValue $departementValue $niveauValue $specialiteValue");

                    addData(
                        nom: nomController.text,
                        prenom: prenomController.text,
                        telephone: telephoneController.text,
                        adresse: adresseController.text,
                        email: emailController.text,
                        motDePasse: motDePasseController.text,
                        diplome: diplomeValue,
                        departement: departementValue,
                        niveau: niveauValue,
                        specialite: specialiteValue);
                  },
                  child: const Text("Ajouter"),
                ),
                _etudiant!.isEmpty
                    ? const Text("aucun étudiant existe")
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _etudiant!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(
                                  "${_etudiant![index].prenom} ${_etudiant![index].nom}"),
                              subtitle: Text(
                                _etudiant![index].email.toString(),
                              ),
                              trailing: const Icon(Icons.more_vert),
                              isThreeLine: true,
                              onTap: () =>
                                  dialog(context, _etudiant![index] ),
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> dialog(BuildContext context, Etudiant etudiant ) {
    diplomeValue = etudiant.diplome;
    departementValue = etudiant.departement;
    niveauValue = etudiant.niveau;
    specialiteValue = etudiant.specialite;
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Modifier / Supprimer etudiant'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  hintText: etudiant.nom,
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Entrez votre nom';
                  }
                  return null;
                },
                controller: nomController,
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  hintText: etudiant.prenom,
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Entrez votre prenom';
                  }
                  return null;
                },
                controller: prenomController,
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.phone),
                  hintText: etudiant.tel.toString(),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Entrez votre telephone';
                  }
                  return null;
                },
                controller: telephoneController,
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.location_city),
                  hintText: etudiant.adresse,
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Entrez votre adresse';
                  }
                  return null;
                },
                controller: adresseController,
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  hintText: etudiant.email,
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Entrez votre email';
                  }
                  return null;
                },
                controller: emailController,
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  hintText: etudiant.motdepasse,
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Entrez votre password';
                  }
                  return null;
                },
                controller: motDePasseController,
              ),
              DropdownButton<String>(
                hint: const Text("choisir votre diplome"),
                value: diplomeValue,
                iconSize: 36,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                items: _items.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() => diplomeValue = value),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              DropdownButton<String>(
                hint: const Text("choisir votre departement"),
                value: departementValue,
                iconSize: 36,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                items: _items.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() => departementValue = value),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              DropdownButton<String>(
                hint: const Text("choisir votre niveau"),
                value: niveauValue,
                iconSize: 36,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                items: _niveauItems.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() => niveauValue = value),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              DropdownButton<String>(
                hint: const Text("choisir votre specialité"),
                value: specialiteValue,
                iconSize: 36,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                items: _items.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() => specialiteValue = value),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Annuler'),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              editStudent( etudiant);
              Navigator.pop(context, 'Modifer');
            },
            child: const Text('Modifer'),
          ),
          TextButton(
            onPressed: () {
              deleteStudent(id: etudiant.idEtud);
              Navigator.pop(context, 'Supprimer');
            },
            child: const Text('Supprimer'),
          ),
          /*TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),*/
        ],
      ),
    );
  }

  void getData() async {
    //await ApiService().updateEtudiants("3");
    //await ApiService().deleteEtudiants("17");
    // await ApiService().addEtudiants();
    // await ApiService().addDocument();
    //await ApiService().addEnseignant();
    log("get");
    _etudiant = await ApiService().getEtudiants();
    log("_etudiant::$_etudiant");
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }

  void addData({
    String? nom = "",
    String? prenom = "",
    String? telephone = "",
    String? adresse = "",
    String? email = "",
    String? motDePasse = "",
    String? diplome = "",
    String? departement = "",
    String? niveau = "",
    String? specialite = "",
  }) async {
    log("addStudent");
    await ApiService().addEtudiants(
        nom: nom,
        prenom: prenom,
        telephone: telephone,
        adresse: adresse,
        email: email,
        motDePasse: motDePasse,
        diplome: diplome,
        departement: departement,
        niveau: niveau,
        specialite: specialite);
    getData();
  }

  void deleteStudent({int? id}) async {
    log("deleteStudent");
    await ApiService().deleteEtudiant(id: id.toString());
    getData();
  }
  
  void editStudent(Etudiant etudiant) async {
    log("editStudent");
    await ApiService().updateEtudiants( etudiant).then((value) => log("updateEtudiants::$value"));
    getData();
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ), // Text
      );
}
