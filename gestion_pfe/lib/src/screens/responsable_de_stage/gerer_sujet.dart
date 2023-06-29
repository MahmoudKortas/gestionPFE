// ignore_for_file: prefer_typing_uninitialized_variables, prefer_final_fields, no_leading_underscores_for_local_identifiers

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/helpers/sujet_api.dart';
import 'package:gestion_pfe/src/helpers/encadrant_api.dart';
import 'package:gestion_pfe/src/helpers/etudiant_api.dart';
import 'package:gestion_pfe/src/helpers/responsable_api.dart';
import 'package:gestion_pfe/src/models/responsable.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/sujet.dart';
import '../../models/encadrant.dart';
import '../../models/etudiant.dart';
import '../../resize_widget.dart';

class GererSujet extends StatefulWidget {
  const GererSujet({Key? key}) : super(key: key);
  static const routeName = '/Sujet';
  @override
  State<GererSujet> createState() => _GererSujetState();
}

class _GererSujetState extends State<GererSujet> {
  File? _image;
  final picker = ImagePicker();

  var _sujet;

  final titreController = TextEditingController();
  final descriptionController = TextEditingController();
  Sujet sujet = Sujet();
  List<Etudiant?>? _etudiant;
  Etudiant? etudiantValue;
  List<Encadrant?>? _encadrant;
  Encadrant? encadrantValue;
  List<Responsable?>? _responsable;
  Responsable? responsableValue;

