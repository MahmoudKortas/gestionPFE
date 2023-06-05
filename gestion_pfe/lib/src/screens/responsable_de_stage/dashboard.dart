import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/gerer_departement.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/gerer_document.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/gerer_role.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/gerer_seance.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/gerer_soutenance.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/gerer_specialite.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/gerer_sujets_pfe.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/gerer_etudiant.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/gerer_enseignants.dart';

import '../../resize_widget.dart';
import '../calendar/events_example.dart';
import 'gerer_responsable.dart';
import 'gerer_salle.dart';

/// Displays detailed information about a SampleItem.
class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  static const routeName = '/Dashboard';
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tableau de bord'),
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
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text(' sujet PFE'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () {
                      // Navigate to the details page. If the user leaves and returns to
                      // the app after it has been killed while running in the
                      // background, the navigation stack is restored.
                      Navigator.restorablePushNamed(
                        context,
                        GererSujetsPFE.routeName,
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text(' document'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () {
                      // Navigate to the details page. If the user leaves and returns to
                      // the app after it has been killed while running in the
                      // background, the navigation stack is restored.
                      Navigator.restorablePushNamed(
                        context,
                        GererDocument.routeName,
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text(' enseignant'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () {
                      // Navigate to the details page. If the user leaves and returns to
                      // the app after it has been killed while running in the
                      // background, the navigation stack is restored.
                      Navigator.restorablePushNamed(
                        context,
                        GererEnseignant.routeName,
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text(' soutenances'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () {
                      // Navigate to the details page. If the user leaves and returns to
                      // the app after it has been killed while running in the
                      // background, the navigation stack is restored.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TableEventsExample(
                            fonction: 'admin',
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text(' étudiants'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () {
                      // Navigate to the details page. If the user leaves and returns to
                      // the app after it has been killed while running in the
                      // background, the navigation stack is restored.
                      Navigator.restorablePushNamed(
                        context,
                        GererEtudiant.routeName,
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text(' seance'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () {
                      // Navigate to the details page. If the user leaves and returns to
                      // the app after it has been killed while running in the
                      // background, the navigation stack is restored.
                      Navigator.restorablePushNamed(
                        context,
                        GererSeance.routeName,
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text(' salle'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () {
                      // Navigate to the details page. If the user leaves and returns to
                      // the app after it has been killed while running in the
                      // background, the navigation stack is restored.
                      Navigator.restorablePushNamed(
                        context,
                        GererSalle.routeName,
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text(' departement'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () {
                      // Navigate to the details page. If the user leaves and returns to
                      // the app after it has been killed while running in the
                      // background, the navigation stack is restored.
                      Navigator.restorablePushNamed(
                        context,
                        GererDepartement.routeName,
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text(' role'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () {
                      // Navigate to the details page. If the user leaves and returns to
                      // the app after it has been killed while running in the
                      // background, the navigation stack is restored.
                      Navigator.restorablePushNamed(
                        context,
                        GererRole.routeName,
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text(' specialite'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () {
                      // Navigate to the details page. If the user leaves and returns to
                      // the app after it has been killed while running in the
                      // background, the navigation stack is restored.
                      Navigator.restorablePushNamed(
                        context,
                        GererSpecialite.routeName,
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text(' responsable'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () {
                      // Navigate to the details page. If the user leaves and returns to
                      // the app after it has been killed while running in the
                      // background, the navigation stack is restored.
                      Navigator.restorablePushNamed(
                        context,
                        GererResponsable.routeName,
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text(' soutenances'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () {
                      // Navigate to the details page. If the user leaves and returns to
                      // the app after it has been killed while running in the
                      // background, the navigation stack is restored.
                      Navigator.restorablePushNamed(
                        context,
                        GererSoutenance.routeName,
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
