import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/helpers/document_api.dart';
import 'package:gestion_pfe/src/models/document.dart'; 
import '../../resize_widget.dart';
import '../subjects/detail_sujet.dart';

/// Displays detailed information about a SampleItem.
class ListeDesSujets extends StatefulWidget {
  const ListeDesSujets({Key? key}) : super(key: key);

  static const routeName = '/ListeDesSujets';
  @override
  State<ListeDesSujets> createState() => _ListeDesSujetsState();
}

class _ListeDesSujetsState extends State<ListeDesSujets> {
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // ignore: prefer_typing_uninitialized_variables
  var _document;
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
        title: const Text('Liste des sujets'),
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
                          log(_document[index].titre.toString());
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
                                    doc: _document[index],
                                    fonction: "etudiant",
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

  void getData() async {
    _document = await ApiDocument().getDocument();
    log("_document::$_document");
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }
}
