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
  var _sujet;
  var _encadrant;
  var _listeEncadrant = [''];
  var _responsable;
  var _listeResponsable = [''];
  var _etudiant;
  var _listeEtudiant = [''];
  String? valueEncadrant;
  String? valueResponsable;
  String? valueEtudiant;
  File? _image;
  final picker = ImagePicker();
  Sujet sujet = Sujet();
  final titreController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  final editTitreController = TextEditingController();
  final editDescriptionController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' sujets'),
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
                DropdownButton<String>(
                  hint: const Text("choisir l'encadrant"),
                  value: valueEncadrant,
                  iconSize: 36,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                  items: _listeEncadrant
                      .map(buildMenuItem)
                      .toList(), //_items.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(() => valueEncadrant = value),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButton<String>(
                  hint: const Text("choisir le responsable"),
                  value: valueResponsable,
                  iconSize: 36,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                  items: _listeResponsable
                      .map(buildMenuItem)
                      .toList(), //_items.map(buildMenuItem).toList(),
                  onChanged: (value) =>
                      setState(() => valueResponsable = value),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButton<String>(
                  hint: const Text("choisir l'etudiant"),
                  value: valueEtudiant,
                  iconSize: 36,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                  items: _listeEtudiant
                      .map(buildMenuItem)
                      .toList(), //_items.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(() => valueEtudiant = value),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                TextButton(onPressed: getImage, child: _buildImage()),
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
                                    title: Text(
                                        _sujet![index].titre.toString()),
                                    subtitle: Text(_sujet![index]
                                        .description
                                        .toString()),
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

//TODO: fix edit sujet
  Future<String?> dialog(BuildContext context, Sujet sujet) {
    editTitreController.text = sujet.titre ?? "";
    editDescriptionController.text = sujet.description ?? "";
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
              DropdownButton<String>(
                hint: const Text("choisir l'encadrant"),
                value: valueEncadrant,
                iconSize: 36,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                items: _listeEncadrant
                    .map(buildMenuItem)
                    .toList(), //_items.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() => valueEncadrant = value),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButton<String>(
                hint: const Text("choisir le responsable"),
                value: valueResponsable,
                iconSize: 36,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                items: _listeResponsable
                    .map(buildMenuItem)
                    .toList(), //_items.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() => valueResponsable = value),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButton<String>(
                hint: const Text("choisir l'etudiant"),
                value: valueEtudiant,
                iconSize: 36,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                items: _listeEtudiant
                    .map(buildMenuItem)
                    .toList(), //_items.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() => valueEtudiant = value),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              TextButton(onPressed: getImage, child: _buildImage()),
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
              sujet.titre = editTitreController.text;
              sujet.description = editDescriptionController.text;
              sujet.date = DateTime.now().toString();
             
              sujet.encadrant = Encadrant(); // valueEncadrant;
              sujet.responsable = Responsable(); // _responsable;
              sujet.etudiant = Etudiant(); // _etudiant;
              editSujet(sujet: sujet);
              Navigator.pop(context, 'Modifer');
            },
            child: const Text('Modifer'),
          ),
          TextButton(
            onPressed: () async {
              log(sujet.idSujet.toString());
              var _sujett;
              _sujett = await ApiSujet()
                  .deleteSujet(id: sujet.idSujet.toString());
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

      _listeEtudiant.clear();
      _etudiant
          .map((l) => {_listeEtudiant.add(l.nom + ' ' + l.prenom)})
          .toList();

      _listeEncadrant.clear();
      _encadrant
          .map((l) => {_listeEncadrant.add(l.nom + ' ' + l.prenom)})
          .toList();

      _listeResponsable.clear();
      _responsable
          .map((l) => {_listeResponsable.add(l.nom + ' ' + l.prenom)})
          .toList();

      log("_encadrant::$_encadrant");
      log("_etudiant::$_etudiant");
      log("Sujet::$_sujet");
      Future.delayed(const Duration(seconds: 0))
          .then((value) => setState(() {}));
    });
  }

  addSujet() async {
    sujet.titre = titreController.text;
    sujet.description = descriptionController.text;
    sujet.date = DateTime.now().toString();
    sujet.encadrant = Encadrant(); // valueEncadrant;
    sujet.responsable = Responsable(); // _responsable;
    sujet.etudiant = Etudiant(); // _etudiant;
  
 

    await ApiSujet()
        .addSujets(sujet: sujet );

    getData();
  }

  editSujet({Sujet? sujet}) async {
    await ApiSujet().updateSujets(sujet: sujet);

    getData();
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ), // Text
      );
  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        log('No image selected.');
      }
    });
  }

  Widget _buildImage() {
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
  }
}
