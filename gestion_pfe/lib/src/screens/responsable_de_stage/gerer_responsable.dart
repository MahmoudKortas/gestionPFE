// ignore_for_file: prefer_typing_uninitialized_variables, prefer_final_fields, no_leading_underscores_for_local_identifiers

import 'dart:developer';
// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/helpers/departement.dart';
// import 'package:gestion_pfe/src/helpers/encadrant_api.dart';
import 'package:gestion_pfe/src/models/departement.dart';
// import 'package:image_picker/image_picker.dart';
import '../../helpers/responsable.dart';
import '../../models/responsable.dart';
import '../../resize_widget.dart';

class GererResponsable extends StatefulWidget {
  const GererResponsable({Key? key}) : super(key: key);
  static const routeName = '/Responsable';
  @override
  State<GererResponsable> createState() => _GererResponsableState();
}

class _GererResponsableState extends State<GererResponsable> {
  late List<Responsable?>? _responsable = [];
  String? value;
  Responsable? responsable = Responsable();
  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final emailController = TextEditingController();
  final motdepasseController = TextEditingController();
  final telController = TextEditingController();
  final dateResponsabiliteController = TextEditingController();

  Departement? departementValue;

  List<Departement?>? _departement;
  //tODO: complete b9ia
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
        title: const Text(' Responsables'),
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
                      return 'entrez le nom';
                    }
                    return null;
                  },
                  controller: nomController,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.description),
                    hintText: 'Saisir prenom',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'entrez la prenom du sujet';
                    }
                    return null;
                  },
                  controller: prenomController,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.description),
                    hintText: 'Saisir email',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'entrez email';
                    }
                    return null;
                  },
                  controller: emailController,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.description),
                    hintText: 'Saisir mot de passe',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'entrez la mot de passe';
                    }
                    return null;
                  },
                  controller: motdepasseController,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.description),
                    hintText: 'Saisir numéro telephone',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'entrez le numéro telephone';
                    }
                    return null;
                  },
                  controller: telController,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.description),
                    hintText: 'Saisir Date responsabilite ',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'entrez la Date responsabilite';
                    }
                    return null;
                  },
                  controller: dateResponsabiliteController,
                ),
                _departement != null
                    ? DropdownButton(
                        value: departementValue,
                        iconSize: 36,
                        hint: const Text("choisir l'departement"),
                        items: _departement?.map((item) {
                          return DropdownMenuItem<Departement>(
                            value: item,
                            child: Text(item!.nom!),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          log("newVal::$newVal");
                          setState(() {
                            departementValue = newVal as Departement?;
                          });
                        },
                      )
                    : Container(),
                ElevatedButton(
                  // ignore: avoid_print
                  onPressed: () {
                    try {
                      addResponsable();
                    } catch (e) {
                      log("gerer-responsable-exception::${e.toString()}");
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("quelque chose ne va pas"),
                            backgroundColor: Colors.red),
                      );
                    }
                  } ,
                  child: const Text("Ajouter"),
                ),
                /*_Responsable == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    :*/
                _responsable != null
                    ? _responsable!.isEmpty
                        ? const Text("aucun Responsable existe")
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _responsable!.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                    title: Text(
                                        _responsable![index]!.nom.toString()),
                                    subtitle: Text(_responsable![index]!
                                        .prenom
                                        .toString()),
                                    trailing: const Icon(Icons.more_vert),
                                    // isThreeLine: true,
                                    onTap: () =>
                                        dialog(context, _responsable![index]!)),
                              );
                            },
                          )
                    : const Text("aucun Responsable existe null")
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

  Future<String?> dialog(BuildContext context, Responsable responsable) {
    editNomController.text = responsable.nom ?? "";
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Modifier / Supprimer Responsable'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.description),
                  hintText: 'Saisir nom du responsable',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'entrez la nom du responsable';
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
              responsable.nom = editNomController.text;
              editResponsable(responsable: responsable);
              Navigator.pop(context, 'Modifer');
            },
            child: const Text('Modifer'),
          ),
          TextButton(
            onPressed: () async {
              log(responsable.idUser.toString());
              var responsablet;
              responsablet = await ApiResponsable()
                  .deleteResponsable(id: responsable.idUser.toString());
              log("_Responsablet::$responsablet");
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
      ApiResponsable().getAllResponsable(),
      ApiDepartement().getAllDepartements()
    ]).then((value) async {
      _responsable = value[0]?.cast<Responsable?>();
      _departement = value[1]?.cast<Departement?>();
    });

    // _listeResponsable.clear();

    //log("_Responsable::$_Responsable");
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }

  addResponsable() async {
    responsable?.email = emailController.text;
    responsable?.motdepasse = motdepasseController.text;
    responsable?.tel = telController.text;
    responsable?.prenom = prenomController.text;
    responsable?.nom = nomController.text;
    responsable?.dateResponsabilite = dateResponsabiliteController.text;
    responsable?.departement = departementValue;
    await ApiResponsable().addResponsable(responsable: responsable);

    getData();
  }

  editResponsable({Responsable? responsable}) async {
    await ApiResponsable().updateResponsable(responsable: responsable);
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
