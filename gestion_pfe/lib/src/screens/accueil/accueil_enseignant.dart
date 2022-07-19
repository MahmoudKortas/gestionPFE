import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/icon_widget.dart';
import 'package:gestion_pfe/src/models/enseignant.dart';

import '../../resize_widget.dart';
import '../calendar/events_example.dart';
import '../enseignant/gerer_demande_des_sujets.dart';
import '../subjects/proposer_sujet.dart';

/// Displays detailed information about a SampleItem.
class AccueilEnseignant extends StatefulWidget {
  Enseignant enseignant;
  AccueilEnseignant({
    Key? key,
    required this.enseignant,
  }) : super(key: key);

  static const routeName = '/AccueilEnseignant';
   @override
  State<AccueilEnseignant> createState() => _AccueilEnseignantState();
}

class _AccueilEnseignantState extends State<AccueilEnseignant> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bonjour Enseignant'),
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
                    // 'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    //isThreeLine: true,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        ProposerSujet.routeName,
                        arguments: ProposerSujet(
                          fonction: 'Enseignant',
                          enseignant: widget.enseignant,
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
                    // 'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    //isThreeLine: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TableEventsExample(fonction: 'enseignant',),
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
                    // 'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    //isThreeLine: true,
                    onTap: () {
                      // Navigate to the details page. If the user leaves and returns to
                      // the app after it has been killed while running in the
                      // background, the navigation stack is restored.
                      Navigator.restorablePushNamed(
                        context,
                        GererDemandeDesSujetsPFE.routeName,
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
