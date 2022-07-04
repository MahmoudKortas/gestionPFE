// ignore: file_names
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/screens/authentification/inscription.dart';
import 'package:gestion_pfe/src/screens/accueil/accueil.dart';

import '../../color_hex.dart';
import '../../resize_widget.dart';
import '../../size_config.dart';

/// Displays detailed information about a SampleItem.
class Authentification extends StatefulWidget {
  Authentification({Key? key}) : super(key: key);

  static const routeName = '/Authentification';
  @override
  State<Authentification> createState() => _AuthentificationState();
}

class _AuthentificationState extends State<Authentification> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final motDePasseController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    motDePasseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("S'authentifier"),
      ),
      body: SingleChildScrollView(
        // controller: controller,
        child: Center(
          child: resiseWidget(
            context: context,
            child: Column(
              children: [
                Image.asset(
                  "assets/images/logo-epi.png",
                  scale: 3,
                ),
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
                          hintText: 'Saisir votre e-mail',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'entrez votre login';
                          }
                          return null;
                        },
                        controller: emailController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: 'Saisir votre mot de passe',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'entrez votre mot de passe';
                          }
                          return null;
                        },
                        controller: motDePasseController,
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
                              Accueil.routeName,
                            );
                          },
                          child: const Text('Connexion'),
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          "Inscription",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationThickness: 1.5,
                            color: HexColor("c9242e"),
                            fontSize: 20,
                          ),
                        ),
                        onTap: () {
                          log("${emailController.text} ${motDePasseController.text} ");
                          Navigator.restorablePushNamed(
                            context,
                            Inscription.routeName,
                          );
                        },
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
}
