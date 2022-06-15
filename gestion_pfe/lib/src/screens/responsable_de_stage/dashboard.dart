import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/document.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/juries_list.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/pfe_subject.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/result.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/students.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/gerer_enseignants.dart';

import '../../resize_widget.dart';
import '../calendar/events_example.dart';

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
                    leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),
                    title: const Text('Gèrer résultat'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () {
                      Navigator.restorablePushNamed(
                        context,
                        Result.routeName,
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),
                    title: const Text('Gèrer sujet PFE'),
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
                        PFESubject.routeName,
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),
                    title: const Text('Gèrer document'),
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
                        Document.routeName,
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),
                    title: const Text('Gèrer enseignant'),
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
                    leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),
                    title: const Text('Gèrer soutenances'),
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
                            builder: (_) => const TableEventsExample()),
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),
                    title: const Text('Gèrer étudiants'),
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
                        Students.routeName,
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),
                    title: const Text('Gèrer liste de jury'),
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
                        JuriesList.routeName,
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
