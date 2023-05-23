import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/helpers/document_api.dart';
import 'package:gestion_pfe/src/helpers/etudiant_api.dart';
import 'package:gestion_pfe/src/helpers/pfe_api.dart';
import 'package:gestion_pfe/src/helpers/salle.dart';
import 'package:gestion_pfe/src/helpers/seance_api.dart';
import 'package:gestion_pfe/src/helpers/soutenance_api.dart';
import 'package:gestion_pfe/src/helpers/specialite.dart';
import '../../helpers/enseignant_api.dart';
import '../../models/pfe.dart';
import '../../resize_widget.dart';

class GererSujetsPFE extends StatefulWidget {
  const GererSujetsPFE({Key? key}) : super(key: key);

  static const routeName = '/PFESubject';

  @override
  State<GererSujetsPFE> createState() => _GererSujetsPFEState();
}

class _GererSujetsPFEState extends State<GererSujetsPFE> {
  late List<PFE>? _pfe = [];
  var _enseignant;
  var _etudiant;
  var _document;
  var _seance;
  var _salle;
  var _specialite;
  var _listeEnseignant = [''];
  var _listeEtudiant = [''];
  var _listeDocument = [''];
  var _listeSeance = [''];
  var _listeSalle = ['']; 
  var _listeSpecialite = [''];

