// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:developer';

import 'package:flutter/material.dart';
import '../../helpers/api_service.dart';
import '../../models/enseignant.dart';
import '../../resize_widget.dart';

/// Displays detailed information about a SampleItem.
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
        title: const Text('Gérer enseignants'),
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
                  hint: const Text("choisir votre domaine"),
                  value: domaineValue,
                  iconSize: 36,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                  items: _items.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(() => domaineValue = value),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
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
                                // Navigate to the details page. If the user leaves and returns to
                                // the app after it has been killed while running in the
                                // background, the navigation stack is restored.
                                /*Navigator.restorablePushNamed(
                                    context,
                                    LogIn.routeName,
                                  );*/
                              },
                            ),
                          );
                        },
                      ),

                /*Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text('Enseignant 2'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () {
                      // Navigate to the details page. If the user leaves and returns to
                      // the app after it has been killed while running in the
                      // background, the navigation stack is restored.
                      /*Navigator.restorablePushNamed(
                    context,
                    LogIn.routeName,
                  );*/
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text('Enseignant 3'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () {
                      // Navigate to the details page. If the user leaves and returns to
                      // the app after it has been killed while running in the
                      // background, the navigation stack is restored.
                      /*Navigator.restorablePushNamed(
                    context,
                    LogIn.routeName,
                  );*/
                    },
                  ),
                ),
             */
                //)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> dialog(BuildContext context, Enseignant enseignant) {
     domaineValue = enseignant.domaine.toString();
    log("${_enseignant}");
    //log("$nomvalue $prenomvalue $telephonevalue $adressevalue $emailvalue $passwordvalue $domaineValue");
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
                decoration:  InputDecoration(
                  prefixIcon:const Icon(Icons.person),
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
                decoration:  InputDecoration(
                  prefixIcon:const Icon(Icons.person),
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
                decoration:  InputDecoration(
                  prefixIcon:const Icon(Icons.phone),
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
                decoration:  InputDecoration(
                  prefixIcon:const Icon(Icons.location_city),
                  hintText: enseignant.adresse,
                ),
                validator: (adressevalue) {
                  if (adressevalue == null || adressevalue.isEmpty) {
                    return 'Entrez votre adresse';
                  }
                  return null;
                },
                controller: adresseController ,
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration:  InputDecoration(
                  prefixIcon:const Icon(Icons.email),
                  hintText: enseignant.email,
                ),
                validator: (emailvalue) {
                  if (emailvalue == null || emailvalue.isEmpty) {
                    return 'Entrez votre email';
                  }
                  return null;
                },
                controller: emailController ,
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
                decoration:  InputDecoration(
                  prefixIcon:const Icon(Icons.lock),
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
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Annuler'),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => log(
                "${nomController.text} ${prenomController.text} ${telephoneController.text} ${adresseController.text} ${emailController.text} ${motDePasseController.text} $domaineValue "), //Navigator.pop(context, 'Modifer'),
            child: const Text('Modifer'),
          ),
          TextButton(
            onPressed: () {
              deleteEnseignant(id: enseignant.idEns);
              Navigator.pop(context, 'Supprimer');
            } ,
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
    _enseignant = await ApiService().getEnseignant();
    log("_enseignant::$_enseignant");
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }

  void addData({
    String? nom = "",
    String? prenom = "",
    String? telephone = "",
    String? adresse = "",
    String? email = "",
    String? motDePasse = "",
    String? domaine = "",
  }) async {
    //await ApiService().updateEtudiants("3");
    //await ApiService().deleteEtudiants("17");
    // await ApiService().addEtudiants();
    // await ApiService().addDocument();
    log("addEnseignant");
    await ApiService().addEnseignant(
        nom: nom,
        prenom: prenom,
        telephone: telephone,
        adresse: adresse,
        email: email,
        motDePasse: motDePasse,
        domaine: domaine);
    getData();
  }
void deleteEnseignant({int? id}) async {
    log("deleteEnseignant");
    await ApiService().deleteEnseignant(id.toString());
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
