// ignore_for_file: prefer_typing_uninitialized_variables, prefer_final_fields, must_be_immutable

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/helpers/document_api.dart';
import 'package:gestion_pfe/src/helpers/encadrant_api.dart';
import 'package:gestion_pfe/src/models/document.dart';
import 'package:image_picker/image_picker.dart';

import '../../helpers/etudiant_api.dart';
import '../../helpers/responsable_api.dart';
import '../../helpers/sujet_api.dart';
import '../../resize_widget.dart';

// ignore_for_file: prefer_typing_uninitialized_variables, prefer_final_fields, no_leading_underscores_for_local_identifiers
import 'package:gestion_pfe/src/models/responsable.dart';
import '../../models/sujet.dart';
import '../../models/encadrant.dart';
import '../../models/etudiant.dart';

/// Displays detailed information about a SampleItem.
class ProposerSujetEncadrant extends StatefulWidget {
  var fonction;
  var etudiant;
  var encadrant;

  ProposerSujetEncadrant({
    Key? key,
    this.fonction,
    this.encadrant,
    this.etudiant,
  }) : super(key: key);
  static const routeName = '/ProposerSujetEncadrant';
  @override
  State<ProposerSujetEncadrant> createState() => _ProposerSujetEncadrantState();
}

class _ProposerSujetEncadrantState extends State<ProposerSujetEncadrant> {
  // var _sujet;

  final titreController = TextEditingController();
  final descriptionController = TextEditingController();
  Sujet sujet = Sujet();
  List<Etudiant?>? _etudiant;
  Etudiant? etudiantValue;
  List<Encadrant?>? _encadrant;
  Encadrant? encadrantValue;
  List<Responsable?>? _responsable;
  Responsable? responsableValue;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // log(widget.fonction);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proposer sujet'),
      ),
      body: SingleChildScrollView(
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
                    hintText: 'Titre du sujet',
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
                    hintText: 'Description du sujet',
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
               /* _encadrant != null
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
                    : Container(),*/
                const SizedBox(
                  height: 10,
                ),
               /* _responsable != null
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
                    : Container(),*/
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
                    : Container(),*/
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
              ],
            ),
          ),
        ),
      ),
    );
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

  void getData() async {
    await Future.wait([
      ApiEtudiant().getAllEtudiants(),
      ApiEncadrant().getAllEncadrant(),
      ApiResponsable().getAllResponsable(),
      // ApiSujet().getAllSujets(),
    ]).then((value) async {
      _etudiant = value[0]?.cast<Etudiant?>();
      _encadrant = value[1]?.cast<Encadrant?>();
      _responsable = value[2]?.cast<Responsable?>();
      // _sujet = value[3]?.cast<Sujet?>();
      Future.delayed(const Duration(seconds: 0))
          .then((value) => setState(() {}));
    });
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