  final noteController = TextEditingController();
  final titreController = TextEditingController();
  final domaineController = TextEditingController();
  final encadreurController = TextEditingController();
  final presidentController = TextEditingController();
  final rapporteurController = TextEditingController();
  final etudiantController = TextEditingController();
  final dateDebutController = TextEditingController();
  final dateFinController = TextEditingController();
  final dateSoutenanceController = TextEditingController();
  final salleController = TextEditingController();
  final seanceController = TextEditingController();
  final documentController = TextEditingController();
  String? domaineValue;
  String? encadrantValue;
  String? presidentValue;
  String? rapporteurValue;
  String? etudiantValue;
  String? salleValue;
  String? seanceValue;
  String? documentValue;
  String? encadreur2Value;
  String? president2Value;
  String? rapporteur2Value;
  String? salle2Value;
  String? seance2Value;
  String? specialiteValue;
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
    presidentController.dispose();
    rapporteurController.dispose();
    etudiantController.dispose();
    dateDebutController.dispose();
    dateFinController.dispose();
    dateSoutenanceController.dispose();
    salleController.dispose();
    seanceController.dispose();
    documentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: "Tous",),
              Tab(text: "departement 1",),
              Tab(text: "departement 2",),
            ],
          ),
          title: const Text('Gérer sujets PFE'),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
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
                      DropdownButton<String>(
                        hint: const Text("choisir la specialite du PFE"),
                        value: specialiteValue,
                        iconSize: 36,
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.black),
                        items: _listeSpecialite
                            .map(buildMenuItem)
                            .toList(), //_items.map(buildMenuItem).toList(),
                        onChanged: (value) =>
                            setState(() => specialiteValue = value),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      /*TextFormField(
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
                ),*/
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButton<String>(
                        hint: const Text("choisir l'encadrant"),
                        value: encadrantValue,
                        iconSize: 36,
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.black),
                        items: _listeEnseignant
                            .map(buildMenuItem)
                            .toList(), //_items.map(buildMenuItem).toList(),
                        onChanged: (value) =>
                            setState(() => encadrantValue = value),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      /*TextFormField(
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
                ),*/
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButton<String>(
                        hint: const Text("choisir le président"),
                        value: presidentValue,
                        iconSize: 36,
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.black),
                        items: _listeEnseignant
                            .map(buildMenuItem)
                            .toList(), //_items.map(buildMenuItem).toList(),
                        onChanged: (value) =>
                            setState(() => presidentValue = value),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      /*TextFormField(
                  controller: presidentController,
                  decoration: const InputDecoration(
                    hintText: "Saisir le président du PFE",
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),*/
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButton<String>(
                        hint: const Text("choisir le rapporteur"),
                        value: rapporteurValue,
                        iconSize: 36,
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.black),
                        items: _listeEnseignant
                            .map(buildMenuItem)
                            .toList(), //_items.map(buildMenuItem).toList(),
                        onChanged: (value) =>
                            setState(() => rapporteurValue = value),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      /*TextFormField(
                  controller: rapporteurController,
                  decoration: const InputDecoration(
                    hintText: "Saisir le rapporteur du PFE",
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),*/
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButton<String>(
                        hint: const Text("choisir l'etudiant"),
                        value: etudiantValue,
                        iconSize: 36,
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.black),
                        items: _listeEtudiant
                            .map(buildMenuItem)
                            .toList(), //_items.map(buildMenuItem).toList(),
                        onChanged: (value) =>
                            setState(() => etudiantValue = value),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      /*TextFormField(
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
                ),*/
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
                      DropdownButton<String>(
                        hint: const Text("choisir salle"),
                        value: salleValue,
                        iconSize: 36,
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.black),
                        items: _listeSalle
                            .map(buildMenuItem)
                            .toList(), //_items.map(buildMenuItem).toList(),
                        onChanged: (value) =>
                            setState(() => salleValue = value),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      /*TextFormField(
                  controller: salleController,
                  decoration: const InputDecoration(
                    hintText: 'Saisir salle du PFE',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),*/
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButton<String>(
                        hint: const Text("choisir seance"),
                        value: seanceValue,
                        iconSize: 36,
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.black),
                        items: _listeSeance
                            .map(buildMenuItem)
                            .toList(), //_items.map(buildMenuItem).toList(),
                        onChanged: (value) =>
                            setState(() => seanceValue = value),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      /*TextFormField(
                  controller: seanceController,
                  decoration: const InputDecoration(
                    hintText: 'Saisir date seance du PFE',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),*/
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButton<String>(
                        hint: const Text("choisir document"),
                        value: documentValue,
                        iconSize: 36,
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.black),
                        items: _listeDocument
                            .map(buildMenuItem)
                            .toList(), //_items.map(buildMenuItem).toList(),
                        onChanged: (value) =>
                            setState(() => documentValue = value),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      /*TextFormField(
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
                ),*/
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            log("${noteController.text} ${titreController.text} ${domaineController.text} ${encadreurController.text} ${presidentController.text} ${rapporteurController.text} ${etudiantController.text} ${dateDebutController.text} ${dateFinController.text} ${dateSoutenanceController.text} ${salleController.text} ${seanceController.text} ${documentController.text} ");
                            addData(
                              note: noteController.text,
                              titre: titreController.text,
                              domaine: domaineController.text,
                              encadreur: encadreurController.text,
                              president: presidentController.text,
                              rapporteur: rapporteurController.text,
                              etudiant: etudiantController.text,
                              dateDebut: dateDebutController.text,
                              dateFin: dateFinController.text,
                              dateSoutenance: dateSoutenanceController.text,
                              salle: salleController.text,
                              seance: seanceController.text,
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
                                    title: Text('${_pfe?[index].title} $index'),
                                    subtitle: Text(
                                        '${_pfe?[index].etudiant?.nom} ${_pfe?[index].etudiant?.prenom}-${_pfe?[index].encadreur?.nom} ${_pfe?[index].encadreur?.prenom}'),
                                    trailing: const Icon(Icons.more_vert),
                                    isThreeLine: true,
                                    onTap: () =>
                                        dialogStep1(context, _pfe![index]),
                                        onLongPress: () =>
                                        dialog(context, _pfe![index]) ,
                                        
                                  ),
                                );
                              },
                            ),
                  
                    ],
                  ),
                ),
              ),
            ),
            const Icon(Icons.directions_car),
            const Icon(Icons.directions_transit),
          ],
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

  Future<String?> dialogStep1(BuildContext context, PFE pfe) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Ajouter jury'),
        // title: Text('Ajouter jury ${pfe} '),
        content: SingleChildScrollView(
          child: Column(
            children: [
              DropdownButton<String>(
                hint: const Text("choisir l'encadrant"),
                value: encadreur2Value,
                iconSize: 36,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                items: _listeEnseignant
                    .map(buildMenuItem)
                    .toList(), //_items.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() => encadreur2Value = value),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              /* TextFormField(
                decoration: const InputDecoration(
                  hintText: "Saisir l'encadreur du PFE",
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),*/
              const SizedBox(
                height: 10,
              ),
              DropdownButton<String>(
                hint: const Text("choisir le president"),
                value: president2Value,
                iconSize: 36,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                items: _listeEnseignant
                    .map(buildMenuItem)
                    .toList(), //_items.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() => president2Value = value),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              /*TextFormField(
                decoration: const InputDecoration(
                  hintText: "Saisir l'president du PFE",
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),*/
              const SizedBox(
                height: 10,
              ),
              DropdownButton<String>(
                hint: const Text("choisir le rapporteur"),
                value: rapporteur2Value,
                iconSize: 36,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                items: _listeEnseignant
                    .map(buildMenuItem)
                    .toList(), //_items.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() => rapporteur2Value = value),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              /*TextFormField(
                decoration: const InputDecoration(
                  hintText: "Saisir l'rapporteur du PFE",
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),*/
              const SizedBox(
                height: 10,
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
              //  pfe.encadreur=encadreur;
              //  pfe.president=encadreur;
              //  pfe.rapporteur=encadreur;
              // editPfe(pfe);
              dialogStep2(context, pfe);
              // Navigator.pop(context, 'Modifer');
            },
            child: const Text('suivant'),
          ),

          /*TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),*/
        ],
      ),
    );
  }

  Future<String?> dialogStep2(BuildContext context, PFE pfe) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Ajouter salle '),
        // title: Text('Ajouter salle ${pfe} '),
        content: SingleChildScrollView(
          child: Column(
            children: [
              DropdownButton<String>(
                hint: const Text("choisir la Salle"),
                value: salle2Value,
                iconSize: 36,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                items: _listeEnseignant
                    .map(buildMenuItem)
                    .toList(), //_items.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() => salle2Value = value),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              /*TextFormField(
                decoration: const InputDecoration(
                  hintText: "Saisir Salle du PFE",
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),*/
              const SizedBox(
                height: 10,
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
              //  pfe.salle=salle;
              // editPfe(pfe);
              dialogStep3(context, pfe);
              // Navigator.pop(context, 'Modifer');
            },
            child: const Text('suivant'),
          ),

          /*TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),*/
        ],
      ),
    );
  }

  Future<String?> dialogStep3(BuildContext context, PFE pfe) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Ajouter seance '),
        // title: Text('Ajouter seance ${pfe} '),
        content: SingleChildScrollView(
          child: Column(
            children: [
              DropdownButton<String>(
                hint: const Text("choisir la seance"),
                value: seance2Value,
                iconSize: 36,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                items: _listeEnseignant
                    .map(buildMenuItem)
                    .toList(), //_items.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() => seance2Value = value),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              /*TextFormField(
                decoration: const InputDecoration(
                  hintText: "Saisir seance du PFE",
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),*/
              const SizedBox(
                height: 10,
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
              //  pfe.seance=seance;
              // editPfe(pfe);
              // dialogStep3(context, pfe);
              // Navigator.pop(context, 'Modifer');
            },
            child: const Text('valider'),
          ),

          /*TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),*/
        ],
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ), // Text
      );
  void getData() async {
    //await ApiService().updateEtudiants("3");
    //await ApiService().deleteEtudiants("17");
    // await ApiService().addEtudiants();
    // await ApiService().addDocument();
    //await ApiService().addEnseignant();
    await Future.wait([
      ApiPfe().getAllPFE(),
      ApiEnseignant().getAllEnseignant(),
      ApiEtudiant().getAllEtudiants(),
      ApiDocument().getDocument(),
      ApiSeance().getAllSeances(),
      ApiSalle().getAllSalles(),
      ApiSpecialite().getAllSpecialites(),
    ]).then((value) async {
      _pfe = value[0]?.cast<PFE>();
      _enseignant = value[1];
      _etudiant = value[2];
      _document = value[3];
      _seance = value[4];
      _salle = value[5];
      _specialite= value[6];
      _enseignant
          .map((l) => {_listeEnseignant.add(l.nom + ' ' + l.prenom)})
          .toList();
      _etudiant
          .map((l) => {_listeEtudiant.add(l.nom + ' ' + l.prenom)})
          .toList();
      _document
          .map((l) => {_listeDocument.add(l.titre)})
          .toList();
      _seance
          .map((l) => {_listeSeance.add(l.description)})
          .toList();
      _salle
          .map((l) => {_listeSalle.add(l.nom)})
          .toList();
      _specialite
          .map((l) => {_listeSpecialite.add(l.description)})
          .toList();
      // _pfe = await ApiPfe().getPFE();
      log("_pfe::$_pfe");
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
    String? note = "",
    String? titre = "",
    String? domaine = "",
    String? encadreur = "",
    String? president = "",
    String? rapporteur = "",
    String? etudiant = "",
    String? dateDebut = "",
    String? dateFin = "",
    String? dateSoutenance = "",
    String? salle = "",
    String? seance = "",
    String? document = "",
  }) async {
    //await ApiService().updateEtudiants("3");
    //await ApiService().deleteEtudiants("17");
    // await ApiService().addEtudiants();
    // await ApiService().addDocument();
    log("gerersujetPfe-addPFE");
    await ApiPfe().addPFE(
        note: noteController.text,
        titre: titre,
        domaine: domaine,
        encadreur: encadreur,
        president: president,
        rapporteur: rapporteur,
        etudiant: etudiant,
        dateDebut: dateDebut,
        dateFin: dateFin,
        dateSoutenance: dateSoutenance,
        salle: salle,
        seance: seance,
        document: document);
    getData();
  }

  void deleteSujetPfe(int? id) async {
    log("deleteSujetPfe");
    await ApiPfe().deletePFE(id: id.toString());
    getData();
  }
}
