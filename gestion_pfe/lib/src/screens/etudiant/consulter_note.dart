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
class ConsulterNote extends StatefulWidget {
  var fonction;
  var etudiant;
  var encadrant;

  ConsulterNote({
    Key? key,
    this.fonction,
    this.encadrant,
    this.etudiant,
  }) : super(key: key);
  static const routeName = '/ConsulterNote';
  @override
  State<ConsulterNote> createState() => _ConsulterNoteState();
}

class _ConsulterNoteState extends State<ConsulterNote> {
  // var _sujet;

  List<LigneSoutenance?>? _ligneSoutenance;

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
        title: const Text('Consulter note'),
      ),
      body: SingleChildScrollView(
        // controller: controller,
        child: Center(
          child: resiseWidget(
              context: context,
              child: _ligneSoutenance != null
                  ? _ligneSoutenance!.isEmpty
                      ? const Text("aucune note existe")
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _ligneSoutenance!.length,
                          itemBuilder: (context, index) {
                            inspect(_ligneSoutenance![index]);
                            return Card(
                              child: ListTile(
                                  title: Text(_ligneSoutenance?[index]
                                          ?.soutenance
                                          ?.pfe
                                          ?.sujet
                                          ?.titre ??
                                      "titre sujet"),
                                  subtitle: Text(
                                      "Note:  ${_ligneSoutenance![index]!.noteapplication.toString()}"),
                                  trailing: const Icon(Icons.more_vert),
                                  // isThreeLine: true,
                                  onTap: () => dialog(
                                      context, _ligneSoutenance![index])),
                            );
                          },
                        )
                  : const Text("aucun sujet existe null")),
        ),
      ),
    );
  }

  Future<String?> dialog(
      BuildContext context, LigneSoutenance? ligneSoutenance) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Note soutenance'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Note question/réponse: ${ligneSoutenance?.noteQR}"),
              Text("Note application: ${ligneSoutenance?.noteapplication}"),
              Text("Note présentation: ${ligneSoutenance?.notepresentation}"),
              Text("Note rapport: ${ligneSoutenance?.noterapport}"),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Annuler'),
            child: const Text('Annuler'),
          ),
        ],
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
      ApiLigneSoutenance().getAllLigneSoutenances(),
      ApiSoutenance().getAllSoutenance(),
    ]).then((value) async {
      _ligneSoutenance = value[0]?.cast<LigneSoutenance?>();
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
