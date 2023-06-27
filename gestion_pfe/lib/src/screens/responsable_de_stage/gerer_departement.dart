// ignore_for_file: prefer_typing_uninitialized_variables, prefer_final_fields, no_leading_underscores_for_local_identifiers

import 'dart:developer';
// import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:gestion_pfe/src/helpers/encadrant_api.dart';
// import 'package:image_picker/image_picker.dart';
import '../../helpers/departement_api.dart';
import '../../models/departement.dart';
import '../../resize_widget.dart';

class GererDepartement extends StatefulWidget {
  const GererDepartement({Key? key}) : super(key: key);
  static const routeName = '/Departement';
  @override
  State<GererDepartement> createState() => _GererDepartementState();
}

class _GererDepartementState extends State<GererDepartement> {
  late List<Departement>? _departement = [];
  String? value;
  Departement? departement = Departement();
  final nomController = TextEditingController();
  final editNomController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Departements'),
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
                    hintText: 'Saisir nom',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'entrez la nom du sujet';
                    }
                    return null;
                  },
                  controller: nomController,
                ),
                ElevatedButton(
                  // ignore: avoid_print
                  onPressed: () {
                    try {
                      addDepartement();
                    } catch (e) {
                      log("gerer-departement-exception::${e.toString()}");
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("quelque chose ne va pas"),
                            backgroundColor: Colors.red),
                      );
                    }
                  },
                  child: const Text("Ajouter"),
                ),
                /*_Departement == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    :*/
                _departement != null
                    ? _departement!.isEmpty
                        ? const Text("aucun Departement existe")
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _departement!.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                    title: Text(
                                        _departement![index].nom.toString()),
                                    subtitle: Text(
                                        _departement![index].nom.toString()),
                                    trailing: const Icon(Icons.more_vert),
                                    // isThreeLine: true,
                                    onTap: () =>
                                        dialog(context, _departement![index])),
                              );
                            },
                          )
                    : const Text("aucun Departement existe null")
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> dialog(BuildContext context, Departement departement) {
    editNomController.text = departement.nom ?? "";
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Modifier / Supprimer Departement'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.description),
                  hintText: 'Saisir nom du Departement',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'entrez la nom du Departement';
                  }
                  return null;
                },
                controller: editNomController,
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
              departement.nom = editNomController.text;
              editDepartement(departement: departement);
              Navigator.pop(context, 'Modifer');
            },
            child: const Text('Modifer'),
          ),
          TextButton(
            onPressed: () async {
              log(departement.idDep.toString());
              var _departementt;
              _departementt = await ApiDepartement()
                  .deleteDepartement(id: departement.idDep.toString());
              log("_Departementt::$_departementt");
              if (!_departementt.toString().contains("Suppression réussite")) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Suppression échoué"),
                      backgroundColor: Colors.red),
                );
              }
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
    _departement = await ApiDepartement().getAllDepartements();
    // _listeDepartement.clear();

    //log("_Departement::$_Departement");
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }

  addDepartement() async {
    departement?.nom = nomController.text;
    await ApiDepartement().addDepartement(departement: departement);

    getData();
  }

  editDepartement({Departement? departement}) async {
    await ApiDepartement().updateDepartement(departement: departement);
    getData();
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ), // Text
      );
}
