// ignore_for_file: prefer_typing_uninitialized_variables, prefer_final_fields, must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestion_pfe/src/helpers/encadrant_api.dart';
import 'package:gestion_pfe/src/helpers/ligne_soutenance_api.dart';
import 'package:gestion_pfe/src/helpers/soutenance_api.dart';
import 'package:gestion_pfe/src/models/encadrant.dart';
import 'package:gestion_pfe/src/models/ligne_soutenance.dart';
import 'package:gestion_pfe/src/models/soutenance.dart';
import '../../helpers/responsable_api.dart';
import '../../resize_widget.dart';

/// Displays detailed information about a SampleItem.
class ChoisirEncadrant extends StatefulWidget {
  var fonction;
  var etudiant;
  var encadrant;

  ChoisirEncadrant({
    Key? key,
    this.fonction,
    this.encadrant,
    this.etudiant,
  }) : super(key: key);
  static const routeName = '/ChoisirEncadrant';
  @override
  State<ChoisirEncadrant> createState() => _ChoisirEncadrantState();
}

class _ChoisirEncadrantState extends State<ChoisirEncadrant> {
  // var _sujet;

  List<Encadrant?>? _encadrant;

  final noterapportController = TextEditingController();
  final noteQRController = TextEditingController();
  final notepresentationController = TextEditingController();
  final noteapplicationController = TextEditingController();
  Encadrant encadrant = Encadrant();
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
        title: const Text('Choisir encadrant'),
      ),
      body: SingleChildScrollView(
        // controller: controller,
        child: Center(
          child: resiseWidget(
              context: context,
              child: _encadrant != null
                  ? _encadrant!.isEmpty
                      ? const Text("aucun encadrant existe")
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _encadrant!.length,
                          itemBuilder: (context, index) {
                            inspect(_encadrant![index]);
                            return Card(
                              child: ListTile(
                                  title: Text(
                                      "${_encadrant?[index]?.nom ?? ""} ${_encadrant?[index]?.prenom ?? ""}"),
                                  // subtitle: Text(
                                  //     "Note:  ${_encadrant![index]!..toString()}"),
                                  trailing: const Icon(Icons.more_vert),
                                  // isThreeLine: true,
                                  onTap: () =>
                                      dialog(context, _encadrant![index])),
                            );
                          },
                        )
                  : const Text("aucun sujet existe null")),
        ),
      ),
    );
  }

  Future<String?> dialog(BuildContext context, Encadrant? encadrant) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Détail encadrant'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Nom encadrant: ${encadrant?.nom}"),
              Text("Prénom encadrant: ${encadrant?.prenom}"),
              Text("Email encadrant: ${encadrant?.email}"),
              Text("département encadrant: ${encadrant?.departement?.nom}"),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Choisir'),
            child: const Text('Choisir'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'Annuler'),
            child: const Text('Annuler'),
          ),
        ],
      ),
    );
  }

  /* addSujet() async {
    try {
      encadrant.noteapplication = double.parse(noteapplicationController.text);
    } catch (e) {
      log("noteapplication-exception::$e");
    }
    try {
      encadrant.notepresentation =
          double.parse(notepresentationController.text);
    } catch (e) {
      log("notepresentation-exception::$e");
    }
    try {
      encadrant.noteQR = double.parse(noteQRController.text);
    } catch (e) {
      log("noteQR-exception::$e");
    }
    try {
      encadrant.noterapport = double.parse(noterapportController.text);
    } catch (e) {
      log("noterapport-exception::$e");
    }
    encadrant.soutenance = soutenanceValue;
    soutenanceValue = null;
    await ApiEncadrant().addEncadrants(encadrant: encadrant);

    getData();
  }*/

  void getData() async {
    await Future.wait([
      ApiEncadrant().getAllEncadrant(),
    ]).then((value) async {
      _encadrant = value[0]?.cast<Encadrant?>();
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
