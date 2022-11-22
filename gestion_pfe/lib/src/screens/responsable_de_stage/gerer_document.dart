// ignore_for_file: prefer_typing_uninitialized_variables, prefer_final_fields, no_leading_underscores_for_local_identifiers

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../helpers/api_service.dart';
import '../../models/document.dart';
import '../../resize_widget.dart';

class GererDocument extends StatefulWidget {
  const GererDocument({Key? key}) : super(key: key);
  static const routeName = '/Document';
  @override
  State<GererDocument> createState() => _GererDocumentState();
}

class _GererDocumentState extends State<GererDocument> {
  late List<Document>? _document = [];
  var _enseignant;
  var _listeEnseignant = [''];
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gérer documents'),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        // controller: controller,
        child: Center(
          child: resiseWidget(
            context: context,
            child: Column(
              children: [
                /*TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.calendar_month),
                    hintText: 'Saisir date de depot',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'entrez votre login';
                    }
                    return null;
                  },
                  controller: dateController,
                ),*/
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
                DropdownButton<String>(
                  hint: const Text("choisir l'encadrant"),
                  value: value,
                  iconSize: 36,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                  items: _listeEnseignant
                      .map(buildMenuItem)
                      .toList(), //_items.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(() => this.value = value),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                TextButton(onPressed: getImage, child: _buildImage()),
                ElevatedButton(
                  // ignore: avoid_print
                  onPressed: () => addDocument(),
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
                                onTap: () => dialog(context,
                                    _document![index])),
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

  Future<String?> dialog(BuildContext context, Document document) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Modifier / Supprimer document'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Image.network("http://10.0.2.2:8080/api/document/image/${document.idDoc}"),

              // Image.asset("assets/images/logo-epi.png"),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Annuler'),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'Modifer'),
            child: const Text('Modifer'),
          ),
          TextButton(
            onPressed: () async {
              log(document.idDoc.toString());
              var _documentt;
              _documentt =
                  await ApiService().deleteDocument(id: document.idDoc.toString());
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
    _enseignant = await ApiService().getEnseignant();
    _listeEnseignant.clear();
    _enseignant
        .map((l) => {_listeEnseignant.add(l.nom + ' ' + l.prenom)})
        .toList();
    //await ApiService().updateEtudiants("3");
    //await ApiService().deleteEtudiants("17");
    // await ApiService().addEtudiants();
    // await ApiService().addDocument();
    //await ApiService().addEnseignant();

    _document = await ApiService().getDocument();

    //log("_document::$_document");
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }

  addDocument() async {
    document.description=descriptionController.text;
    document.titre=titreController.text;
    document.proprietaire="value";
    document.datedepot= DateTime.now().toIso8601String();
    document.photo="e";
    await ApiService().addDocument(document: document, filepath: _image!.path);

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
