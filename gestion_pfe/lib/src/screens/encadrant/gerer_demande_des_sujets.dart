import 'dart:developer'; 
import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/helpers/document_api.dart';
import 'package:gestion_pfe/src/screens/subjects/detail_sujet.dart'; 
import '../../resize_widget.dart';

/// Displays detailed information about a SampleItem.
class GererDemandeDesSujetsPFE extends StatefulWidget {
  const GererDemandeDesSujetsPFE({Key? key}) : super(key: key);

  static const routeName = '/GererDemandeDesSujetsPFE';
  @override
  State<GererDemandeDesSujetsPFE> createState() =>
      _GererDemandeDesSujetsPFEState();
}

class _GererDemandeDesSujetsPFEState extends State<GererDemandeDesSujetsPFE> {
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // ignore: prefer_typing_uninitialized_variables
  var _document;
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' demandes des sujets des PFE'),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        // controller: controller,
        child: Center(
          child: resiseWidget(
            context: context,
            child: Column(
              children: [
                _document == null || _document.isEmpty
                    ? const Text("aucun document existe")
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _document!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(_document[index].titre.toString()),
                              subtitle:
                                  Text(_document[index].description.toString()),
                              trailing: const Icon(Icons.more_vert),
                              // isThreeLine: true,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  DetailSujet.routeName,
                                  arguments: DetailSujet(
                                    sujet: _document[index],
                                    fonction: "encadrant",
                                  ),
                                );
                              },
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
                    title: const Text('Sujet 1'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () {
                      Navigator.pushNamed(context, DetailSujet.routeName,
                          arguments: DetailSujet(
                            fonction: "encadrant",
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
                            fonction: "encadrant",
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
                            fonction: "encadrant",
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
                            fonction: "encadrant",
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

  void getData() async {
    _document = await ApiDocument().getDocument();
    log("_document::$_document");
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }
}
