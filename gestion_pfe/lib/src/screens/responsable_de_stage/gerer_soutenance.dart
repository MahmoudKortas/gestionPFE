// ignore_for_file: prefer_typing_uninitialized_variables, prefer_final_fields, no_leading_underscores_for_local_identifiers

import 'dart:developer';
// import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:gestion_pfe/src/helpers/departement.dart';
import 'package:gestion_pfe/src/helpers/encadrant_api.dart';
import 'package:gestion_pfe/src/helpers/pfe_api.dart';
import 'package:gestion_pfe/src/helpers/salle_api.dart';
import 'package:gestion_pfe/src/helpers/seance_api.dart';
// import 'package:gestion_pfe/src/models/departement.dart';
import 'package:gestion_pfe/src/models/encadrant.dart';
import 'package:gestion_pfe/src/models/pfe.dart';
import 'package:gestion_pfe/src/models/salle.dart';
import 'package:gestion_pfe/src/models/seance_model.dart';
// import 'package:image_picker/image_picker.dart';
import '../../helpers/soutenance_api.dart';
import '../../models/soutenance.dart';
import '../../resize_widget.dart';

class GererSoutenance extends StatefulWidget {
  const GererSoutenance({Key? key}) : super(key: key);
  static const routeName = '/Soutenance';
  @override
  State<GererSoutenance> createState() => _GererSoutenanceState();
}

class _GererSoutenanceState extends State<GererSoutenance> {
  late List<Soutenance?>? _soutenance = [];
  String? value;
  Soutenance? soutenance = Soutenance();
  final dateController = TextEditingController();
  final descriptionController = TextEditingController();
  final etatController = TextEditingController();
  final motdepasseController = TextEditingController();
  final telController = TextEditingController();
  final dateResponsabiliteController = TextEditingController();

  Encadrant? rapporteurValue;
  Encadrant? presidentValue;
  Salle? salleValue;
  Seance? seanceValue;
  PFE? pfeValue;

