import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/helpers/document_api.dart';
import 'package:gestion_pfe/src/helpers/etudiant_api.dart';
import 'package:gestion_pfe/src/helpers/pfe_api.dart';
import 'package:gestion_pfe/src/helpers/salle.dart';
import 'package:gestion_pfe/src/helpers/seance_api.dart';
import 'package:gestion_pfe/src/helpers/soutenance.dart';
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
  List<Enseignant?>? _enseignant;
  List<Etudiant?>? _etudiant;
  List<Document?>? _document;
  List<Seance?>? _seance;
  List<Salle?>? _salle;
  List<Specialite?>? _listeSpecialite;
  List<Specialite?>? _specialite;

  final noteController = TextEditingController();
  final titreController = TextEditingController();
  final descriptionController = TextEditingController();
  final domaineController = TextEditingController();
  final encadreurController = TextEditingController(); 
  final etudiantController = TextEditingController();
  final dateDebutController = TextEditingController();
  final dateDepotController = TextEditingController();  
  final documentController = TextEditingController();
  String? domaineValue;
  Enseignant? encadrantValue; 
  Etudiant? etudiantValue; 
  Document? documentValue;
  Specialite? specialiteValue;
  Enseignant? encadreur2Value; 
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
    dateDepotController.dispose(); 
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
          title: const Text(' sujets PFE'),
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
                      /*TextFormField(
                        keyboardType: TextInputType.number,
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
                      ),*/
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
                      
                      TextFormField(
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          hintText: 'description PFE',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'entrez le description du pfe';
                          }
                          return null;
                        },
                      ),
                     /* _listeSpecialite != null
                          ? DropdownButton(
                              value: specialiteValue,
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
                            )
                          : Container(),
                      const SizedBox(
                        height: 10,
                      ),  */
                      //TODO: make contraint to enseignant
                      /*_enseignant != null
                          ? DropdownButton(
                              value: presidentValue,
                              iconSize: 36,
                              hint: const Text("choisir l'président"),
                              items: _enseignant?.map((item) {
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
                            )
                          : Container(),
                      const SizedBox(
                        height: 10,
                      ),
                      _enseignant != null
                          ? DropdownButton(
                              value: rapporteurValue,
                              iconSize: 36,
                              hint: const Text("choisir l'président"),
                              items: _enseignant?.map((item) {
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
                            )
                          : Container(),
                      const SizedBox(
                        height: 10,
                      ),*/
                      _etudiant != null
                          ? DropdownButton(
                              value: etudiantValue,
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
                            )
                          : Container(),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.datetime,
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
                        keyboardType: TextInputType.number,
                        controller: dateDepotController,
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
                      const SizedBox(
                        height: 10,
                      ),
                     /* _salle != null
                          ? DropdownButton(
                              value: salleValue,
                              iconSize: 36,
                              hint: const Text("choisir la salle"),
                              items: _salle?.map((item) {
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
                            )
                          : Container(),
                      const SizedBox(
                        height: 10,
                      ),
                      _seance != null
                          ? DropdownButton(
                              value: seanceValue,
                              iconSize: 36,
                              hint: const Text("choisir la seance"),
                              items: _seance?.map((item) {
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
                            )
                          : Container(),
                      const SizedBox(
                        height: 10,
                      ),*/
                      _document != null
                          ? DropdownButton(
                              value: documentValue,
                              iconSize: 36,
                              hint: const Text("choisir document"),
                              items: _document?.map((item) {
                                return DropdownMenuItem<Document>(
                                  value: item,
                                  child: Text(item!.titre!),
                                );
                              }).toList(),
                              onChanged: (newVal) {
                                log("newVal::$newVal");
                                setState(() {
                                  documentValue = newVal as Document;
                                });
                              },
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            pfe?.title = titreController.text;
                            pfe?.description = descriptionController.text;
                            pfe?.dateDebut = dateDebutController.text;
                            pfe?.dateDepot = dateDepotController.text;
                            pfe?.domaine = domaineController.text;
                            pfe?.note = double.tryParse(noteController.text);
                            pfe?.etudiant = etudiantValue;
                            pfe?.document = documentValue;
                            pfe?.encadreur = encadrantValue; 
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
              _enseignant != null
                  ? DropdownButton(
                      value: etudiantValue,
                      iconSize: 36,
                      hint: const Text("choisir l'encadrant"),
                      items: _enseignant?.map((item) {
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
                    )
                  : Container(),
              const SizedBox(
                height: 10,
              ), 
              const SizedBox(
                height: 10,
              ), 
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
            // children: [
            //   _salle != null
            //       ? DropdownButton(
            //           value: salle2Value,
            //           iconSize: 36,
            //           hint: const Text("choisir la Salle"),
            //           items: _salle?.map((item) {
            //             return DropdownMenuItem<Salle>(
            //               value: item,
            //               child: Text(item!.nom!),
            //             );
            //           }).toList(),
            //           onChanged: (newVal) {
            //             log("newVal::$newVal");
            //             setState(() {
            //               salle2Value = newVal as Salle?;
            //             });
            //           },
            //         )
            //       : Container(),
              // const SizedBox(
              //   height: 10,
              // ),
            // ],
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
        ],
      ),
    );
  }

  Future<String?> dialogStep3(BuildContext context, PFE pfe) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Ajouter seance '),
        content: SingleChildScrollView(
          child: Column(
            children: [
              // _seance != null
              //     ? DropdownButton(
              //         value: seance2Value,
              //         iconSize: 36,
              //         hint: const Text("choisir la seance"),
              //         items: _seance?.map((item) {
              //           return DropdownMenuItem<Seance>(
              //             value: item,
              //             child: Text(item!.Nom!),
              //           );
              //         }).toList(),
              //         onChanged: (newVal) {
              //           log("newVal::$newVal");
              //           setState(() {
              //             seance2Value = newVal as Seance?;
              //           });
              //         },
              //       )
              //     : Container(),
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
        ],
      ),
    );
  }

  void getData() async {
    await Future.wait([
      ApiPfe().getAllPFE(),
      ApiEnseignant().getAllEnseignant(),
      ApiEtudiant().getAllEtudiants(),
      ApiDocument().getAllDocument(),
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
      _specialite = value[6]?.cast<Specialite?>();
      log("_pfe::$_pfe");
      log("_enseignant::$_enseignant");
      log("_etudiant::$_etudiant");
      log("Document::$_document");
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
    debugPrint("gerersujetPfe-addPFE::$pfe");
    await ApiPfe().addPFE(pfe: pfe);
    getData();
  }

  void deleteSujetPfe(int? id) async {
    log("deleteSujetPfe");
    await ApiPfe().deletePFE(id: id.toString());
    getData();
  }
}
