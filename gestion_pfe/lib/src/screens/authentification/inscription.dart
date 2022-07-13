import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/models/document.dart';
import 'package:gestion_pfe/src/models/pfe.dart';
import 'package:gestion_pfe/src/models/soutenance.dart';

import '../../description.dart';
import '../../helpers/api_service.dart';
import '../../resize_widget.dart';

/// Displays detailed information about a SampleItem.
class Inscription extends StatefulWidget {
  const Inscription({Key? key}) : super(key: key);
  static const routeName = '/inscription';
  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _items = ['Informatique', 'Mecanique', 'Electrique', 'Genie civile'];
  final _niveauItems = [
    'Licence',
    'Ingenieurie',
    'Mastère',
  ];
  String? domaineValue;
  String? diplomeValue;
  String? departementValue;
  String? niveauValue;
  String? specialiteValue;

  Description? _description;
  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final telephoneController = TextEditingController();
  final adresseController = TextEditingController();
  final emailController = TextEditingController();
  final motDePasseController = TextEditingController();

  /*final domaineController = TextEditingController();
  final diplomeController = TextEditingController();
  final departementController = TextEditingController();
  final niveauController = TextEditingController();
  final specialiteController = TextEditingController();*/
  List<PFE>? _pfe = [];
  List<Document>? _document = [];
  List<Soutenance>? _soutenance = [];

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
    adresseController.dispose();
    emailController.dispose();
    motDePasseController.dispose();

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
        title: const Text("S'inscrire"),
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
                          prefixIcon: Icon(Icons.location_city),
                          hintText: 'Saisir votre adresse',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Entrez votre adresse';
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
                      TextFormField(
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: 'Saisir votre mot de passe',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Entrez votre mot de passe';
                          }
                          return null;
                        },
                        controller: motDePasseController,
                      ),
                      Column(
                        children: <Widget>[
                          ListTile(
                            title: const Text('Enseignant'),
                            leading: Radio(
                              value: Description.enseignant,
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
                      ),
                      _description.toString().contains("enseignant")
                          ? DropdownButton<String>(
                              hint: const Text("choisir votre domaine"),
                              value: domaineValue,
                              iconSize: 36,
                              icon: const Icon(Icons.arrow_drop_down,
                                  color: Colors.black),
                              items: _items.map(buildMenuItem).toList(),
                              onChanged: (value) =>
                                  setState(() => domaineValue = value),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                            )
                          : _description.toString().contains("etudiant")
                              ? Column(
                                  children: [
                                    DropdownButton<String>(
                                      hint: const Text("choisir votre diplome"),
                                      value: diplomeValue,
                                      iconSize: 36,
                                      icon: const Icon(Icons.arrow_drop_down,
                                          color: Colors.black),
                                      items: _items.map(buildMenuItem).toList(),
                                      onChanged: (value) =>
                                          setState(() => diplomeValue = value),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    DropdownButton<String>(
                                      hint: const Text(
                                          "choisir votre departement"),
                                      value: departementValue,
                                      iconSize: 36,
                                      icon: const Icon(Icons.arrow_drop_down,
                                          color: Colors.black),
                                      items: _items.map(buildMenuItem).toList(),
                                      onChanged: (value) => setState(
                                          () => departementValue = value),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    DropdownButton<String>(
                                      hint: const Text("choisir votre niveau"),
                                      value: niveauValue,
                                      iconSize: 36,
                                      icon: const Icon(Icons.arrow_drop_down,
                                          color: Colors.black),
                                      items: _niveauItems
                                          .map(buildMenuItem)
                                          .toList(),
                                      onChanged: (value) =>
                                          setState(() => niveauValue = value),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    DropdownButton<String>(
                                      hint: const Text(
                                          "choisir votre specialité"),
                                      value: specialiteValue,
                                      iconSize: 36,
                                      icon: const Icon(Icons.arrow_drop_down,
                                          color: Colors.black),
                                      items: _items.map(buildMenuItem).toList(),
                                      onChanged: (value) => setState(
                                          () => specialiteValue = value),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                  ],
                                )
                              : Container(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            log("${nomController.text} ${prenomController.text} ${telephoneController.text} ${adresseController.text} ${emailController.text} ${motDePasseController.text} ${_description.toString()} $domaineValue $diplomeValue $departementValue $niveauValue $specialiteValue");
                            _description.toString().contains("enseignant")
                                ? addEnseignant(
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
                                    : log("select function");
                            // Validate will return true if the form is valid, or false if
                            // the form is invalid.
                            /*if (_formKey.currentState!.validate()) {
                          // Process data.
                        }*/
                            /*Navigator.restorablePushNamed(
                                context, Authentification.routeName);*/

                            //
                          },
                          child: const Text("S'inscrire"),
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

  void getData() async {
    _pfe = await ApiService().getPFE();
    _document = await ApiService().getDocument();
    _soutenance = await ApiService().getSoutenance();
    log("_soutenance::$_soutenance");
    log("pfe::$_pfe");
    log("_document::$_document");
  }
  /*void getData() async {
    //await ApiService().updateEtudiants("3");
    //await ApiService().deleteEtudiants("17");
    _etudiant = await ApiService().getEtudiants();
    _enseignant = await ApiService().getEnseignant();
    log("_etudiant::$_etudiant");
    log("_enseignant::$_enseignant");
  }*/

  void addStudent({
    String? nom = "",
    String? prenom = "",
    String? telephone = "",
    String? adresse = "",
    String? email = "",
    String? motDePasse = "",
    String? diplome = "",
    String? departement = "",
    String? niveau = "",
    String? specialite = "",
  }) async {
    log("addStudent");
    await ApiService().addEtudiants(
        nom: nom,
        prenom: prenom,
        telephone: telephone,
        adresse: adresse,
        email: email,
        motDePasse: motDePasse,
        diplome: diplome,
        departement: departement,
        niveau: niveau,
        specialite: specialite);
  }

  void addEnseignant({
    String? nom = "",
    String? prenom = "",
    String? telephone = "",
    String? adresse = "",
    String? email = "",
    String? motDePasse = "",
    String? domaine = "",
  }) async {
    log("addEnseignant");
    await ApiService().addEnseignant(
        nom: nom,
        prenom: prenom,
        telephone: telephone,
        adresse: adresse,
        email: email,
        motDePasse: motDePasse,
        domaine: domaine);
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

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ), // Text
      ); // DropdownMenuItem
}
