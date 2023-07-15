import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/helpers/document_api.dart';
import 'package:gestion_pfe/src/models/document.dart';
import 'package:gestion_pfe/src/models/sujet.dart';
import '../../resize_widget.dart';
import '../subjects/detail_sujet.dart';

/// Displays detailed information about a SampleItem.
class TraiterDemande extends StatefulWidget {
  const TraiterDemande({Key? key}) : super(key: key);

  static const routeName = '/TraiterDemande';
  @override
  State<TraiterDemande> createState() => _TraiterDemandeState();
}

class _TraiterDemandeState extends State<TraiterDemande> {
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // ignore: prefer_typing_uninitialized_variables
  var _sujet;
  Document? doc;
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('traiter demandes'),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        // controller: controller,
        child: Center(
          child: resiseWidget(
            context: context,
            child: Column(
              children: [
                Card(
                  child: ListTile(
                      title: const Text("Demande 1"),
                      subtitle: const Text("description Demande 1"),
                      trailing: const Icon(Icons.more_vert),
                      // isThreeLine: true,
                      onTap: () => dialog(context, Sujet())
                      // dialog(
                      //                   context, _ligneSoutenance![index])
                      // {
                      // Navigator.pushNamed(
                      //   context,
                      //   DetailSujet.routeName,
                      //   arguments: DetailSujet(
                      //     sujet: Document(),
                      //     fonction: "etudiant",
                      //   ),
                      // );
                      // },
                      ),
                ),
                _sujet == null || _sujet.isEmpty
                    ? const Text("aucun sujet existe")
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _sujet!.length,
                        itemBuilder: (context, index) {
                          log(_sujet[index].titre.toString());
                          return Card(
                            child: ListTile(
                                title: Text(_sujet[index].titre.toString()),
                                subtitle:
                                    Text(_sujet[index].description.toString()),
                                trailing: const Icon(Icons.more_vert),
                                // isThreeLine: true,
                                onTap: () => dialog(context, _sujet[index])
                                // {
                                //   Navigator.pushNamed(
                                //     context,
                                //     DetailSujet.routeName,
                                //     arguments: DetailSujet(
                                //       sujet: _sujet[index],
                                //       fonction: "etudiant",
                                //     ),
                                //   );
                                // },
                                ),
                          );
                        },
                      )
                /* Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text('sujet 1'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () {
                      Navigator.pushNamed(context, DetailSujet.routeName,
                          arguments: DetailSujet(
                            fonction: "etudiant",
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
                    title: const Text('sujet 2'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () {
                      Navigator.pushNamed(context, DetailSujet.routeName,
                          arguments: DetailSujet(
                            fonction: "etudiant",
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
                    title: const Text('sujet 3'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () {
                      Navigator.pushNamed(context, DetailSujet.routeName,
                          arguments: DetailSujet(
                            fonction: "etudiant",
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
                    title: const Text('sujet 4'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () {
                      Navigator.pushNamed(context, DetailSujet.routeName,
                          arguments: DetailSujet(
                            fonction: "etudiant",
                          ));
                    },
                  ),
                ),
             */
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> dialog(BuildContext context, Sujet? sujet) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Traiter demande'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Titre sujet: ${sujet?.titre ?? "titre sujet 1"}"),
              Text(
                  "Description sujet: ${sujet?.description ?? "description sujet 1"}"),
              // Text("Email sujet: ${sujet?.}"),
              // Text("département sujet: ${sujet?.departement?.nom}"),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'valider'),
            child: const Text('valider'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'invalider'),
            child: const Text('invalider'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'Annuler'),
            child: const Text('Annuler'),
          ),
        ],
      ),
    );
  }

  void getData() async {
    _sujet = await ApiDocument().getDocument();
    log("_sujet::$_sujet");
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }
}
