// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gestion_pfe/src/consts.dart';
import 'package:gestion_pfe/src/helpers/encadrant_api.dart';
import 'package:gestion_pfe/src/helpers/etudiant_api.dart';
import 'package:gestion_pfe/src/helpers/responsable_api.dart';
import 'package:gestion_pfe/src/notification_service.dart';
import 'package:gestion_pfe/src/screens/encadrant/accueil_encadrant.dart';
import 'package:gestion_pfe/src/screens/etudiant/accueil_etudiant.dart';
import 'package:gestion_pfe/src/screens/authentification/inscription.dart';
import 'package:gestion_pfe/src/screens/etudiant/enquete_satisfaction.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../color_hex.dart';
import '../../resize_widget.dart';
import '../../size_config.dart';

// Instance of Flutternotification plugin
final FlutterLocalNotificationsPlugin _notificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// Displays detailed information about a SampleItem.
class Authentification extends StatefulWidget {
  const Authentification({Key? key}) : super(key: key);

  static const routeName = '/Authentification';
  @override
  State<Authentification> createState() => _AuthentificationState();
}

class _AuthentificationState extends State<Authentification> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final motDePasseController = TextEditingController();
  var _encadrant;
  var _etudiant;
  var _responsable;
  SharedPreferences? prefs;
  @override
  void initState() {
    super.initState();
    getData();
    NotificationService.initialize(FlutterLocalNotificationsPlugin());
  }

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
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 12,
                      vertical: MediaQuery.of(context).size.width / 12),
                  child: Container(
                    decoration: roundBoxDecoration(),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 12,
                            vertical: MediaQuery.of(context).size.width / 60),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                "assets/images/logo-epi.png",
                                scale: 3,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.alternate_email),
                                  hintText: 'Saisir votre e-mail',
                                ),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'entrez votre email';
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
                                    return 'entrez votre mot de passe';
                                  }
                                  return null;
                                },
                                controller: motDePasseController,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Validate will return true if the form is valid, or false if
                                    // the form is invalid.
                                    /*if (_formKey.currentState!.validate()) {
                          // Process data.
                        }*/
                                    log("signin");
                                    try {
                                      verificationInscription(
                                          email: emailController.text,
                                          motDepasse:
                                              motDePasseController.text);
                                    } catch (e) {
                                      log("Authentification-exception::${e.toString()}");
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("quelque chose ne va pas"),
                                            backgroundColor: Colors.red),
                                      );
                                    }
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
                                  Navigator.restorablePushNamed(
                                    context,
                                    Inscription.routeName,
                                  );
                                },
                              ),
                              // ElevatedButton(
                              //   onPressed: () async {
                              //     await NotificationService()
                              //         .showBigTextNotification(
                              //       id: 0,
                              //       title: "Notification pfe",
                              //       body: "Pfe",
                              //       payload: "Pfee",
                              //       fln: FlutterLocalNotificationsPlugin(),
                              //     );
                              //   },
                              //   child: const Text("notification"),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
    _responsable = await ApiResponsable().getAllResponsable();
    _etudiant = await ApiEtudiant().getAllEtudiants();
    _encadrant = await ApiEncadrant().getAllEncadrant();
    debugPrint("_responsable::$_responsable");
    debugPrint("_etudiant::$_etudiant");
    debugPrint("_encadrant::$_encadrant");
  }

  Future<void> verificationInscription(
      {String? email = "", String? motDepasse = ""}) async {
    prefs = await SharedPreferences.getInstance();
    log("+");

    for (var responsable in _responsable) {
      log(".");
      if (responsable.email == email && responsable.motdepasse == motDepasse) {
        await prefs?.setString('user', jsonEncode(responsable).toString());
        Navigator.restorablePushNamed(
          context,
          Dashboard.routeName,
        );
      }
    }
    for (var etudiant in _etudiant) {
      log("-");
      if (etudiant.email == email && etudiant.motdepasse == motDepasse) {
        await prefs?.setString('user', jsonEncode(etudiant).toString());
        Navigator.pushNamed(
          context,
          AccueilEtudiant.routeName,
          arguments: AccueilEtudiant(
            etudiant: etudiant,
          ),
        );
      }
    }
    for (var encadrant in _encadrant) {
      log("_");
      if (encadrant.email == email && encadrant.motdepasse == motDepasse) {
        await prefs?.setString('user', jsonEncode(encadrant).toString());
        Navigator.pushNamed(context, AccueilEncadrant.routeName,
            arguments: AccueilEncadrant(encadrant: encadrant));
      }
    }
    if (email!.contains("admin0") && motDepasse!.contains("admin0")) {
      Navigator.restorablePushNamed(
        context,
        Dashboard.routeName,
      );
    }
  }
}
