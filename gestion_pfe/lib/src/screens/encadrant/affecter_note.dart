// ignore_for_file: prefer_typing_uninitialized_variables, prefer_final_fields, must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestion_pfe/src/helpers/encadrant_api.dart';
import 'package:gestion_pfe/src/helpers/ligne_soutenance_api.dart';
import 'package:gestion_pfe/src/helpers/soutenance_api.dart';
import 'package:gestion_pfe/src/models/ligne_soutenance.dart';
import 'package:gestion_pfe/src/models/soutenance.dart';
import '../../helpers/responsable_api.dart';
import '../../resize_widget.dart';

/// Displays detailed information about a SampleItem.
class AffecterNote extends StatefulWidget {
  var fonction;
  var etudiant;
  var encadrant;

  AffecterNote({
    Key? key,
    this.fonction,
    this.encadrant,
    this.etudiant,
  }) : super(key: key);
  static const routeName = '/AffecterNote';
  @override
  State<AffecterNote> createState() => _AffecterNoteState();
}

class _AffecterNoteState extends State<AffecterNote> {
  // var _sujet;

  final noterapportController = TextEditingController();
  final noteQRController = TextEditingController();
  final notepresentationController = TextEditingController();
  final noteapplicationController = TextEditingController();
  LigneSoutenance ligneSoutenance = LigneSoutenance();
  List<Soutenance?>? _soutenance;
  Soutenance? soutenanceValue;

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
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.description),
                    hintText: 'Note rapport',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'entrez la note du rapport';
                    }
                    return null;
                  },
                  controller: noterapportController,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.description),
                    hintText: 'note qr',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'entrez la note qr';
                    }
                    return null;
                  },
                  controller: noteQRController,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.description),
                    hintText: 'Note de presentation',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'entrez la note du presentation';
                    }
                    return null;
                  },
                  controller: notepresentationController,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.description),
                    hintText: 'noteapplication',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "entrez la note d'aplication";
                    }
                    return null;
                  },
                  controller: noteapplicationController,
                ),
                const SizedBox(
                  height: 10,
                ),
                _soutenance != null
                    ? DropdownButton(
                        value: soutenanceValue,
                        iconSize: 36,
                        hint: const Text("choisir la soutenance"),
                        items: _soutenance?.map((item) {
                          return DropdownMenuItem<Soutenance>(
                            value: item,
                            child: Text(item!.description!),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          log("newVal::$newVal");
                          setState(() {
                            soutenanceValue = newVal as Soutenance?;
                          });
                        },
                      )
                    : Container(),
                const SizedBox(
                  height: 10,
                ),
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
    try {
      ligneSoutenance.noteapplication =
          double.parse(noteapplicationController.text);
    } catch (e) {
      log("noteapplication-exception::$e");
    }
    try {
      ligneSoutenance.notepresentation =
          double.parse(notepresentationController.text);
    } catch (e) {
      log("notepresentation-exception::$e");
    }
    try {
      ligneSoutenance.noteQR = double.parse(noteQRController.text);
    } catch (e) {
      log("noteQR-exception::$e");
    }
    try {
      ligneSoutenance.noterapport = double.parse(noterapportController.text);
    } catch (e) {
      log("noterapport-exception::$e");
    }
    ligneSoutenance.soutenance = soutenanceValue;
    soutenanceValue = null;
    await ApiLigneSoutenance()
        .addLigneSoutenances(ligneSoutenance: ligneSoutenance);

    getData();
  }

  void getData() async {
    await Future.wait([
      ApiSoutenance().getAllSoutenance(),
      ApiEncadrant().getAllEncadrant(),
      ApiResponsable().getAllResponsable(),
    ]).then((value) async {
      _soutenance = value[0]?.cast<Soutenance?>();
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
