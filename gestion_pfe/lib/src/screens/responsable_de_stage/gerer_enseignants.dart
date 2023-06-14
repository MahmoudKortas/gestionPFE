import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/helpers/departement.dart';
import 'package:gestion_pfe/src/helpers/enseignant_api.dart';
import 'package:gestion_pfe/src/models/departement.dart';
import '../../models/enseignant.dart';
import '../../resize_widget.dart';

class GererEnseignant extends StatefulWidget {
  const GererEnseignant({Key? key}) : super(key: key);
  static const routeName = '/GererEnseignant';
  @override
  State<GererEnseignant> createState() => _GererEnseignantState();
}

class _GererEnseignantState extends State<GererEnseignant> {
  late List<Enseignant>? _enseignant = [];
  final _items = [
    'informatique',
    'Mecanique',
    'electrique',
    'genie civile',
    'langues',
    'mathematique'
  ];
  String? domaineValue;
  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final telephoneController = TextEditingController();
  final adresseController = TextEditingController();
  final emailController = TextEditingController();
  final motDePasseController = TextEditingController();
  List<Departement?>? _departement;
  Departement? departementValue;
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
        title: const Text(' enseignants'),
      ),
      body: SingleChildScrollView(
        //  controller: controller,
        physics: const ScrollPhysics(),
        child: Center(
          child: resiseWidget(
            context: context,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: "Nom de l'enseignant",
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Entrez le nom de l'enseignant";
                    }
                    return null;
                  },
                  controller: nomController,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: "Prénom de l'enseignant",
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Entrez le prenom de l'enseignant";
                    }
                    return null;
                  },
                  controller: prenomController,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    hintText: "Numero du telephone de l'enseignant",
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Entrez le numero du telephone de l'enseignant";
                    }
                    return null;
                  },
                  controller: telephoneController,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.location_city),
                    hintText: "Adresse de l'enseignant",
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Entrez l'adresse de l'enseignant";
                    }
                    return null;
                  },
                  controller: adresseController,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: "Email de l'enseignant",
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Entrez l'email de l'enseignant";
                    }
                    return null;
                  },
                  controller: emailController,
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
                    hintText: "Mot de passe de l'enseignant",
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Entrez le mot de passe de l'enseignant";
                    }
                    return null;
                  },
                  controller: motDePasseController,
                ),
                DropdownButton<String>(
                  hint: const Text("Domaine de l'enseignant"),
                  value: domaineValue,
                  iconSize: 36,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                  items: _items.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(() => domaineValue = value),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                _departement != null
                    ? DropdownButton(
                        value: departementValue,
                        iconSize: 36,
                        hint: const Text("choisir ta departement"),
                        items: _departement?.map((item) {
                          return DropdownMenuItem<Departement>(
                            value: item,
                            child: Text(item!.nom!),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          log("newVal::$newVal");
                          setState(() {
                            departementValue = newVal as Departement?;
                          });
                        },
                      )
                    : Container(),
                ElevatedButton(
                  // ignore: avoid_print
                  onPressed: () {
                    log("${nomController.text} ${prenomController.text} ${telephoneController.text} ${adresseController.text} ${emailController.text} ${motDePasseController.text} $domaineValue");

                    addData(
                        nom: nomController.text,
                        prenom: prenomController.text,
                        telephone: telephoneController.text,
                        adresse: adresseController.text,
                        email: emailController.text,
                        motDePasse: motDePasseController.text,
                        domaine: domaineValue);
                  },
                  child: const Text("Ajouter"),
                ),
                /*_document == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    :*/
                _enseignant!.isEmpty
                    ? const Text("aucun enseignant existe")
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _enseignant!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              /*leading: const CircleAvatar(
                                  foregroundImage:
                                  AssetImage('assets/images/flutter_logo.png'),
                                  ),*/
                              title: Text(
                                  "${_enseignant![index].prenom} ${_enseignant![index].nom}"),
                              subtitle:
                                  Text(_enseignant![index].adresse.toString()),
                              trailing: const Icon(Icons.more_vert),
                              isThreeLine: true,
                              onTap: () {
                                dialog(context, _enseignant![index]);
                              },
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

  Future<String?> dialog(BuildContext context, Enseignant enseignant) {
    domaineValue = enseignant.domaine.toString();
    log("_enseignant::$_enseignant");
    //log("$nomvalue $prenomvalue $telephonevalue $adressevalue $emailvalue $passwordvalue $domaineValue");
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Modifier / Supprimer Enseignant'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  hintText: enseignant.nom,
                ),
                validator: (nomvalue) {
                  if (nomvalue == null || nomvalue.isEmpty) {
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
                  hintText: enseignant.prenom,
                ),
                validator: (prenomvalue) {
                  if (prenomvalue == null || prenomvalue.isEmpty) {
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
                  hintText: enseignant.tel.toString(),
                ),
                validator: (telephonevalue) {
                  if (telephonevalue == null || telephonevalue.isEmpty) {
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
                  hintText: enseignant.adresse,
                ),
                validator: (adressevalue) {
                  if (adressevalue == null || adressevalue.isEmpty) {
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
                  hintText: enseignant.email,
                ),
                validator: (emailvalue) {
                  if (emailvalue == null || emailvalue.isEmpty) {
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
                  hintText: enseignant.motdepasse,
                ),
                validator: (passwordvalue) {
                  if (passwordvalue == null || passwordvalue.isEmpty) {
                    return 'Entrez votre password';
                  }
                  return null;
                },
                controller: motDePasseController,
              ),
              DropdownButton<String>(
                hint: const Text("choisir votre domaine"),
                value: domaineValue,
                iconSize: 36,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                items: _items.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() => domaineValue = value),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              _departement != null
                  ? DropdownButton(
                      value: departementValue,
                      iconSize: 36,
                      hint: const Text("choisir ta departement"),
                      items: _departement?.map((item) {
                        return DropdownMenuItem<Departement>(
                          value: item,
                          child: Text(item!.nom!),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        log("newVal::$newVal");
                        setState(() {
                          departementValue = newVal as Departement?;
                        });
                      },
                    )
                  : Container(),
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
              log("${nomController.text} ${prenomController.text} ${telephoneController.text} ${adresseController.text} ${emailController.text} ${motDePasseController.text} $domaineValue");

              editEnseignant(
                  id: enseignant.idEns.toString(),
                  nom: nomController.text,
                  prenom: prenomController.text,
                  telephone: telephoneController.text,
                  adresse: adresseController.text,
                  email: emailController.text,
                  motDePasse: motDePasseController.text,
                  domaine: domaineValue);
            },
            child: const Text('Modifer'),
          ),
          TextButton(
            onPressed: () {
              deleteEnseignant(id: enseignant.idEns);
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
    await Future.wait([
      ApiEnseignant().getAllEnseignant(),
      ApiDepartement().getAllDepartements(),
    ]).then((value) async {
      log("get enseignant");
      _enseignant = value[0]?.cast<Enseignant>();
      log("_enseignant::$_enseignant");
      Future.delayed(const Duration(seconds: 0))
          .then((value) => setState(() {}));
    });
    // Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }

  void addData({
    String? nom = "",
    String? prenom = "",
    String? telephone = "",
    String? adresse = "",
    String? domaine = "",
    String? email = "",
    String? motDePasse = "",
    String? departement = "",
  }) async {
    //await ApiService().updateEtudiants("3");
    //await ApiService().deleteEtudiants("17");
    // await ApiService().addEtudiants();
    // await ApiService().addDocument();
    log("addEnseignant");
    await ApiEnseignant().addEnseignant(
        nom: nom,
        prenom: prenom,
        telephone: telephone,
        adresse: adresse,
        domaine: domaine,
        email: email,
        motDePasse: motDePasse,
        departement: departement);
    getData();
  }

  void editEnseignant(
      {String? id = "",
      String? nom = "",
      String? prenom = "",
      String? telephone = "",
      String? adresse = "",
      String? domaine = "",
      String? email = "",
      String? motDePasse = "",
      String? departement = ""}) async {
    log("editEnseignant");
    await ApiEnseignant().editEnseignant(
        id: id,
        nom: nom,
        prenom: prenom,
        telephone: telephone,
        adresse: adresse,
        domaine: domaine,
        email: email,
        motDePasse: motDePasse,
        departement: departement);
    getData();
  }

  void deleteEnseignant({int? id}) async {
    log("deleteEnseignant");
    await ApiEnseignant().deleteEnseignant(id.toString());
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
