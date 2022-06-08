import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/entites/description.dart';
import 'package:gestion_pfe/src/screens/authentification/sign_in.dart';

/// Displays detailed information about a SampleItem.
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  static const routeName = '/signUp';
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
        title: const Text('signIn'),
      ),
      body: SingleChildScrollView(
        // controller: controller,
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Saisir votre nom',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Saisir votre prenom',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Saisir votre telephone',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Saisir votre adresse',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Saisir votre email',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Saisir votre password',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Saisir votre role',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Saisir votre specialité',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Saisir votre specialité',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  Column(
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
                  DropdownButton<String>(
                    hint: const Text("choisir votre domaine"),
                    value: value,
                    iconSize: 36,
                    icon:
                        const Icon(Icons.arrow_drop_down, color: Colors.black),
                    items: _items.map(buildMenuItem).toList(),
                    onChanged: (value) => setState(() => this.value = value),
                     borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                          context,
                          SignIn.routeName,
                        );
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
