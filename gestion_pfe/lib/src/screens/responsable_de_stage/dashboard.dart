import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/icon_widget.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/chart.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/gerer_departement.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/gerer_document.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/gerer_ligne_soutenance.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/gerer_role.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/gerer_seance.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/gerer_soutenance.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/gerer_specialite.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/gerer_sujet.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/gerer_sujets_pfe.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/gerer_etudiant.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/gerer_encadrant.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/resultatPfe.dart';

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
                Image.asset(
                  "assets/images/logo-epi.png",
                  scale: 2,
                ),
                const SizedBox(
                  height: 30,
                ),
                Card(
                  child: ListTile(
                    leading: iconWidget(Icons.book), 
                    title: const Text('Gestion projet PFE'),
                    //subtitle: const Text(''),
                    trailing: const Icon(Icons.more_vert),
                    //isThreeLine: true,
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
                    leading: iconWidget(Icons.document_scanner), 
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text(' Gestion documents administratifs'),
                    //subtitle: const Text(''),
                    trailing: const Icon(Icons.more_vert),
                    //isThreeLine: true,
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
                /*Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text(' Sujets'),
                    //subtitle: const Text(''),
                    trailing: const Icon(Icons.more_vert),
                    //isThreeLine: true,
                    onTap: () {
                      // Navigate to the details page. If the user leaves and returns to
                      // the app after it has been killed while running in the
                      // background, the navigation stack is restored.
                      Navigator.restorablePushNamed(
                        context,
                        GererSujet.routeName,
                      );
                    },
                  ),
                ),*/
                Card(
                  child: ListTile(
                    leading: iconWidget(Icons.person), 
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text(' Gestion encadrant'),
                    //subtitle: const Text(''),
                    trailing: const Icon(Icons.more_vert),
                    //isThreeLine: true,
                    onTap: () {
                      // Navigate to the details page. If the user leaves and returns to
                      // the app after it has been killed while running in the
                      // background, the navigation stack is restored.
                      Navigator.restorablePushNamed(
                        context,
                        GererEncadrant.routeName,
                      );
                    },
                  ),
                ),
                //TODO: uncomment this
               /* Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text(' soutenances'),
                    //subtitle: const Text(''),
                    trailing: const Icon(Icons.more_vert),
                    //isThreeLine: true,
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
                ),*/
                Card(
                  child: ListTile(
                    leading: iconWidget(Icons.person), 
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text(' Gestion étudiants'),
                    //subtitle: const Text(''),
                    trailing: const Icon(Icons.more_vert),
                    //isThreeLine: true,
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
                /*Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text(' seance'),
                    //subtitle: const Text(''),
                    trailing: const Icon(Icons.more_vert),
                    //isThreeLine: true,
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
                ),*/
                /*Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text(' salle'),
                    //subtitle: const Text(''),
                    trailing: const Icon(Icons.more_vert),
                    //isThreeLine: true,
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
                ),*/
                /* Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text(' departement'),
                    //subtitle: const Text(''),
                    trailing: const Icon(Icons.more_vert),
                    //isThreeLine: true,
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
                ),*/
                /* Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text(' role'),
                    //subtitle: const Text(''),
                    trailing: const Icon(Icons.more_vert),
                    //isThreeLine: true,
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
                ),*/
                /*Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text(' specialite'),
                    //subtitle: const Text(''),
                    trailing: const Icon(Icons.more_vert),
                    //isThreeLine: true,
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
                ),*/
                /* Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text(' responsable'),
                    //subtitle: const Text(''),
                    trailing: const Icon(Icons.more_vert),
                    //isThreeLine: true,
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
                ),*/
                Card(
                  child: ListTile(
                    leading: iconWidget(Icons.present_to_all), 
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text(' Gestion soutenances'),
                    //subtitle: const Text(''),
                    trailing: const Icon(Icons.more_vert),
                    //isThreeLine: true,
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
                Card(
                  child: ListTile(
                    leading: iconWidget(Icons.present_to_all), 
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text(' Résultat PFE'), 
                    trailing: const Icon(Icons.more_vert),
                    //isThreeLine: true,
                    onTap: () {
                      // Navigate to the details page. If the user leaves and returns to
                      // the app after it has been killed while running in the
                      // background, the navigation stack is restored.
                      Navigator.restorablePushNamed(
                        context,
                        ResultatPfe.routeName,
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: iconWidget(Icons.insert_chart_outlined_outlined),  
                    title: const Text('Statistique'),
                    //subtitle: const Text(''),
                    trailing: const Icon(Icons.more_vert),
                    //isThreeLine: true,
                    onTap: () { 
                      Navigator.restorablePushNamed(
                        context,
                        Chart.routeName,
                      );
                    },
                  ),
                ),
                /*Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text(' Ligne soutenance'),
                    //subtitle: const Text(''),
                    trailing: const Icon(Icons.more_vert),
                    //isThreeLine: true,
                    onTap: () {
                      // Navigate to the details page. If the user leaves and returns to
                      // the app after it has been killed while running in the
                      // background, the navigation stack is restored.
                      Navigator.restorablePushNamed(
                        context,
                        GererLigneSoutenance.routeName,
                      );
                    },
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
