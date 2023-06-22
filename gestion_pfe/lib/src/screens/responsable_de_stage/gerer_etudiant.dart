import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/helpers/departement.dart';
import 'package:gestion_pfe/src/helpers/etudiant_api.dart';
import 'package:gestion_pfe/src/helpers/specialite.dart';
import 'package:gestion_pfe/src/models/departement.dart';
import 'package:gestion_pfe/src/models/specialite.dart';

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
  // final _items = ['Informatique', 'Mecanique', 'Electrique', 'Genie civile'];
  final _niveauItems = [
    'Licence',
    'Ingenieurie',
    'Mastère',
  ];
  late List<Etudiant>? _etudiant = [];

  String? niveauValue;

  List<Specialite?>? _specialite;
  Specialite? specialiteValue;

  List<Departement?>? _departement;
  Departement? departementValue;

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
        title: const Text(' Etudiants'),
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
                  hint: const Text("choisir votre niveau"),
                  value: niveauValue,
                  iconSize: 36,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                  items: _niveauItems.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(() => niveauValue = value),
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
                _specialite != null
                    ? DropdownButton(
                        value: specialiteValue,
                        iconSize: 36,
                        hint: const Text("choisir ta specialite"),
                        items: _specialite?.map((item) {
                          return DropdownMenuItem<Specialite>(
                            value: item,
                            child: Text(item!.nom!),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          log("newVal::$newVal");
                          setState(() {
                            specialiteValue = newVal as Specialite?;
                          });
                        },
                      )
                    : Container(),
                ElevatedButton(
                  onPressed: () {
                    log("${nomController.text} ${prenomController.text} ${telephoneController.text} ${adresseController.text} ${emailController.text} ${motDePasseController.text} $niveauValue ${departementValue?.nom} ${specialiteValue?.nom}");
                    try {
                      addData(
                          nom: nomController.text,
                          prenom: prenomController.text,
                          telephone: telephoneController.text,
                          adresse: adresseController.text,
                          email: emailController.text,
                          motDePasse: motDePasseController.text,
                          departement: departementValue?.idDep.toString(),
                          niveau: niveauValue,
                          specialite: specialiteValue?.idSpecialite.toString());
                    } catch (e) {
                      log("gerer-etudiant-exception::${e.toString()}");
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("quelque chose ne va pas"),
                            backgroundColor: Colors.red),
                      );
                    }
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
                              onTap: () => dialog(context, _etudiant![index]),
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

  Future<String?> dialog(BuildContext context, Etudiant etudiant) {
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
              DropdownButton<String>(
                hint: const Text("choisir votre niveau"),
                value: niveauValue,
                iconSize: 36,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                items: _niveauItems.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() => niveauValue = value),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              _specialite != null
                  ? DropdownButton(
                      value: specialiteValue,
                      iconSize: 36,
                      hint: const Text("choisir ta specialite"),
                      items: _specialite?.map((item) {
                        return DropdownMenuItem<Specialite>(
                          value: item,
                          child: Text(item!.nom!),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        log("newVal::$newVal");
                        setState(() {
                          specialiteValue = newVal as Specialite?;
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
              editStudent(etudiant);
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
    await Future.wait([
      ApiEtudiant().getAllEtudiants(),
      ApiDepartement().getAllDepartements(),
      ApiSpecialite().getAllSpecialites(),
    ]).then((value) async {
      log("get");
      _etudiant = value[0]?.cast<Etudiant>();
      _departement = value[1]?.cast<Departement>();
      _specialite = value[2]?.cast<Specialite>();
      log("_etudiant::$_etudiant");
      Future.delayed(const Duration(seconds: 0))
          .then((value) => setState(() {}));
    });
  }

  void addData({
    String? nom = "",
    String? prenom = "",
    String? telephone = "",
    String? adresse = "",
    String? email = "",
    String? motDePasse = "",
    String? departement = "",
    String? niveau = "",
    String? specialite = "",
  }) async {
    log("addStudent");
    await ApiEtudiant().addEtudiants(
        nom: nom,
        prenom: prenom,
        telephone: telephone,
        adresse: adresse,
        email: email,
        motDePasse: motDePasse,
        departement: departement,
        niveau: niveau,
        specialite: specialite);
    getData();
  }

  void deleteStudent({int? id}) async {
    log("deleteStudent");
    await ApiEtudiant().deleteEtudiant(id: id.toString());
    getData();
  }

  void editStudent(Etudiant etudiant) async {
    log("editStudent");
    await ApiEtudiant()
        .updateEtudiants(etudiant)
        .then((value) => log("updateEtudiants::$value"));
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