  final editTitreController = TextEditingController();
  final editDescriptionController = TextEditingController();
  Sujet editedSujet = Sujet();
  Etudiant? editEtudiantValue;
  Encadrant? editEncadrantValue;
  Responsable? editResponsableValue;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('sujets'),
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
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.description),
                    hintText: 'Saisir titre',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'entrez le titre du sujet';
                    }
                    return null;
                  },
                  controller: titreController,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.description),
                    hintText: 'Description',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'entrez la description du sujet';
                    }
                    return null;
                  },
                  controller: descriptionController,
                ),
                const SizedBox(
                  height: 20,
                ),
                _encadrant != null
                    ? DropdownButton(
                        value: encadrantValue,
                        iconSize: 36,
                        hint: const Text("choisir l'encadrant"),
                        items: _encadrant?.map((item) {
                          return DropdownMenuItem<Encadrant>(
                            value: item,
                            child: Text(item!.nom!),
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
                const SizedBox(
                  height: 10,
                ),
                _responsable != null
                    ? DropdownButton(
                        value: responsableValue,
                        iconSize: 36,
                        hint: const Text("choisir le responsable"),
                        items: _responsable?.map((item) {
                          return DropdownMenuItem<Responsable>(
                            value: item,
                            child: Text(item!.nom!),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          log("newVal::$newVal");
                          setState(() {
                            responsableValue = newVal as Responsable?;
                          });
                        },
                      )
                    : Container(),
                const SizedBox(
                  height: 10,
                ),
                _etudiant != null
                    ? DropdownButton(
                        value: etudiantValue,
                        iconSize: 36,
                        hint: const Text("choisir l'etudiant"),
                        items: _etudiant?.map((item) {
                          return DropdownMenuItem<Etudiant>(
                            value: item,
                            child: Text(item!.nom!),
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
                // TextButton(onPressed: getImage, child: _buildImage()),
                ElevatedButton(
                  // ignore: avoid_print
                  onPressed: () {
                    try {
                      addSujet();
                    } catch (e) {
                      log("gerer-sujet-exception::${e.toString()}");
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("quelque chose ne va pas"),
                            backgroundColor: Colors.red),
                      );
                    }
                  },
                  child: const Text("Ajouter"),
                ),
                /*_sujet == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    :*/
                _sujet != null
                    ? _sujet!.isEmpty
                        ? const Text("aucun sujet existe")
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _sujet!.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                    title:
                                        Text(_sujet![index].titre.toString()),
                                    subtitle: Text(
                                        _sujet![index].description.toString()),
                                    trailing: const Icon(Icons.more_vert),
                                    // isThreeLine: true,
                                    onTap: () =>
                                        dialog(context, _sujet![index])),
                              );
                            },
                          )
                    : const Text("aucun sujet existe null")
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> dialog(BuildContext context, Sujet sujet) {
    editedSujet = sujet;
    editTitreController.text = sujet.titre ?? "";
    editDescriptionController.text = sujet.description ?? "";
    // editEtudiantValue = sujet.etudiant;
    // editEncadrantValue = sujet.encadrant;
    // editResponsableValue = sujet.responsable;

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Modifier / Supprimer sujet'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              // Image.asset("assets/images/logo-epi.png"),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.description),
                  hintText: 'Saisir titre du sujet',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'entrez le titre du sujet';
                  }
                  return null;
                },
                controller: editTitreController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.description),
                  hintText: 'Saisir description du sujet',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'entrez la description du sujet';
                  }
                  return null;
                },
                controller: editDescriptionController,
              ),
              _encadrant != null
                  ? DropdownButton(
                      value: editEncadrantValue,
                      iconSize: 36,
                      hint: Text(sujet.encadrant?.nom ?? "choisir encadrant"),
                      items: _encadrant?.map((item) {
                        return DropdownMenuItem<Encadrant>(
                          value: item,
                          child: Text(item!.nom!),
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
              const SizedBox(
                height: 10,
              ),
              _responsable != null
                  ? DropdownButton(
                      value: editResponsableValue,
                      iconSize: 36,
                      hint:
                          Text(sujet.responsable?.nom ?? "choisir responsable"),
                      items: _responsable?.map((item) {
                        return DropdownMenuItem<Responsable>(
                          value: item,
                          child: Text(item!.nom!),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        log("newVal::$newVal");
                        setState(() {
                          editResponsableValue = newVal as Responsable?;
                        });
                      },
                    )
                  : Container(),

              const SizedBox(
                height: 10,
              ),
              _etudiant != null
                  ? DropdownButton(
                      value: editEtudiantValue,
                      iconSize: 36,
                      hint: Text(sujet.etudiant?.nom ?? "choisir etudiant"),
                      items: _etudiant?.map((item) {
                        return DropdownMenuItem<Etudiant>(
                          value: item,
                          child: Text(item!.nom!),
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
              // TextButton(onPressed: getImage, child: _buildImage()),
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
              editSujet();
              Navigator.pop(context, 'Modifer');
            },
            child: const Text('Modifer'),
          ),
          TextButton(
            onPressed: () async {
              log(sujet.idSujet.toString());
              var _sujett;
              _sujett =
                  await ApiSujet().deleteSujet(id: sujet.idSujet.toString());
              log("_sujett::$_sujett");
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
      ApiEtudiant().getAllEtudiants(),
      ApiEncadrant().getAllEncadrant(),
      ApiResponsable().getAllResponsable(),
      ApiSujet().getAllSujets(),
    ]).then((value) async {
      _etudiant = value[0]?.cast<Etudiant?>();
      _encadrant = value[1]?.cast<Encadrant?>();
      _responsable = value[2]?.cast<Responsable?>();
      _sujet = value[3]?.cast<Sujet?>();
      // log("_encadrant::$_encadrant");
      // log("_etudiant::$_etudiant");
      // log("Sujet::$_sujet");
      Future.delayed(const Duration(seconds: 0))
          .then((value) => setState(() {}));
    });
  }

  addSujet() async {
    sujet.titre = titreController.text;
    sujet.description = descriptionController.text;
    sujet.date = DateTime.now().toString();
    sujet.encadrant = encadrantValue;
    sujet.responsable = responsableValue;
    sujet.etudiant = etudiantValue;
    encadrantValue = null;
    responsableValue = null;
    etudiantValue = null;
    await ApiSujet().addSujets(sujet: sujet);

    getData();
  }

  editSujet() async {
    editedSujet.titre = editTitreController.text;
    editedSujet.description = editDescriptionController.text;
    editedSujet.encadrant = editEncadrantValue;
    editedSujet.responsable = editResponsableValue;
    editedSujet.etudiant = editEtudiantValue;
    editEncadrantValue = null;
    editResponsableValue = null;
    editEtudiantValue = null;
    await ApiSujet().updateSujets(editedSujet: editedSujet);

    getData();
  }

  /*Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        log('No image selected.');
      }
    });
  }*/

  /*Widget _buildImage() {
    if (_image == null) {
      return const Padding(
        padding: EdgeInsets.all(5),
        child: Icon(
          Icons.add,
          color: Colors.grey,
        ),
      );
    } else {
      return Text(_image!.path);
    }
  }*/
}
