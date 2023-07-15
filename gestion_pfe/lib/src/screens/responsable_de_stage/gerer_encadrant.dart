import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/helpers/departement_api.dart';
import 'package:gestion_pfe/src/helpers/encadrant_api.dart';
import 'package:gestion_pfe/src/models/departement.dart';
import '../../models/encadrant.dart';
import '../../resize_widget.dart';
import 'package:flutter/services.dart';

class GererEncadrant extends StatefulWidget {
  const GererEncadrant({Key? key}) : super(key: key);
  static const routeName = '/GererEncadrant';
  @override
  State<GererEncadrant> createState() => _GererEncadrantState();
}

class _GererEncadrantState extends State<GererEncadrant> {
  late List<Encadrant>? _encadrant = [];
  final _domaineItems = [
    'informatique',
    'Mecanique',
    'electrique',
    'genie civile',
    'langues',
    'mathematique'
  ];
  String? domaineValue;
  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final telephoneController = TextEditingController();
  final adresseController = TextEditingController();
  final emailController = TextEditingController();
  final motDePasseController = TextEditingController();
  Encadrant? encadrant = Encadrant();
  List<Departement?>? _departement;
  Departement? departementValue;

  String? editDomaineValue;
  final editNomController = TextEditingController();
  final editPrenomController = TextEditingController();
  final editTelephoneController = TextEditingController();
  final editAdresseController = TextEditingController();
  final editEmailController = TextEditingController();
  final editMotDePasseController = TextEditingController();
  Encadrant? editedEncadrant = Encadrant();
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
    telephoneController.dispose();
    adresseController.dispose();
    emailController.dispose();
    motDePasseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' encadrants'),
      ),
      body: SingleChildScrollView(
        //  controller: controller,
        physics: const ScrollPhysics(),
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
                    prefixIcon: Icon(Icons.person),
                    hintText: "Saisir nom de l'encadrant",
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Entrez le nom de l'encadrant";
                    }
                    return null;
                  },
                  controller: nomController,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: "Prénom de l'encadrant",
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Entrez le prenom de l'encadrant";
                    }
                    return null;
                  },
                  controller: prenomController,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    hintText: "Numero du telephone de l'encadrant",
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Entrez le numero du telephone de l'encadrant";
                    }
                    return null;
                  },
                  controller: telephoneController,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.location_city),
                    hintText: "Adresse de l'encadrant",
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Entrez l'adresse de l'encadrant";
                    }
                    return null;
                  },
                  controller: adresseController,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: "Email de l'encadrant",
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Entrez l'email de l'encadrant";
                    }
                    return null;
                  },
                  controller: emailController,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: "Mot de passe de l'encadrant",
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Entrez le mot de passe de l'encadrant";
                    }
                    return null;
                  },
                  controller: motDePasseController,
                ),
                DropdownButton<String>(
                  hint: const Text("Domaine de l'encadrant"),
                  value: domaineValue,
                  iconSize: 36,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                  items: _domaineItems.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(() => domaineValue = value),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
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
                  // ignore: avoid_print
                  onPressed: () {
                    try {
                      addData();
                    } catch (e) {
                      log("gerer-encadrant-exception::${e.toString()}");
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("quelque chose ne va pas"),
                            backgroundColor: Colors.red),
                      );
                    }
                  },
                  child: const Text("Ajouter"),
                ),
                _encadrant!.isEmpty
                    ? const Text("aucun encadrant existe")
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _encadrant!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              /*leading: const CircleAvatar(
                                  foregroundImage:
                                  AssetImage('assets/images/flutter_logo.png'),
                                  ),*/
                              title: Text(
                                  "${_encadrant![index].prenom} ${_encadrant![index].nom}"),
                              subtitle:
                                  Text(_encadrant![index].adresse.toString()),
                              trailing: const Icon(Icons.more_vert),
                              isThreeLine: true,
                              onTap: () {
                                dialog(context, _encadrant![index]);
                              },
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> dialog(BuildContext context, Encadrant encadrant) {
    editedEncadrant = encadrant;
    editNomController.text = encadrant.nom ?? "";
    editPrenomController.text = encadrant.prenom ?? "";
    editTelephoneController.text = encadrant.tel.toString();
    editAdresseController.text = encadrant.adresse ?? "";
    editEmailController.text = encadrant.email ?? "";
    editMotDePasseController.text = encadrant.motdepasse ?? "";
    // editDomaineValue = encadrant.domaine;
    log("dialog_encadrant::$_encadrant");
    //log("$nomvalue $prenomvalue $telephonevalue $adressevalue $emailvalue $passwordvalue $domaineValue");
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Modifier / Supprimer Encadrant'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  hintText: encadrant.nom,
                ),
                validator: (nomvalue) {
                  if (nomvalue == null || nomvalue.isEmpty) {
                    return 'Entrez votre nom';
                  }
                  return null;
                },
                controller: editNomController,
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  hintText: encadrant.prenom,
                ),
                validator: (prenomvalue) {
                  if (prenomvalue == null || prenomvalue.isEmpty) {
                    return 'Entrez votre prenom';
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
                  hintText: encadrant.tel.toString(),
                ),
                validator: (telephonevalue) {
                  if (telephonevalue == null || telephonevalue.isEmpty) {
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
                  prefixIcon: const Icon(Icons.location_city),
                  hintText: encadrant.adresse,
                ),
                validator: (adressevalue) {
                  if (adressevalue == null || adressevalue.isEmpty) {
                    return 'Entrez votre adresse';
                  }
                  return null;
                },
                controller: editAdresseController,
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
                  hintText: encadrant.email,
                ),
                validator: (emailvalue) {
                  if (emailvalue == null || emailvalue.isEmpty) {
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
                  hintText: encadrant.motdepasse,
                ),
                validator: (passwordvalue) {
                  if (passwordvalue == null || passwordvalue.isEmpty) {
                    return 'Entrez votre password';
                  }
                  return null;
                },
                controller: editMotDePasseController,
              ),
              DropdownButton<String>(
                hint: const Text("choisir votre domaine"),
                value: editDomaineValue,
                iconSize: 36,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                items: _domaineItems.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() => editDomaineValue = value),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              _departement != null
                  ? DropdownButton(
                      value: editDepartementValue,
                      iconSize: 36,
                      hint: Text(encadrant.departement?.nom ??
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
              log("${editNomController.text} ${editPrenomController.text} ${editTelephoneController.text} ${editAdresseController.text} ${editEmailController.text} ${editMotDePasseController.text} $editDomaineValue");
              try {
                editEncadrant();
              } catch (e) {
                log("gerer-encadrant-editEncadrant-exception::${e.toString()}");
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
            onPressed: () {
              deleteEncadrant(id: encadrant.idEnc);
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
      ApiEncadrant().getAllEncadrant(),
      ApiDepartement().getAllDepartements(),
    ]).then((value) async {
      // log("get encadrant");
      _encadrant = value[0]?.cast<Encadrant>();
      _departement = value[1]?.cast<Departement>();
      // log("_encadrant::$_encadrant");
      // log("_departement::$_departement");
      Future.delayed(const Duration(seconds: 0))
          .then((value) => setState(() {}));
    });
  }

  void addData() async {
    log("addEncadrant");
    encadrant?.nom = nomController.text;
    encadrant?.prenom = prenomController.text;
    try {
      encadrant?.tel = int.parse(telephoneController.text);
    } catch (e) {
      log("encadrant?.tel-exception::$e");
    }

    encadrant?.adresse = adresseController.text;
    encadrant?.email = emailController.text;
    encadrant?.motdepasse = motDePasseController.text;
    encadrant?.domaine = domaineValue;
    encadrant?.departement = departementValue;

    log("${nomController.text} ${prenomController.text} ${telephoneController.text} ${adresseController.text} ${emailController.text} ${motDePasseController.text} $domaineValue $departementValue");
    departementValue = null;
    await ApiEncadrant().addEncadrant(
      encadrant: encadrant,
    );
    getData();
  }

  void editEncadrant() async {
    log("editEncadrant");
    editedEncadrant?.nom = editNomController.text;
    editedEncadrant?.prenom = editPrenomController.text;
    try {
      editedEncadrant?.tel = int.parse(telephoneController.text);
    } catch (e) {
      log("editedEncadrant?.tel-exception::$e");
    }

    editedEncadrant?.adresse = editAdresseController.text;
    editedEncadrant?.email = editEmailController.text;
    editedEncadrant?.motdepasse = editMotDePasseController.text;
    editedEncadrant?.domaine = editDomaineValue;
    editedEncadrant?.departement =
        editDepartementValue ?? editedEncadrant?.departement;
    log("editedEncadrant::$editedEncadrant");
    departementValue = null;
    editDomaineValue = null;
    await ApiEncadrant().editEncadrant(editedEncadrant: editedEncadrant);
    getData();
  }

  void deleteEncadrant({int? id}) async {
    log("deleteEncadrant");
    await ApiEncadrant().deleteEncadrant(id.toString());
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
