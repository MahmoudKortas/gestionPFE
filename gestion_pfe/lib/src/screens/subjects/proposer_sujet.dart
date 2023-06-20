// ignore_for_file: prefer_typing_uninitialized_variables, prefer_final_fields, must_be_immutable

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/helpers/document_api.dart';
import 'package:gestion_pfe/src/helpers/encadrant_api.dart';
import 'package:gestion_pfe/src/models/document.dart';
import 'package:image_picker/image_picker.dart';

import '../../resize_widget.dart';

/// Displays detailed information about a SampleItem.
class ProposerSujet extends StatefulWidget {
  String fonction;
  var etudiant;
  var encadrant;

  ProposerSujet({
    Key? key,
    required this.fonction,
    this.encadrant,
    this.etudiant,
  }) : super(key: key);
  static const routeName = '/ProposerSujet';
  @override
  State<ProposerSujet> createState() => _ProposerSujetState();
}

class _ProposerSujetState extends State<ProposerSujet> {
  var _encadrant;
  var _listeEncadrant = [''];
  String? value;
  File? _image;
  final picker = ImagePicker();
  Document document = Document();

  final dateController = TextEditingController();
  final descriptionController = TextEditingController();
  final titreController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    log(widget.fonction);
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
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.description),
                    hintText: 'Saisir description',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'entrez la description du sujet';
                    }
                    return null;
                  },
                  controller: descriptionController,
                ),
                widget.fonction == "etudiant"
                    ? DropdownButton<String>(
                        hint: const Text("choisir l'encadrant"),
                        value: value,
                        iconSize: 36,
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.black),
                        items: _listeEncadrant
                            .map(buildMenuItem)
                            .toList(), //_items.map(buildMenuItem).toList(),
                        onChanged: (value) =>
                            setState(() => this.value = value),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                      )
                    : Container(),
                TextButton(onPressed: getImage, child: _buildImage()),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.
                      /*if (_formKey.currentState!.validate()) {
                          // Process data.
                        }*/
                      document.datedepot =
                          "2022-06-30T12:57:27.000+00:00"; //DateFormat('yyyy-MM-dd hh:mm:ss.SSSS').format(DateTime.now()).toString();
                      document.description = descriptionController.text;
                      // document.proprietaire = widget.fonction == "Encadrant"
                      widget.fonction == "Encadrant"
                          ? widget.encadrant.nom +
                              " " +
                              widget.encadrant.prenom
                          : widget.etudiant.nom +
                              " " +
                              widget.etudiant.prenom; // value ?? "";
                      document.titre = titreController.text;
                      document.idDoc = 0;
                      log("document::$document");
                      ApiDocument().addDocument(
                          document: document, filepath: _image!.path);
                    },
                    child: const Text("Valider"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getData() async {
    _encadrant = await ApiEncadrant().getEncadrant();
    log("_encadrant::$_encadrant");
    _listeEncadrant.clear();
    _encadrant
        .map((l) => {_listeEncadrant.add(l.nom + ' ' + l.prenom)})
        .toList();

    log("_listeEncadrant::$_listeEncadrant");

    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
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
