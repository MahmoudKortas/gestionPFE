import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/color_hex.dart';
import 'package:gestion_pfe/src/icon_widget.dart';
import 'package:gestion_pfe/src/models/etudiant.dart';
import 'package:gestion_pfe/src/screens/etudiant/consulter_note.dart';
import 'package:gestion_pfe/src/screens/etudiant/enquete_satisfaction.dart';
import 'package:gestion_pfe/src/screens/etudiant/reclamation.dart';

import '../../resize_widget.dart';
import '../calendar/events_example.dart';
import '../subjects/proposer_sujet.dart';
import '../etudiant/liste_des_sujets.dart';

// ignore: must_be_immutable
class AccueilEtudiant extends StatefulWidget {
  Etudiant? etudiant;
  AccueilEtudiant({Key? key,  this.etudiant}) : super(key: key);
  static const routeName = '/AccueilEtudiant';
  @override
  State<AccueilEtudiant> createState() => _AccueilEtudiantState();
}

class _AccueilEtudiantState extends State<AccueilEtudiant> {
  @override
  Widget build(BuildContext context) {
    log("id::${widget.etudiant}");
    return Scaffold(
      appBar: AppBar(
        title: Text('Bonjour ${widget.etudiant?.prenom} ${widget.etudiant?.nom}'),
      ),
      body: SingleChildScrollView(
        // controller: controller,
        child: Center(
          child: resiseWidget(
            context: context,
            child: Column(
              children: [
                Card(
                  child: ListTile(
                    leading: iconWidget(Icons.add_chart),
                    title: const Text('Proposer votre sujet'),
                    /*subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),*/
                    trailing: const Icon(Icons.more_vert),
                    // isThreeLine: true,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        ProposerSujet.routeName,
                        arguments: ProposerSujet(
                          fonction: 'Etudiant',
                          etudiant: widget.etudiant,
                        ),
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: iconWidget(Icons.offline_pin),
                    title: const Text('Choisir sujet'),
                    /*subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),*/
                    trailing: const Icon(Icons.more_vert),
                    onTap: () {
                      Navigator.restorablePushNamed(
                        context,
                        ListeDesSujets.routeName,
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: iconWidget(Icons.offline_pin),
                    title: const Text('Choisir encadrant'),
                    /*subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),*/
                    trailing: const Icon(Icons.more_vert),
                    onTap: () {
                      // Navigator.restorablePushNamed(
                      //   context,
                      //   ListeDesSujets.routeName,
                      // );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: iconWidget(Icons.calendar_month),
                    title: const Text('Consulter le planning du PFE'),
                    /*subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),*/
                    trailing: const Icon(Icons.more_vert),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TableEventsExample(
                            fonction: 'etudiant',
                          ),
                        ),
                      );
                      /*Navigator.restorablePushNamed(
                        context,
                        ConsulterPlanning.routeName,
                      );*/
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: iconWidget(Icons.offline_pin),
                    title: const Text('consulter résultat'),
                    /*subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),*/
                    trailing: const Icon(Icons.more_vert),
                    onTap: () {
                      // Navigate to the details page. If the user leaves and returns to
                      // the app after it has ben killed while running in the
                      // background, the navigation stack is restored.
                      Navigator.restorablePushNamed(
                        context,
                        ConsulterNote.routeName,
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: iconWidget(Icons.offline_pin),
                    title: const Text('satisfaction'),
                    /*subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),*/
                    trailing: const Icon(Icons.more_vert),
                    onTap: () {
                      // Navigate to the details page. If the user leaves and returns to
                      // the app after it has ben killed while running in the
                      // background, the navigation stack is restored.
                      Navigator.restorablePushNamed(
                        context,
                        EnqueteSatisfaction.routeName,
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: iconWidget(Icons.offline_pin),
                    title: const Text('Réclamation'),
                    /*subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),*/
                    trailing: const Icon(Icons.more_vert),
                    onTap: () {
                      // Navigate to the details page. If the user leaves and returns to
                      // the app after it has ben killed while running in the
                      // background, the navigation stack is restored.
                      Navigator.restorablePushNamed(
                        context,
                        Reclamation.routeName,
                      );
                    },
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
