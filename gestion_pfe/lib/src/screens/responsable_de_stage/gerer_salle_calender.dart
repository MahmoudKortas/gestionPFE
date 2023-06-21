// ignore_for_file: prefer_typing_uninitialized_variables, prefer_final_fields, no_leading_underscores_for_local_identifiers

import 'dart:developer';
// import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:gestion_pfe/src/helpers/encadrant_api.dart';
// import 'package:image_picker/image_picker.dart';
import '../../helpers/salle.dart';
import '../../models/salle.dart';
import '../../resize_widget.dart';

class GererSalle extends StatefulWidget {
  const GererSalle({Key? key}) : super(key: key);
  static const routeName = '/gererSalle';
  @override
  State<GererSalle> createState() => _GererSalleState();
}

class _GererSalleState extends State<GererSalle> {
  late List<Salle>? _salle = [];
  String? value;
  Salle? salle = Salle();
  final descriptionController = TextEditingController();
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
        title: const Text(' Salles'),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        // controller: controller,
        child: Center(
          child: resiseWidget(
            context: context,
            child: Column(
              children: [
                Row(
                  children: [
                    const Text("s1"),
                    Column(
                      children: const [
                        ListTile(
                          title: Text("SFE 0001 . . ."),
                        ),
                        ListTile(
                          title: Text("SFE 0001 . . ."),
                        ),
                        ListTile(
                          title: Text("SFE 0001 . . ."),
                        ),
                      ],
                    ),
                  ],
                ),
                /*ElevatedButton(
                  // ignore: avoid_print
                  onPressed: () => addSalle(),
                  child: const Text("Ajouter"),
                ),*/
                /*_Salle == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    :*/
                _salle != null
                    ? _salle!.isEmpty
                        ? const Text("aucun Salle existe")
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _salle!.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                    title: Text(_salle![index].nom.toString()),
                                    subtitle:
                                        Text(_salle![index].nom.toString()),
                                    trailing: const Icon(Icons.more_vert),
                                    // isThreeLine: true,
                                    onTap: () =>
                                        dialog(context, _salle![index])),
                              );
                            },
                          )
                    : const Text("aucun Salle existe null")
                /*Card(
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

  Future<String?> dialog(BuildContext context, Salle salle) {
    editNomController.text = salle.nom ?? "";
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Modifier / Supprimer Salle'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.description),
                  hintText: 'Saisir nom du salle',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'entrez la nom du salle';
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
              salle.nom = editNomController.text;
              editSalle(salle: salle);
              Navigator.pop(context, 'Modifer');
            },
            child: const Text('Modifer'),
          ),
          TextButton(
            onPressed: () async {
              log(salle.idSalle.toString());
              var sallet;
              sallet =
                  await ApiSalle().deleteSalle(id: salle.idSalle.toString());
              log("_Sallet::$sallet");
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
    _salle = await ApiSalle().getAllSalles();
    // _listeSalle.clear();

    //log("_Salle::$_Salle");
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }

  addSalle() async {
    salle?.nom = descriptionController.text;
    await ApiSalle().addSalle(salle: salle);

    getData();
  }

  editSalle({Salle? salle}) async {
    await ApiSalle().updateSalle(salle: salle);
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
