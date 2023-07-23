import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/helpers/document_api.dart';
import 'package:gestion_pfe/src/helpers/etudiant_api.dart';
import 'package:gestion_pfe/src/helpers/pfe_api.dart';
import 'package:gestion_pfe/src/helpers/salle_api.dart';
import 'package:gestion_pfe/src/helpers/seance_api.dart';
// import 'package:gestion_pfe/src/helpers/soutenance.dart';
import 'package:gestion_pfe/src/helpers/specialite_api.dart';
import 'package:gestion_pfe/src/helpers/sujet_api.dart';
import 'package:gestion_pfe/src/models/document.dart';
import 'package:gestion_pfe/src/models/encadrant.dart';
import 'package:gestion_pfe/src/models/etudiant.dart';
import 'package:gestion_pfe/src/models/salle.dart';
import 'package:gestion_pfe/src/models/seance_model.dart';
import 'package:gestion_pfe/src/models/specialite.dart';
import 'package:gestion_pfe/src/models/sujet.dart';
import '../../helpers/encadrant_api.dart';
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
  PFE? editedPfe = PFE();
  List<Encadrant?>? _encadrant;
  List<Etudiant?>? _etudiant;
  List<Document?>? _document;
  List<Seance?>? _seance;
  List<Salle?>? _salle;
  Sujet? sujetValue;
  List<Sujet?>? _sujet;
  // List<Salle?>? _salle;
  // List<Specialite?>? _listeSpecialite;
  List<Specialite?>? _specialite;
  final dateDebutController = TextEditingController();
  final dateDepotController = TextEditingController();
  String? domaineValue;
  Encadrant? encadrantValue;
  Etudiant? etudiantValue;
  Document? documentValue;
  Specialite? specialiteValue;
  Encadrant? encadreur2Value;
  Salle? salle2Value;
  Seance? seance2Value;

  final editDateDebutController = TextEditingController();
  final editDateDepotController = TextEditingController();
  String? editDomaineValue;
  Encadrant? editEncadrantValue;
  Etudiant? editEtudiantValue;
  Document? editDocumentValue;
  Specialite? editSpecialiteValue;
  Sujet? editSujetValue;
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    dateDebutController.dispose();
    dateDepotController.dispose();
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
                text: "Informatique",
              ),
              Tab(
                text: "Mecanique",
              ),
            ],
          ),
          title: const Text(' sujets PFE'),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Center(
                child: resiseWidget(
                  context: context,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      /* _etudiant != null
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
                          : Container(),*/
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
                      _etudiant != null
                          ? DropdownButton(
                              value: etudiantValue,
                              iconSize: 36,
                              hint: const Text("choisir l'étudiant"),
                              items: _etudiant?.map((item) {
                                return DropdownMenuItem<Etudiant>(
                                  value: item,
                                  child: Text(
                                      "${item?.prenom ?? ""} ${item?.nom ?? ""}"),
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
                      _encadrant != null
                          ? DropdownButton(
                              value: encadrantValue,
                              iconSize: 36,
                              hint: const Text("choisir l'encadrant"),
                              items: _encadrant?.map((item) {
                                return DropdownMenuItem<Encadrant>(
                                  value: item,
                                  child: Text(
                                      "${item?.prenom ?? ""} ${item?.nom ?? ""}"),
                                );
                              }).toList(),
                              onChanged: (newVal) {
                                log("newVal::$newVal");
                                setState(() {
                                  encadrantValue = newVal as Encadrant?;
                                });
                              },
                            )
                          : Container(),
                      _sujet != null
                          ? DropdownButton(
                              value: sujetValue,
                              iconSize: 36,
                              hint: const Text("choisir le sujet"),
                              items: _sujet?.map((item) {
                                return DropdownMenuItem<Sujet>(
                                  value: item,
                                  child: Text(item?.titre ?? ""),
                                );
                              }).toList(),
                              onChanged: (newVal) {
                                log("newVal::$newVal");
                                setState(() {
                                  sujetValue = newVal as Sujet?;
                                });
                              },
                            )
                          : Container(),
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
                            try {
                              pfe?.dateDebut = dateDebutController.text;
                              pfe?.dateDepot = dateDepotController.text;
                              pfe?.etudiant = etudiantValue;
                              pfe?.document = documentValue;
                              pfe?.encadrant = encadrantValue;
                              pfe?.sujet = sujetValue;
                              sujetValue = null;
                              etudiantValue = null;
                              encadrantValue = null;
                              documentValue = null;
                              log("pfe::$pfe");
                              addData(
                                pfe: pfe,
                              );
                            } catch (e) {
                              log("gerer-sujets-pfe-exception::${e.toString()}");
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("quelque chose ne va pas"),
                                    backgroundColor: Colors.red),
                              );
                            }
                          },
                          child: const Text('Ajouter'),
                        ),
                      ),
                      Card(
                        child: ListTile(
                            /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                            title: Text(
                                _pfe?[0].sujet?.titre ?? "Gestion des projets"),
                            subtitle: Text(
                                '${_pfe?[0].etudiant?.nom} ${_pfe?[0].etudiant?.prenom}-${_pfe?[0].encadrant?.nom} ${_pfe?[0].encadrant?.prenom}'),
                            trailing: const Icon(Icons.more_vert),
                            isThreeLine: true,
                            onTap: () => dialog(context, _pfe![0]),
                            // dialogStep1(context, _pfe![0]),
                            onLongPress: () => null
                            // dialog(context, _pfe![index]),
                            ),
                      )
                      /* _pfe!.isEmpty
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
                                      title: Text(_pfe?[index].sujet?.titre ??
                                          "Titre sujet"),
                                      subtitle: Text(
                                          '${_pfe?[index].etudiant?.nom} ${_pfe?[index].etudiant?.prenom}-${_pfe?[index].encadrant?.nom} ${_pfe?[index].encadrant?.prenom}'),
                                      trailing: const Icon(Icons.more_vert),
                                      isThreeLine: true,
                                      onTap: () =>  dialogStep1(context, _pfe![index]),
                                      onLongPress: () => null
                                      // dialog(context, _pfe![index]),
                                      ),
                                );
                              },
                            ),*/
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
    editedPfe = pfe;
    editDateDebutController.text = pfe.dateDebut ?? "";
    editDateDepotController.text = pfe.dateDepot ?? "";
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Modifier / Supprimer PFE'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.datetime,
                controller: editDateDebutController,
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
                controller: editDateDepotController,
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
              _etudiant != null
                  ? DropdownButton(
                      value: editEtudiantValue,
                      iconSize: 36,
                      hint: const Text("choisir l'étudiant"),
                      items: _etudiant?.map((item) {
                        return DropdownMenuItem<Etudiant>(
                          value: item,
                          child:
                              Text("${item?.prenom ?? ""} ${item?.nom ?? ""}"),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        log("newVal::$newVal");
                        setState(() {
                          editEtudiantValue = newVal as Etudiant?;
                        });
                      },
                    )
                  : Container(),
              _encadrant != null
                  ? DropdownButton(
                      value: editEncadrantValue,
                      iconSize: 36,
                      hint: const Text("choisir l'encadrant"),
                      items: _encadrant?.map((item) {
                        return DropdownMenuItem<Encadrant>(
                          value: item,
                          child:
                              Text("${item?.prenom ?? ""} ${item?.nom ?? ""}"),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        log("newVal::$newVal");
                        setState(() {
                          editEncadrantValue = newVal as Encadrant?;
                        });
                      },
                    )
                  : Container(),
              _sujet != null
                  ? DropdownButton(
                      value: editSujetValue,
                      iconSize: 36,
                      hint: const Text("choisir le sujet"),
                      items: _sujet?.map((item) {
                        return DropdownMenuItem<Sujet>(
                          value: item,
                          child: Text(item?.titre ?? ""),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        log("newVal::$newVal");
                        setState(() {
                          editSujetValue = newVal as Sujet?;
                        });
                      },
                    )
                  : Container(),
              _document != null
                  ? DropdownButton(
                      value: editDocumentValue,
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
                          editDocumentValue = newVal as Document;
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
              editPFE();
              Navigator.pop(context, 'Modifer');
            },
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
        title: const Text('Ajouter jury'),
        // title: Text('Ajouter jury ${pfe} '),
        content: SingleChildScrollView(
          child: Column(
            children: [
              _encadrant != null
                  ? DropdownButton(
                      value: etudiantValue,
                      iconSize: 36,
                      hint: const Text("choisir l'encadrant"),
                      items: _encadrant?.map((item) {
                        return DropdownMenuItem<Encadrant>(
                          value: item,
                          child: Text("${item!.nom!} ${item.prenom!}"),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        log("newVal::$newVal");
                        setState(() {
                          encadreur2Value = newVal as Encadrant?;
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
        title: const Text('Ajouter salle '),
        // title: Text('Ajouter salle ${pfe} '),
        content: SingleChildScrollView(
          child: Column(
            children: [
              _salle != null
                  ? DropdownButton(
                      value: salle2Value,
                      iconSize: 36,
                      hint: const Text("choisir la Salle"),
                      items: _salle?.map((item) {
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
                    )
                  : Container(),
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
              _seance != null
                  ? DropdownButton(
                      value: seance2Value,
                      iconSize: 36,
                      hint: const Text("choisir la seance"),
                      items: _seance?.map((item) {
                        return DropdownMenuItem<Seance>(
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
                    )
                  : Container(),
              SizedBox(
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
              Navigator.pop(context, 'valider');
              Navigator.pop(context, 'valider');
              Navigator.pop(context, 'valider');
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
      ApiEncadrant().getAllEncadrant(),
      ApiEtudiant().getAllEtudiants(),
      ApiDocument().getAllDocument(),
      ApiSeance().getAllSeances(),
      ApiSujet().getAllSujets(),
      ApiSpecialite().getAllSpecialites(),
      ApiSalle().getAllSalles(),
    ]).then((value) async {
      _pfe = value[0]?.cast<PFE>();
      _encadrant = value[1]?.cast<Encadrant?>();
      _etudiant = value[2]?.cast<Etudiant?>();
      _document = value[3]?.cast<Document?>();
      _seance = value[4]?.cast<Seance?>();
      _sujet = value[5]?.cast<Sujet?>();
      _specialite = value[6]?.cast<Specialite?>();
      _salle = value[7]?.cast<Salle?>();
      log("_pfe::$_pfe");
      log("_encadrant::$_encadrant");
      log("_etudiant::$_etudiant");
      log("Document::$_document");
      log("_seance::$_seance");
      log("_sujet::$_sujet");
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

  editPFE() async {
    log("editPFE");
    editedPfe?.dateDebut = editDateDebutController.text;
    editedPfe?.dateDepot = editDateDepotController.text;
    editedPfe?.document = editDocumentValue ?? editedPfe?.document;
    editedPfe?.encadrant = editEncadrantValue ?? editedPfe?.encadrant;
    editedPfe?.sujet = editSujetValue ?? editedPfe?.sujet;
    editedPfe?.etudiant = editEtudiantValue ?? editedPfe?.etudiant;
    log("editPFE::$editedPfe");
    editDocumentValue = null;
    editEncadrantValue = null;
    editSujetValue = null;
    editEtudiantValue = null;
    await ApiPfe().updatePFE(pfe: pfe);
    getData();
  }

  void deleteSujetPfe(int? id) async {
    log("deleteSujetPfe");
    await ApiPfe().deletePFE(id: id.toString());
    getData();
  }
}
