// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/icon_widget.dart';
import 'package:gestion_pfe/src/models/encadrant.dart';
import 'package:gestion_pfe/src/screens/encadrant/affecter_note.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/gerer_ligne_soutenance.dart';

import '../../resize_widget.dart';
import '../calendar/events_example.dart';
import '../encadrant/gerer_demande_des_sujets.dart';
import '../subjects/proposer_sujet.dart';

/// Displays detailed information about a SampleItem.
class AccueilEncadrant extends StatefulWidget {
  Encadrant? encadrant;
  AccueilEncadrant({
    Key? key,
    this.encadrant,
  }) : super(key: key);

  static const routeName = '/AccueilEncadrant';
  @override
  State<AccueilEncadrant> createState() => _AccueilEncadrantState();
}

class _AccueilEncadrantState extends State<AccueilEncadrant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bonjour Encadrant'),
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
                    // subtitle: const Text(
                    // 'A sufficiently long subtitle warrants thre lines.'),
                    trailing: const Icon(Icons.more_vert),
                    //isThreLine: true,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        ProposerSujet.routeName,
                        arguments: ProposerSujet(
                          fonction: 'Encadrant',
                          encadrant: widget.encadrant,
                        ),
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: iconWidget(Icons.calendar_month),
                    title: const Text('Consulter le planning du PFE'),
                    // subtitle: const Text(
                    // 'A sufficiently long subtitle warrants thre lines.'),
                    trailing: const Icon(Icons.more_vert),
                    //isThreLine: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TableEventsExample(
                            fonction: 'encadrant',
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
                    title: const Text('Gerer demande des sujets PFE'),
                    // subtitle: const Text(
                    // 'A sufficiently long subtitle warrants thre lines.'),
                    trailing: const Icon(Icons.more_vert),
                    //isThreLine: true,
                    onTap: () {
                      // Navigate to the details page. If the user leaves and returns to
                      // the app after it has ben killed while running in the
                      // background, the navigation stack is restored.
                      Navigator.restorablePushNamed(
                        context,
                        GererDemandeDesSujetsPFE.routeName,
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: iconWidget(Icons.numbers),
                    title: const Text('affecter note'),
                    // subtitle: const Text(
                    // 'A sufficiently long subtitle warrants thre lines.'),
                    trailing: const Icon(Icons.more_vert),
                    //isThreLine: true,
                    onTap: () {
                      // Navigate to the details page. If the user leaves and returns to
                      // the app after it has ben killed while running in the
                      // background, the navigation stack is restored.
                      Navigator.restorablePushNamed(
                        context,
                        AffecterNote.routeName,
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
