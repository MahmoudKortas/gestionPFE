import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/entites/description.dart';
import 'package:gestion_pfe/src/screens/authentification/authentification.dart';

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
  final _items = [
    'informatique',
    'mecanique',
    'electrique',
    'genie civile',
    'langues',
    'mathematique'
  ];
  String? value;

  Description? _description;

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
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: 'Saisir votre password',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Entrez votre password';
                          }
                          return null;
                        },
                      ),
                      DropdownButton<String>(
                        hint: const Text("choisir votre domaine"),
                        value: value,
                        iconSize: 36,
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.black),
                        items: _items.map(buildMenuItem).toList(),
                        onChanged: (value) =>
                            setState(() => this.value = value),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      DropdownButton<String>(
                        hint: const Text("choisir votre diplome"),
                        value: value,
                        iconSize: 36,
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.black),
                        items: _items.map(buildMenuItem).toList(),
                        onChanged: (value) =>
                            setState(() => this.value = value),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      DropdownButton<String>(
                        hint: const Text("choisir votre departement"),
                        value: value,
                        iconSize: 36,
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.black),
                        items: _items.map(buildMenuItem).toList(),
                        onChanged: (value) =>
                            setState(() => this.value = value),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      DropdownButton<String>(
                        hint: const Text("choisir votre niveau"),
                        value: value,
                        iconSize: 36,
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.black),
                        items: _items.map(buildMenuItem).toList(),
                        onChanged: (value) =>
                            setState(() => this.value = value),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      DropdownButton<String>(
                        hint: const Text("choisir votre specialité"),
                        value: value,
                        iconSize: 36,
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.black),
                        items: _items.map(buildMenuItem).toList(),
                        onChanged: (value) =>
                            setState(() => this.value = value),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      Column(
                        //TODO: center attributes
                        children: <Widget>[
                          ListTile(
                            title: const Text('Enseignant'),
                            leading: Radio(
                              value: Description.enseignant,
                              groupValue: _description,
                              onChanged: (Description? value) {
                                setState(() {
                                  _description = value!;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('Etudiant'),
                            leading: Radio(
                              value: Description.etudiant,
                              groupValue: _description,
                              onChanged: (Description? value) {
                                setState(() {
                                  _description = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // Validate will return true if the form is valid, or false if
                            // the form is invalid.
                            /*if (_formKey.currentState!.validate()) {
                          // Process data.
                        }*/
                            Navigator.restorablePushNamed(
                                context, Authentification.routeName);
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

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ), // Text
      ); // DropdownMenuItem
}
