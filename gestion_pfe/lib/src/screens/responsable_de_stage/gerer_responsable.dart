// ignore_for_file: prefer_typing_uninitialized_variables, prefer_final_fields, no_leading_underscores_for_local_identifiers

import 'dart:developer';
// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestion_pfe/src/helpers/departement_api.dart';
// import 'package:gestion_pfe/src/helpers/encadrant_api.dart';
import 'package:gestion_pfe/src/models/departement.dart';
// import 'package:image_picker/image_picker.dart';
import '../../helpers/responsable_api.dart';
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
  Responsable? responsable = Responsable();
  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final emailController = TextEditingController();
  final telController = TextEditingController();
  final motdepasseController = TextEditingController();
  final dateResponsabiliteController = TextEditingController();

  Departement? departementValue;
  List<Departement?>? _departement;

  final editNomController = TextEditingController();
  final editPrenomController = TextEditingController();
  final editEmailController = TextEditingController();
  final editTelephoneController = TextEditingController();
  final editMotDePasseController = TextEditingController();
  Responsable? editedResponsable = Responsable();
  Departement? editDepartementValue;
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    nomController.dispose();
    prenomController.dispose();
    telController.dispose();
    emailController.dispose();
    motdepasseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Responsables'),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
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
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  keyboardType: TextInputType.number,
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
                        hint: const Text("choisir votre departement"),
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
                  },
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> dialog(BuildContext context, Responsable responsable) {
    editedResponsable = responsable;
    editNomController.text = responsable.nom ?? "";
    editPrenomController.text = responsable.prenom ?? "";
    editTelephoneController.text = responsable.tel ?? "";
    editEmailController.text = responsable.email ?? "";
    editMotDePasseController.text = responsable.motdepasse ?? "";
    editNomController.text = responsable.nom ?? "";
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Modifier / Supprimer Responsable'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.description),
                  hintText: responsable.nom,
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'entrez le nom du responsable';
                  }
                  return null;
                },
                controller: editNomController,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  hintText: responsable.prenom,
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Entrez  prenom';
                  }
                  return null;
                },
                controller: editPrenomController,
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.phone),
                  hintText: responsable.tel,
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Entrez votre telephone';
                  }
                  return null;
                },
                controller: editTelephoneController,
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  hintText: responsable.email,
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Entrez votre email';
                  }
                  return null;
                },
                controller: editEmailController,
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  hintText: responsable.motdepasse,
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Entrez votre password';
                  }
                  return null;
                },
                controller: editMotDePasseController,
              ),
              _departement != null
                  ? DropdownButton(
                      value: editDepartementValue,
                      iconSize: 36,
                      hint: Text(responsable.departement?.nom ??
                          "choisir votre departement"),
                      items: _departement?.map((item) {
                        return DropdownMenuItem<Departement>(
                          value: item,
                          child: Text(item!.nom!),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        log("newVal::$newVal");
                        setState(() {
                          editDepartementValue = newVal as Departement?;
                        });
                      },
                    )
                  : Container(),
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
              try {
                editResponsable();
              } catch (e) {
                log("gerer-responsable-editResponsable-exception::${e.toString()}");
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("quelque chose ne va pas"),
                      backgroundColor: Colors.red),
                );
              }
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
      Future.delayed(const Duration(seconds: 0))
          .then((value) => setState(() {}));
    });
  }

  addResponsable() async {
    responsable?.nom = nomController.text;
    responsable?.prenom = prenomController.text;
    responsable?.email = emailController.text;
    responsable?.motdepasse = motdepasseController.text;
    responsable?.tel = telController.text;
    responsable?.dateResponsabilite = dateResponsabiliteController.text;
    responsable?.departement = departementValue;
    departementValue = null;
    await ApiResponsable().addResponsable(responsable: responsable);

    getData();
  }

  editResponsable() async { 

    log("editStudent");
    editedResponsable?.nom = editNomController.text;
    editedResponsable?.prenom = editPrenomController.text;
      editedResponsable?.tel =  editTelephoneController.text ;  
    editedResponsable?.email = editEmailController.text;
    editedResponsable?.motdepasse = editMotDePasseController.text;  
    editedResponsable?.departement =
        editDepartementValue ?? editedResponsable?.departement;
     editDepartementValue = null; 
    await ApiResponsable()
        .updateResponsable(editedResponsable: editedResponsable)
        .then((value) => log("updateEtudiants::$value"));

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
