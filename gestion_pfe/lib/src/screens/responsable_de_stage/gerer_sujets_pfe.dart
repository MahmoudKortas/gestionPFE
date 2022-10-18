import 'dart:developer';

import 'package:flutter/material.dart';

import '../../helpers/api_service.dart';
import '../../models/pfe.dart';
import '../../resize_widget.dart';

/// Displays detailed information about a SampleItem.
class GererSujetsPFE extends StatefulWidget {
  const GererSujetsPFE({Key? key}) : super(key: key);

  static const routeName = '/PFESubject';

  @override
  State<GererSujetsPFE> createState() => _GererSujetsPFEState();
}

class _GererSujetsPFEState extends State<GererSujetsPFE> {
  late List<PFE>? _pfe = [];

  final noteController = TextEditingController();
  final titreController = TextEditingController();
  final domaineController = TextEditingController();
  final encadreurController = TextEditingController();
  final etudiantController = TextEditingController();
  final dateDebutController = TextEditingController();
  final dateFinController = TextEditingController();
  final dateSoutenanceController = TextEditingController();
  final documentController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    noteController.dispose();
    titreController.dispose();
    domaineController.dispose();
    encadreurController.dispose();
    etudiantController.dispose();
    dateDebutController.dispose();
    dateFinController.dispose();
    dateSoutenanceController.dispose();
    documentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gérer sujets PFE'),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        // controller: controller,
        child: Center(
          child: resiseWidget(
            context: context,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: noteController,
                  decoration: const InputDecoration(
                    hintText: 'Saisir le note du PFE',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: titreController,
                  decoration: const InputDecoration(
                    hintText: 'Saisir le titre du PFE',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: domaineController,
                  decoration: const InputDecoration(
                    hintText: 'Saisir le domaine du PFE',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: encadreurController,
                  decoration: const InputDecoration(
                    hintText: "Saisir l'encadreur du PFE",
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: etudiantController,
                  decoration: const InputDecoration(
                    hintText: "Saisir l'etudiant' du PFE",
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: dateDebutController,
                  decoration: const InputDecoration(
                    hintText: 'Saisir date debut du PFE',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: dateFinController,
                  decoration: const InputDecoration(
                    hintText: 'Saisir date fin du PFE',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: dateSoutenanceController,
                  decoration: const InputDecoration(
                    hintText: 'Saisir date soutenance du PFE',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: documentController,
                  decoration: const InputDecoration(
                    hintText: 'Saisir document du PFE',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      log("${noteController.text} ${titreController.text} ${domaineController.text} ${encadreurController.text} ${etudiantController.text} ${dateDebutController.text} ${dateFinController.text} ${dateSoutenanceController.text} ${documentController.text} ");
                      addData(
                        note: noteController.text,
                        titre: titreController.text,
                        domaine: domaineController.text,
                        encadreur: encadreurController.text,
                        etudiant: etudiantController.text,
                        dateDebut: dateDebutController.text,
                        dateFin: dateFinController.text,
                        dateSoutenance: dateSoutenanceController.text,
                        document: documentController.text,
                      );
                    },
                    child: const Text('Ajouter'),
                  ),
                ),
                _pfe!.isEmpty
                    ? const Text("aucun pfe existe")
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _pfe!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                              title: Text('SampleItem $index'),
                              subtitle: const Text(
                                  'A sufficiently long subtitle warrants three lines.'),
                              trailing: const Icon(Icons.more_vert),
                              isThreeLine: true,
                              onTap: () => dialog(context, _pfe![index]),
                            ),
                          );
                        },
                      ),
                /* Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text('SampleItem'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () => dialog(context),
                  ),
                ),
                Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text('SampleItem'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () => dialog(context),
                  ),
                ),
                Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text('SampleItem'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () => dialog(context),
                  ),
                ),
              */
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> dialog(BuildContext context, PFE pfe) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Modifier / Supprimer PFE'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Saisir le note du PFE',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Saisir le titre du PFE',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Saisir le domaine du PFE',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Saisir l'encadreur du PFE",
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Saisir l'etudiant' du PFE",
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Saisir date debut du PFE',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Saisir date fin du PFE',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Saisir date soutenance du PFE',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Saisir document du PFE',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
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
            onPressed: () => Navigator.pop(context, 'Modifer'),
            child: const Text('Modifer'),
          ),
          TextButton(
            onPressed: () {
              deleteSujetPfe(pfe.idPFE);
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
    _pfe = await ApiService().getPFE();
    log("_enseignant::$_pfe");
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }

  void addData({
    String? nom = "",
    String? prenom = "",
    String? telephone = "",
    String? adresse = "",
    String? email = "",
    String? motDePasse = "",
    String? note = "",
    String? titre = "",
    String? domaine = "",
    String? encadreur = "",
    String? etudiant = "",
    String? dateDebut = "",
    String? dateFin = "",
    String? dateSoutenance = "",
    String? document = "",
  }) async {
    //await ApiService().updateEtudiants("3");
    //await ApiService().deleteEtudiants("17");
    // await ApiService().addEtudiants();
    // await ApiService().addDocument();
    log("addEnseignant");
    await ApiService().addPFE(
        note: noteController.text,
        titre: titre,
        domaine: domaine,
        encadreur: encadreur,
        etudiant: etudiant,
        dateDebut: dateDebut,
        dateFin: dateFin,
        dateSoutenance: dateSoutenance,
        document: document);
    getData();
  }
  
  void deleteSujetPfe(int? id) async {
    log("deleteSujetPfe");
    await ApiService().deleteSoutenance(id: id.toString());
    getData();
  }
}
