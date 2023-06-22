// ignore_for_file: prefer_typing_uninitialized_variables, prefer_final_fields, no_leading_underscores_for_local_identifiers

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/helpers/document_api.dart';
import 'package:gestion_pfe/src/helpers/encadrant_api.dart';
import 'package:gestion_pfe/src/helpers/etudiant_api.dart';
import 'package:gestion_pfe/src/helpers/responsable.dart';
import 'package:gestion_pfe/src/models/responsable.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/document.dart';
import '../../models/encadrant.dart';
import '../../models/etudiant.dart';
import '../../resize_widget.dart';

class GererDocument extends StatefulWidget {
  const GererDocument({Key? key}) : super(key: key);
  static const routeName = '/Document';
  @override
  State<GererDocument> createState() => _GererDocumentState();
}

class _GererDocumentState extends State<GererDocument> {
  var _document;
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
  Document document = Document();
  final dateController = TextEditingController();
  final descriptionController = TextEditingController();
  final titreController = TextEditingController();
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
        title: const Text(' documents'),
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
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
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
                      addDocument();
                    } catch (e) {
                      log("gerer-document-exception::${e.toString()}");
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("quelque chose ne va pas"),
                            backgroundColor: Colors.red),
                      );
                    }
                  },
                  child: const Text("Ajouter"),
                ),
                /*_document == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    :*/
                _document!.isEmpty
                    ? const Text("aucun document existe")
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _document!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                                title: Text(_document![index].titre.toString()),
                                subtitle: Text(
                                    _document![index].description.toString()),
                                trailing: const Icon(Icons.more_vert),
                                // isThreeLine: true,
                                onTap: () =>
                                    dialog(context, _document![index])),
                          );
                        },
                      ) /*Card(
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

//TODO: fix edit document
  Future<String?> dialog(BuildContext context, Document document) {
    editTitreController.text = document.titre ?? "";
    editDescriptionController.text = document.description ?? "";
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Modifier / Supprimer document'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                  "http://10.0.2.2:8080/api/document/image/${document.idDoc}"),

              // Image.asset("assets/images/logo-epi.png"),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.description),
                  hintText: 'Saisir titre du document',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'entrez le titre du document';
                  }
                  return null;
                },
                controller: editTitreController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.description),
                  hintText: 'Saisir description du document',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'entrez la description du document';
                  }
                  return null;
                },
                controller: editDescriptionController,
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
              document.titre = editTitreController.text;
              document.description = editDescriptionController.text;
              editDocument(document: document);
              Navigator.pop(context, 'Modifer');
            },
            child: const Text('Modifer'),
          ),
          TextButton(
            onPressed: () async {
              log(document.idDoc.toString());
              var _documentt;
              _documentt = await ApiDocument()
                  .deleteDocument(id: document.idDoc.toString());
              log("_documentt::$_documentt");
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
      ApiDocument().getAllDocument(),
    ]).then((value) async {
      _etudiant = value[0]?.cast<Etudiant?>();
      _encadrant = value[1]?.cast<Encadrant?>();
      _responsable = value[2]?.cast<Responsable?>();
      _document = value[3]?.cast<Document?>();

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
      log("Document::$_document");
      Future.delayed(const Duration(seconds: 0))
          .then((value) => setState(() {}));
    });
  }

  addDocument() async {
    document.description = descriptionController.text;
    document.titre = titreController.text;
    document.datedepot = DateTime.now().toString();
    document.photo = "e";
    document.encadrant = _encadrant;
    document.responsable = _responsable;
    document.etudiant = _etudiant;
    await ApiDocument().addDocument(document: document, filepath: _image!.path);

    getData();
  }

  editDocument({Document? document}) async {
    await ApiDocument().updateDocument(document: document);

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
