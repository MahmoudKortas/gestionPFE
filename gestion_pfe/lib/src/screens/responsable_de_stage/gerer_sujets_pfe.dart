import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/helpers/document_api.dart';
import 'package:gestion_pfe/src/helpers/etudiant_api.dart';
import 'package:gestion_pfe/src/helpers/pfe_api.dart';
import 'package:gestion_pfe/src/helpers/salle.dart';
import 'package:gestion_pfe/src/helpers/seance_api.dart';
import 'package:gestion_pfe/src/helpers/soutenance_api.dart';
import 'package:gestion_pfe/src/helpers/specialite.dart';
import 'package:gestion_pfe/src/models/document.dart';
import 'package:gestion_pfe/src/models/enseignant.dart';
import 'package:gestion_pfe/src/models/etudiant.dart';
import 'package:gestion_pfe/src/models/salle.dart';
import 'package:gestion_pfe/src/models/seance_model.dart';
import 'package:gestion_pfe/src/models/specialite.dart';
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
  PFE? pfe = PFE();
  var _enseignant;
  List<Etudiant?>? _etudiant;
  List<Enseignant?>? _listeEnseignant;
  List<Salle?>? _listeSalle;
  List<Seance?>? _listeSeance;
  List<Document?>? _listeDocument  ;
  List<Specialite?>? _listeSpecialite  ;
  var _document;
  var _seance;
  var _salle;
  List<Specialite?>? _specialite;
  var _listeEtudiant = [''];

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
  Enseignant? encadrantValue;
  Enseignant? presidentValue;
  Enseignant? rapporteurValue;
  Etudiant? etudiantValue;
  Salle? salleValue;
  Seance? seanceValue;
  Document? documentValue;
  Enseignant? encadreur2Value;
  Enseignant? president2Value;
  Enseignant? rapporteur2Value;
  Salle? salle2Value;
  Seance? seance2Value;
  Specialite? specialiteValue;
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
              Tab(
                text: "Tous",
              ),
              Tab(
                text: "departement 1",
              ),
              Tab(
                text: "departement 2",
              ),
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
                          hintText: 'Titre PFE',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'entrez le titre du pfe';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _listeSpecialite != null
                          ? 
                          DropdownButton(
                              iconSize: 36,
                              hint: const Text("choisir la specialite"),
                              items: _listeSpecialite?.map((item) {
                                return DropdownMenuItem<Specialite>(
                                  value: item,
                                  child: Text("${item!.description}"),
                                );
                              }).toList(),
                              onChanged: (newVal) {
                                log("newVal::$newVal");
                                setState(() {
                                  specialiteValue = newVal as Specialite?;
                                });
                              },
                              value: specialiteValue,
                            )
                          : Container(),
                      const SizedBox(
                        height: 10,
                      ),
                      _listeEnseignant != null
                          ? DropdownButton(
                              iconSize: 36,
                              hint: const Text("choisir l'encadrant"),
                              items: _listeEnseignant?.map((item) {
                                return DropdownMenuItem<Enseignant>(
                                  value: item,
                                  child: Text("${item!.nom!} ${item.prenom!}"),
                                );
                              }).toList(),
                              onChanged: (newVal) {
                                log("newVal::$newVal");
                                setState(() {
                                  encadrantValue = newVal as Enseignant?;
                                });
                              },
                              value: encadrantValue,
                            )
                          : Container(),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButton(
                        iconSize: 36,
                        hint: const Text("choisir l'président"),
                        items: _listeEnseignant?.map((item) {
                          return DropdownMenuItem<Enseignant>(
                            value: item,
                            child: Text("${item!.nom!} ${item.prenom!}"),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          log("newVal::$newVal");
                          setState(() {
                            presidentValue = newVal as Enseignant?;
                          });
                        },
                        value: presidentValue,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _listeEnseignant != null
                          ? DropdownButton(
                              iconSize: 36,
                              hint: const Text("choisir l'président"),
                              items: _listeEnseignant?.map((item) {
                                return DropdownMenuItem<Enseignant>(
                                  value: item,
                                  child: Text("${item!.nom!} ${item.prenom!}"),
                                );
                              }).toList(),
                              onChanged: (newVal) {
                                log("newVal::$newVal");
                                setState(() {
                                  rapporteurValue = newVal as Enseignant?;
                                });
                              },
                              value: rapporteurValue,
                            )
                          : Container(),
                      const SizedBox(
                        height: 10,
                      ),
                      _etudiant != null
                          ? DropdownButton(
                              iconSize: 36,
                              hint: const Text("choisir l'etudiant"),
                              items: _etudiant?.map((item) {
                                return DropdownMenuItem<Etudiant>(
                                  value: item,
                                  child: Text("${item!.nom!} ${item.prenom!}"),
                                );
                              }).toList(),
                              onChanged: (newVal) {
                                log("newVal::$newVal");
                                setState(() {
                                  etudiantValue = newVal as Etudiant?;
                                });
                              },
                              value: etudiantValue,
                            )
                          : Container(),
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
                      _listeSalle != null
                          ? DropdownButton(
                              iconSize: 36,
                              hint: const Text("choisir la salle"),
                              items: _listeSalle?.map((item) {
                                return DropdownMenuItem<Salle>(
                                  value: item,
                                  child: Text("${item!.nom!} ${item.nom!}"),
                                );
                              }).toList(),
                              onChanged: (newVal) {
                                log("newVal::$newVal");
                                setState(() {
                                  salleValue = newVal as Salle?;
                                });
                              },
                              value: salleValue,
                            )
                          : Container(),
                      const SizedBox(
                        height: 10,
                      ),
                      _listeSeance != null
                          ? DropdownButton(
                              iconSize: 36,
                              hint: const Text("choisir la seance"),
                              items: _listeSeance?.map((item) {
                                return DropdownMenuItem<Seance>(
                                  value: item,
                                  child: Text(item!.description!),
                                );
                              }).toList(),
                              onChanged: (newVal) {
                                log("newVal::$newVal");
                                setState(() {
                                  seanceValue = newVal as Seance?;
                                });
                              },
                              value: seanceValue,
                            )
                          : Container(),
                      const SizedBox(
                        height: 10,
                      ),
                      _listeDocument != null
                          ? 
                          DropdownButton(
                              iconSize: 36,
                              hint: const Text("choisir document"),
                              items: _listeDocument?.map((item) {
                                return DropdownMenuItem<Document>(
                                  value: item,
                                  child: Text(item!.description!),
                                );
                              }).toList(),
                              onChanged: (newVal) {
                                log("newVal::$newVal");
                                setState(() {
                                  documentValue = newVal as Document;
                                });
                              },
                              value: seanceValue,
                            ) 
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            pfe?.title = titreController.text;
                            pfe?.dateDebut = dateDebutController.text;
                            pfe?.dateFin = dateFinController.text;
                            pfe?.domaine = domaineController.text;
                            pfe?.note = double.tryParse(noteController.text);
                            pfe?.etudiant = etudiantValue;
                            pfe?.document = documentValue;
                            pfe?.encadreur = encadrantValue;
                            pfe?.president = presidentValue;
                            pfe?.rapporteur = rapporteurValue;
                            pfe?.salle = salleValue;
                            pfe?.seance = seanceValue;
                            log("pfe::$pfe ");
                            addData(
                              pfe: pfe,
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
                                        dialog(context, _pfe![index]),
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
              /*DropdownButton<String>(
                hint: const Text("choisir l'encadrant"),
                value: encadreur2Value,
                iconSize: 36,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                items: _listeEnseignant
                    .map(buildMenuItem)
                    .toList(), //_items.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() => encadreur2Value = value),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),*/
              DropdownButton(
                iconSize: 36,
                hint: const Text("choisir l'encadrant"),
                items: _listeEnseignant?.map((item) {
                  return DropdownMenuItem<Enseignant>(
                    value: item,
                    child: Text("${item!.nom!} ${item.prenom!}"),
                  );
                }).toList(),
                onChanged: (newVal) {
                  log("newVal::$newVal");
                  setState(() {
                    encadreur2Value = newVal as Enseignant?;
                  });
                },
                value: encadreur2Value,
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
              /*DropdownButton<String>(
                hint: const Text("choisir le president"),
                value: president2Value,
                iconSize: 36,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                items: _listeEnseignant
                    .map(buildMenuItem)
                    .toList(), //_items.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() => president2Value = value),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ), */
              DropdownButton(
                iconSize: 36,
                hint: const Text("choisir l'president"),
                items: _listeEnseignant?.map((item) {
                  return DropdownMenuItem<Enseignant>(
                    value: item,
                    child: Text("${item!.nom!} ${item.prenom!}"),
                  );
                }).toList(),
                onChanged: (newVal) {
                  log("newVal::$newVal");
                  setState(() {
                    president2Value = newVal as Enseignant?;
                  });
                },
                value: president2Value,
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
              /*DropdownButton<String>(
                hint: const Text("choisir le rapporteur"),
                value: rapporteur2Value,
                iconSize: 36,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                items: _listeEnseignant
                    .map(buildMenuItem)
                    .toList(), //_items.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() => rapporteur2Value = value),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),*/
              DropdownButton(
                iconSize: 36,
                hint: const Text("choisir l'president"),
                items: _listeEnseignant?.map((item) {
                  return DropdownMenuItem<Enseignant>(
                    value: item,
                    child: Text("${item!.nom!} ${item.prenom!}"),
                  );
                }).toList(),
                onChanged: (newVal) {
                  log("newVal::$newVal");
                  setState(() {
                    rapporteur2Value = newVal as Enseignant?;
                  });
                },
                value: rapporteur2Value,
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
              /*DropdownButton<String>(
                hint: const Text("choisir la Salle"),
                value: salle2Value,
                iconSize: 36,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                items: _listeEnseignant
                    .map(buildMenuItem)
                    .toList(), //_items.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() => salle2Value = value),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),*/
              DropdownButton(
                iconSize: 36,
                hint: const Text("choisir la Salle"),
                items: _listeSalle?.map((item) {
                  return DropdownMenuItem<Salle>(
                    value: item,
                    child: Text(item!.nom!),
                  );
                }).toList(),
                onChanged: (newVal) {
                  log("newVal::$newVal");
                  setState(() {
                    salle2Value = newVal as Salle?;
                  });
                },
                value: salle2Value,
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
              /*DropdownButton<String>(
                hint: const Text("choisir la seance"),
                value: seance2Value,
                iconSize: 36,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                items: _listeEnseignant
                    .map(buildMenuItem)
                    .toList(), //_items.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() => seance2Value = value),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),*/
              DropdownButton(
                iconSize: 36,
                hint: const Text("choisir la seance"),
                items: _listeSalle?.map((item) {
                  return DropdownMenuItem<Salle>(
                    value: item,
                    child: Text(item!.nom!),
                  );
                }).toList(),
                onChanged: (newVal) {
                  log("newVal::$newVal");
                  setState(() {
                    seance2Value = newVal as Seance?;
                  });
                },
                value: seance2Value,
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

  /*DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ), // Text
      );*/
  void getData() async {
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
      _enseignant = value[1]?.cast<Enseignant?>();
      _etudiant = value[2]?.cast<Etudiant?>();
      _document = value[3]?.cast<Document?>();
      _seance = value[4]?.cast<Seance?>();
      _salle = value[5]?.cast<Salle?>();
      _specialite = value[5]?.cast<Specialite?>();
      log("_pfe::$_pfe");
      log("_enseignant::$_enseignant");
      log("_etudiant::$_etudiant");
      log("Document::$Document");
      log("_seance::$_seance");
      log("_salle::$_salle");
      log("_specialite::$_specialite");
      Future.delayed(const Duration(seconds: 0))
          .then((value) => setState(() {}));
    });
  }

  void addData({
    PFE? pfe,
  }) async {
    log("gerersujetPfe-addPFE");
    await ApiPfe().addPFE(pfe: pfe);
    getData();
  }

  void deleteSujetPfe(int? id) async {
    log("deleteSujetPfe");
    await ApiPfe().deletePFE(id: id.toString());
    getData();
  }
}
