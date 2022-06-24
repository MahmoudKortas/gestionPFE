import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/screens/subjects/detail_sujet.dart';

import '../../resize_widget.dart';

/// Displays detailed information about a SampleItem.
class GererDemandeDesSujetsPFE extends StatelessWidget {
  const GererDemandeDesSujetsPFE({Key? key}) : super(key: key);

  static const routeName = '/GererDemandeDesSujetsPFE';
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gérer demandes des sujets des PFE'),
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
                    title: const Text('Sujet 1'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () {
                      Navigator.pushNamed(context, DetailSujet.routeName,
                          arguments: DetailSujet(
                            fonction: "enseignant",
                          ));
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text('Sujet 2'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () {
                      Navigator.pushNamed(context, DetailSujet.routeName,
                          arguments: DetailSujet(
                            fonction: "enseignant",
                          ));
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text('Sujet 3'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () {
                      Navigator.pushNamed(context, DetailSujet.routeName,
                          arguments: DetailSujet(
                            fonction: "enseignant",
                          ));
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text('Sujet 4'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () {
                      Navigator.pushNamed(context, DetailSujet.routeName,
                          arguments: DetailSujet(
                            fonction: "enseignant",
                          ));
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
