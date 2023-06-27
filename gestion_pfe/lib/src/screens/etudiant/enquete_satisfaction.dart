import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/helpers/departement_api.dart';
import 'package:gestion_pfe/src/helpers/encadrant_api.dart';
import 'package:gestion_pfe/src/helpers/etudiant_api.dart';
import 'package:gestion_pfe/src/helpers/specialite_api.dart';
import 'package:gestion_pfe/src/models/departement.dart';
import 'package:gestion_pfe/src/models/specialite.dart';
import '../../description.dart';
import '../../resize_widget.dart';

/// Displays detailed information about a SampleItem.
class EnqueteSatisfaction extends StatefulWidget {
  const EnqueteSatisfaction({Key? key}) : super(key: key);
  static const routeName = '/enqueteSatisfaction';
  @override
  State<EnqueteSatisfaction> createState() => _EnqueteSatisfactionState();
}

class _EnqueteSatisfactionState extends State<EnqueteSatisfaction> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Description? _description;
  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final telephoneController = TextEditingController();
  final emailController = TextEditingController();
  final avisController = TextEditingController();

  String? niveauValue;
  // final _items = ['Informatique', 'Mecanique', 'Electrique', 'Genie civile'];
  final _niveauItems = [
    'Licence',
    'Ingenieurie',
    'Mastère',
  ];
  List<Specialite?>? _specialite;
  Specialite? specialiteValue;

  List<Departement?>? _departement;
  Departement? departementValue;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nomController.dispose();
    prenomController.dispose();
    telephoneController.dispose();
    emailController.dispose();
    avisController.dispose();

    /*domaineController.dispose();
    diplomeController.dispose();
    departementController.dispose();
    niveauController.dispose();
    specialiteController.dispose();*/
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Votre satisfaction"),
      ),
      body: SingleChildScrollView(
        // controller: controller,
        child: Center(
          child: resiseWidget(
            context: context,
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: 'Saisir votre nom',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Entrez votre nom';
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
                          hintText: 'Saisir votre prenom',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Entrez votre prenom';
                          }
                          return null;
                        },
                        controller: prenomController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          hintText: 'Saisir votre telephone',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Entrez votre telephone';
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
                          prefixIcon: Icon(Icons.email),
                          hintText: 'Saisir votre email',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Entrez votre email';
                          }
                          return null;
                        },
                        controller: emailController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _departement != null
                          ? DropdownButton(
                              value: departementValue,
                              iconSize: 36,
                              hint: const Text("choisir ta departement"),
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
                      DropdownButton<String>(
                        hint: const Text("choisir votre niveau"),
                        value: niveauValue,
                        iconSize: 36,
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.black),
                        items: _niveauItems.map(buildMenuItem).toList(),
                        onChanged: (value) =>
                            setState(() => niveauValue = value),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      _specialite != null
                          ? DropdownButton(
                              value: specialiteValue,
                              iconSize: 36,
                              hint: const Text("choisir ta specialite"),
                              items: _specialite?.map((item) {
                                return DropdownMenuItem<Specialite>(
                                  value: item,
                                  child: Text(item!.nom!),
                                );
                              }).toList(),
                              onChanged: (newVal) {
                                log("newVal::$newVal");
                                setState(() {
                                  specialiteValue = newVal as Specialite?;
                                });
                              },
                            )
                          : Container(),
                      TextFormField(
                        minLines: 1, // Set this
                        maxLines: 6,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.edit),
                          hintText: 'Saisir votre avis',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Entrez votre avis';
                          }
                          return null;
                        },
                        controller: avisController,
                      ),
                      /*Column(
                        children: <Widget>[
                          ListTile(
                            title: const Text('Encadrant'),
                            leading: Radio(
                              value: Description.encadrant,
                              groupValue: _description,
                              onChanged: (Description? value) {
                                radiochange(value);
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('Etudiant'),
                            leading: Radio(
                              value: Description.etudiant,
                              groupValue: _description,
                              onChanged: (Description? value) {
                                radiochange(value);
                              },
                            ),
                          ),
                        ],
                      ),*/
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            log("${nomController.text} ${prenomController.text} ${telephoneController.text} ${emailController.text} ${avisController.text} ${_description.toString()}");
                            /*_description.toString().contains("encadrant")
                                ? addEncadrant(
                                    nom: nomController.text,
                                    prenom: prenomController.text,
                                    telephone: telephoneController.text,
                                    adresse: adresseController.text,
                                    email: emailController.text,
                                    motDePasse: motDePasseController.text,
                                    domaine: domaineValue)
                                : _description.toString().contains("etudiant")
                                    ? addStudent(
                                        nom: nomController.text,
                                        prenom: prenomController.text,
                                        telephone: telephoneController.text,
                                        adresse: adresseController.text,
                                        email: emailController.text,
                                        motDePasse: motDePasseController.text,
                                        diplome: diplomeValue,
                                        departement: departementValue,
                                        niveau: niveauValue,
                                        specialite: specialiteValue)
                                    : log("select function");*/
                            // Validate will return true if the form is valid, or false if
                            // the form is invalid.
                            /*if (_formKey.currentState!.validate()) {
                          // Process data.
                        }*/
                            /*Navigator.restorablePushNamed(
                                context, Authentification.routeName);*/

                            //
                          },
                          child: const Text("Submit"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*void getData() async {
    //await ApiService().updateEtudiants("3");
    //await ApiService().deleteEtudiants("17");
    _etudiant = await ApiService().getEtudiants();
    _encadrant = await ApiService().getEncadrant();
    log("_etudiant::$_etudiant");
    log("_encadrant::$_encadrant");
  }*/

  void addStudent({
    String? nom = "",
    String? prenom = "",
    String? telephone = "",
    String? adresse = "",
    String? email = "",
    String? motDePasse = "",
    String? departement = "",
    String? niveau = "",
    String? specialite = "",
  }) async {
    log("addStudent");
    await ApiEtudiant().addEtudiants(
        // nom: nom,
        // prenom: prenom,
        // telephone: telephone,
        // adresse: adresse,
        // email: email,
        // motDePasse: motDePasse,
        // departement: departement,
        // niveau: niveau,
        // specialite: specialite
        );
  }

 

  void radiochange(Description? value) {
    setState(() {
      _description = value!;
    });
    /*if (kDebugMode) {
      print("_description::$_description");
      print("value::$value");
    }*/
  }

  // DropdownMenuItem
  void getData() async {
    await Future.wait([
      ApiDepartement().getAllDepartements(),
      ApiSpecialite().getAllSpecialites(),
    ]).then((value) async {
      log("get");
      _departement = value[0]?.cast<Departement>();
      _specialite = value[1]?.cast<Specialite>();
      log("_departement::$_departement");
      log("_specialite::$_specialite");
      Future.delayed(const Duration(seconds: 0))
          .then((value) => setState(() {}));
    });
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ), // Text
      ); // DropdownMenuItem

}
