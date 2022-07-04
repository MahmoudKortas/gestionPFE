import 'dart:developer';

import 'package:flutter/material.dart';

import '../../helpers/api_service.dart';
import '../../models/document.dart';
import '../../resize_widget.dart';

/// Displays detailed information about a SampleItem.
class GererDocument extends StatefulWidget {
  const GererDocument({Key? key}) : super(key: key);

  static const routeName = '/Document';
  @override
  State<GererDocument> createState() => _GererDocumentState();
}

class _GererDocumentState extends State<GererDocument> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late List<Document>? _document = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gérer documents'),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        // controller: controller,
        child: Center(
          child: resiseWidget(
            context: context,
            child: Column(
              children: [
                Image.asset("assets/images/logo-epi.png"),
                ElevatedButton(
                  // ignore: avoid_print
                  onPressed: () => addDocument(),
                  child: const Text("Ajouter"),
                ),
                /*_document == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    :*/
                _document!.isEmpty
                    ? const Text("aucun document existe")
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _document!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                                title:  Text('document $index'),
                                subtitle: const Text(
                                    'A sufficiently long subtitle warrants three lines.'),
                                trailing: const Icon(Icons.more_vert),
                                isThreeLine: true,
                                onTap: () => dialog(context)),
                          );
                        },
                      ) /*Card(
                  child: ListTile(
                      /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                      title: const Text('SampleItem'),
                      subtitle: const Text(
                          'A sufficiently long subtitle warrants three lines.'),
                      trailing: const Icon(Icons.more_vert),
                      isThreeLine: true,
                      onTap: () => dialog(context)),
                ),
                Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text('SampleItem'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () => dialog(context),
                  ),
                ),
                Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text('SampleItem'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () => dialog(context),
                  ),
                ),
                Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text('SampleItem'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () => dialog(context),
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

  Future<String?> dialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Modifier / Supprimer document'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset("assets/images/logo-epi.png"),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Annuler'),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'Modifer'),
            child: const Text('Modifer'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'Supprimer'),
            child: const Text('Supprimer'),
          ),
          /*TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),*/
        ],
      ),
    );
  }

  void getData() async {
    //await ApiService().updateEtudiants("3");
    //await ApiService().deleteEtudiants("17");
    // await ApiService().addEtudiants();
    // await ApiService().addDocument();
    //await ApiService().addEnseignant();
    _document = await ApiService().getDocument();

    //log("_document::$_document");
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }
  
  addDocument() async {
     await ApiService().addDocument();
    getData();
  }
}