  List<Encadrant?>? _rapporteur;
  List<Encadrant?>? _president;
  List<Salle?>? _salle;
  List<Seance?>? _seance;
  List<PFE?>? _pfe;
  final editDateController = TextEditingController();
  final editDescriptionController = TextEditingController();
  final editEtatController = TextEditingController();
  final ediMtotdepasseController = TextEditingController();
  final editTelController = TextEditingController();
  final editRateResponsabiliteController = TextEditingController();
  Encadrant? editRapporteurValue;
  Encadrant? editPresidentValue;
  Salle? editSalleValue;
  Seance? editSeanceValue;
  PFE? editPfeValue;
  Soutenance? editedSoutenance;
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gérer Soutenances'),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        // controller: controller,
        child: Center(
          child: resiseWidget(
            context: context,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.description),
                    hintText: 'Saisir date',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'entrez la date';
                    }
                    return null;
                  },
                  controller: dateController,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.description),
                    hintText: 'Saisir description',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'entrez la description ';
                    }
                    return null;
                  },
                  controller: descriptionController,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.description),
                    hintText: 'Saisir etat',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'entrez etat';
                    }
                    return null;
                  },
                  controller: etatController,
                ),
                _rapporteur != null
                    ? DropdownButton(
                        value: rapporteurValue,
                        iconSize: 36,
                        hint: const Text("choisir l'rapporteur"),
                        items: _rapporteur?.map((item) {
                          return DropdownMenuItem<Encadrant>(
                            value: item,
                            child: Text("${item!.nom!} ${item.prenom!}"),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          log("newVal::$newVal");
                          setState(() {
                            rapporteurValue = newVal as Encadrant?;
                          });
                        },
                      )
                    : Container(),
                _president != null
                    ? DropdownButton(
                        value: presidentValue,
                        iconSize: 36,
                        hint: const Text("choisir le président"),
                        items: _president?.map((item) {
                          return DropdownMenuItem<Encadrant>(
                            value: item,
                            child: Text("${item!.nom!} ${item.prenom!}"),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          log("newVal::$newVal");
                          setState(() {
                            presidentValue = newVal as Encadrant?;
                          });
                        },
                      )
                    : Container(),
                _salle != null
                    ? DropdownButton(
                        value: salleValue,
                        iconSize: 36,
                        hint: const Text("choisir la salle"),
                        items: _salle?.map((item) {
                          return DropdownMenuItem<Salle>(
                            value: item,
                            child: Text(item!.nom!),
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
                _seance != null
                    ? DropdownButton(
                        value: seanceValue,
                        iconSize: 36,
                        hint: const Text("choisir la séance"),
                        items: _seance?.map((item) {
                          return DropdownMenuItem<Seance>(
                            value: item,
                            child: Text(item!.nom!),
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
                _pfe != null
                    ? DropdownButton(
                        value: pfeValue,
                        iconSize: 36,
                        hint: const Text("choisir le PFE"),
                        items: _pfe?.map((item) {
                          return DropdownMenuItem<PFE>(
                            value: item,
                            child: Text(item!.idPFE!.toString()),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          log("newVal::$newVal");
                          setState(() {
                            pfeValue = newVal as PFE?;
                          });
                        },
                      )
                    : Container(),
                ElevatedButton(
                  // ignore: avoid_print
                  onPressed: () {
                    try {
                      addSoutenance();
                    } catch (e) {
                      log("gerer-soutenance-exception::${e.toString()}");
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("quelque chose ne va pas"),
                            backgroundColor: Colors.red),
                      );
                    }
                  },
                  child: const Text("Ajouter"),
                ),
                /*Card(
                                child: ListTile(
                                    title:const Text("Soutenance 1"),
                                    // subtitle: Text(_soutenance![index]!
                                    //     .description
                                    //     .toString()),
                                    trailing: const Icon(Icons.more_vert),
                                    // isThreeLine: true,
                                    // onTap: () =>
                                        // dialog(context, _soutenance![index]!)),
                                 ) ),*/
                /*_Soutenance == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    :*/
                //TODO: fix below code
                _soutenance != null
                    ? _soutenance!.isEmpty
                        ? const Text("aucun Soutenance existe")
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _soutenance!.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                    title: Text(_soutenance![index]!
                                        .description
                                        .toString()),
                                    subtitle: Text(_soutenance![index]!
                                        .description
                                        .toString()),
                                    trailing: const Icon(Icons.more_vert),
                                    // isThreeLine: true,
                                    onTap: () =>
                                        dialog(context, _soutenance![index]!)),
                              );
                            },
                          )
                    : Container()
                // const Text("aucun Soutenance existe null")
                /*Card(
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
                      onTap: () => dialog(context)),
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

  Future<String?> dialog(BuildContext context, Soutenance soutenance) {
    editedSoutenance = soutenance;
    editDateController.text = soutenance.description ?? "";
    editDescriptionController.text = soutenance.description ?? "";
    editEtatController.text = soutenance.description ?? "";
    log("dialog_soutenance::$editedSoutenance");
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Modifier / Supprimer Soutenance'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  hintText: editedSoutenance?.date,
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Entrez date soutenance';
                  }
                  return null;
                },
                controller: editDateController,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  hintText: editedSoutenance?.description,
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Entrez description soutenance';
                  }
                  return null;
                },
                controller: editDescriptionController,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  hintText: editedSoutenance?.etat,
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Entrez etat soutenance';
                  }
                  return null;
                },
                controller: editEtatController,
              ),
              const SizedBox(
                height: 10,
              ),
              _rapporteur != null
                  ? DropdownButton(
                      value: editRapporteurValue,
                      iconSize: 36,
                      hint: Text(
                          "${soutenance.rapporteur?.prenom ?? "choisir votre rapporteur"} ${soutenance.rapporteur?.nom ?? ""}"),
                      items: _rapporteur?.map((item) {
                        return DropdownMenuItem<Encadrant>(
                          value: item,
                          child: Text(item!.nom!),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        log("newVal::$newVal");
                        setState(() {
                          editRapporteurValue = newVal as Encadrant?;
                        });
                      },
                    )
                  : Container(),
              _salle != null
                  ? DropdownButton(
                      value: editSalleValue,
                      iconSize: 36,
                      hint: Text(soutenance.salle?.nom ?? "choisir salle"),
                      items: _salle?.map((item) {
                        return DropdownMenuItem<Salle>(
                          value: item,
                          child: Text(item!.nom!),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        log("newVal::$newVal");
                        setState(() {
                          editSalleValue = newVal as Salle?;
                        });
                      },
                    )
                  : Container(),
              _seance != null
                  ? DropdownButton(
                      value: editSeanceValue,
                      iconSize: 36,
                      hint: Text(soutenance.seance?.nom ?? "choisir seance"),
                      items: _seance?.map((item) {
                        return DropdownMenuItem<Seance>(
                          value: item,
                          child: Text(item!.nom!),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        log("newVal::$newVal");
                        setState(() {
                          editSeanceValue = newVal as Seance?;
                        });
                      },
                    )
                  : Container(),
              _pfe != null
                  ? DropdownButton(
                      value: editPfeValue,
                      iconSize: 36,
                      hint: Text(soutenance.pfe?.sujet?.titre ?? "choisir pfe"),
                      items: _pfe?.map((item) {
                        return DropdownMenuItem<PFE>(
                          value: item,
                          child: Text(item?.sujet?.titre ?? ""),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        log("newVal::$newVal");
                        setState(() {
                          editPfeValue = newVal as PFE?;
                        });
                      },
                    )
                  : Container(),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // editSoutenance(soutenance: editedSoutenance);
              Navigator.pop(context, 'Modifer');
            },
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'Modifer'),
            child: const Text('Modifer'),
          ),
          TextButton(
            onPressed: () async {
              log(soutenance.idSout.toString());
              var soutenancet;
              soutenancet = await ApiSoutenance()
                  .deleteSoutenance(id: soutenance.idSout.toString());
              log("_Soutenancet::$soutenancet");
              getData();
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
      ApiSoutenance().getAllSoutenance(),
      ApiEncadrant().getAllEncadrant(),
      ApiSalle().getAllSalles(),
      ApiSeance().getAllSeances(),
      ApiPfe().getAllPFE()
    ]).then((value) async {
      _soutenance = value[0]?.cast<Soutenance?>();
      _rapporteur = value[1]?.cast<Encadrant?>();
      _salle = value[2]?.cast<Salle?>();
      _seance = value[3]?.cast<Seance?>();
      _pfe = value[4]?.cast<PFE?>();
      Future.delayed(const Duration(seconds: 0))
          .then((value) => setState(() {}));
    });
    // _listeSoutenance.clear();
    //log("_Soutenance::$_Soutenance");
  }

  addSoutenance() async {
    soutenance?.date = dateController.text;
    soutenance?.description = descriptionController.text;
    soutenance?.etat = etatController.text;
    soutenance?.rapporteur = rapporteurValue;
    soutenance?.president = presidentValue;
    soutenance?.salle = salleValue;
    soutenance?.seance = seanceValue;
    soutenance?.pfe = pfeValue;
    rapporteurValue = null;
    presidentValue = null;
    salleValue = null;
    seanceValue = null;
    pfeValue = null;
    await ApiSoutenance().addSoutenance(soutenance: soutenance);

    getData();
  }

  /*editSoutenance({Soutenance? soutenance}) async {
    log("editSoutenance");
    editedSoutenance?.date = editNomController.text;

    editedSoutenance?.description = editAdresseController.text;
    editedSoutenance?.etat = editEmailController.text;
    editedSoutenance?.idSout = editMotDePasseController.text;
    editedSoutenance?.pfe = editNiveauValue ?? editedSoutenance?.niveau;
    editedSoutenance?.president =
        editSpecialiteValue ?? editedSoutenance?.specialite;
    editedSoutenance?.rapporteur =
        editDepartementValue ?? editedSoutenance?.departement;
    editedSoutenance?.salle =
        editSpecialiteValue ?? editedSoutenance?.specialite;
    editedSoutenance?.seance =
        editSpecialiteValue ?? editedSoutenance?.specialite;

    log("editedSoutenance::$editedSoutenance");
    editDepartementValue = null;
    editSpecialiteValue = null;
    editNiveauValue = null;
    await ApiSoutenance().updateSoutenance(soutenance: soutenance);
    getData();
  }*/

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ), // Text
      );
}
