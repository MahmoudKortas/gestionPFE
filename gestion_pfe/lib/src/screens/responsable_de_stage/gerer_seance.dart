// ignore_for_file: prefer_typing_uninitialized_variables, prefer_final_fields, no_leading_underscores_for_local_identifiers

import 'dart:developer';
// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/helpers/Seance_api.dart';
// import 'package:gestion_pfe/src/helpers/encadrant_api.dart';
// import 'package:image_picker/image_picker.dart';
import '../../models/seance_model.dart';
import '../../resize_widget.dart';

class GererSeance extends StatefulWidget {
  const GererSeance({Key? key}) : super(key: key);
  static const routeName = '/Seance';
  @override
  State<GererSeance> createState() => _GererSeanceState();
}

class _GererSeanceState extends State<GererSeance> {
  late List<Seance>? _seance = [];
  String? value;
  Seance? seance = Seance();
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
        title: const Text(' Seances'),
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
                    hintText: 'Saisir la seance',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'entrez la seance';
                    }
                    return null;
                  },
                  controller: nomController,
                ),
                ElevatedButton(
                  // ignore: avoid_print
                  onPressed: () {
                    try {
                      addSeance();
                    } catch (e) {
                      log("gerer-seance-exception::${e.toString()}");
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("quelque chose ne va pas"),
                            backgroundColor: Colors.red),
                      );
                    }
                  },
                  child: const Text("Ajouter"),
                ),
                /*_Seance == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    :*/
                _seance != null
                    ? _seance!.isEmpty
                        ? const Text("aucun Seance existe")
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _seance!.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                    title: Text(_seance![index].nom.toString()),
                                    subtitle:
                                        Text(_seance![index].nom.toString()),
                                    trailing: const Icon(Icons.more_vert),
                                    // isThreeLine: true,
                                    onTap: () =>
                                        dialog(context, _seance![index])),
                              );
                            },
                          )
                    : const Text("aucun Seance existe null")
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

  Future<String?> dialog(BuildContext context, Seance seance) {
    editNomController.text = seance.nom ?? "";
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Modifier / Supprimer Seance'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.description),
                  hintText: 'Saisir nom du seance',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'entrez la nom du seance';
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
              seance.nom = editNomController.text;
              editSeance(seance: seance);
              Navigator.pop(context, 'Modifer');
            },
            child: const Text('Modifer'),
          ),
          TextButton(
            onPressed: () async {
              log(seance.idSeance.toString());
              var seancet;
              seancet = await ApiSeance()
                  .deleteSeance(id: seance.idSeance.toString());
              log("_Seancet::$seancet");
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
    _seance = await ApiSeance().getAllSeances();
    // _listeSeance.clear();

    //log("_Seance::$_Seance");
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }

  addSeance() async {
    seance?.nom = nomController.text;
    await ApiSeance().addSeance(seance: seance);

    getData();
  }

  editSeance({Seance? seance}) async {
    //todo: fix update seance
     await ApiSeance().updateSeance(seance: seance);

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
