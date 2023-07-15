import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/helpers/document_api.dart';
import 'package:gestion_pfe/src/models/document.dart';
import '../../resize_widget.dart';
import '../subjects/detail_sujet.dart';

/// Displays detailed information about a SampleItem.
class ApprouverDocuments extends StatefulWidget {
  const ApprouverDocuments({Key? key}) : super(key: key);

  static const routeName = '/ApprouverDocuments';
  @override
  State<ApprouverDocuments> createState() => _ApprouverDocumentsState();
}

class _ApprouverDocumentsState extends State<ApprouverDocuments> {
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // ignore: prefer_typing_uninitialized_variables
  var _document;
  Document? doc;

  File? _image;
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Approuver documents'),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        // controller: controller,
        child: Center(
          child: resiseWidget(
            context: context,
            child: Column(
              children: [
                /* Card(
                  child: ListTile(
                    title: const Text("Document 1"),
                    subtitle: const Text("description document 1"),
                    trailing: const Icon(Icons.more_vert),
                    // isThreeLine: true,
                    onTap: () {
                      // Navigator.pushNamed(
                      //   context,
                      //   DetailSujet.routeName,
                      //   arguments: DetailSujet(
                      //     sujet: Document(),
                      //     fonction: "etudiant",
                      //   ),
                      // );
                    },
                  ),
                ),*/
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
                                subtitle: Text(
                                    _document[index].description.toString()),
                                trailing: const Icon(Icons.more_vert),
                                // isThreeLine: true,
                                onTap: () => dialog(context, _document![index])
                                // {
                                //   Navigator.pushNamed(
                                //     context,
                                //     DetailSujet.routeName,
                                //     arguments: DetailSujet(
                                //       sujet: _document[index],
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

  Future<String?> dialog(BuildContext context, Document document) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Approuver document'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Titre document: ${document.titre}"),
              Text("Description document: ${document.description}"),
              Text("Date document: ${document.date}"),
              Text("Photo document: ${document.photo}"),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Approuver'),
            child: const Text('Approuver'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'désapprouver'),
            child: const Text('désapprouver'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'Annuler'),
            child: const Text('Annuler'),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (_image == null) {
      return const Padding(
        padding: EdgeInsets.all(5),
        child: Icon(
          Icons.add,
          color: Colors.grey,
        ),
      );
    } else {
      return Text(_image!.path);
    }
  }

  void getData() async {
    _document = await ApiDocument().getAllDocument();
    log("_document::$_document");
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }
}
