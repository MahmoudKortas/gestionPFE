import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/models/document.dart';

import '../../resize_widget.dart';

/// Displays detailed information about a SampleItem.
// ignore: must_be_immutable
class DetailSujet extends StatefulWidget {
  String fonction;
  Document doc;

  DetailSujet({
    Key? key,
    required this.fonction,
    required this.doc,
  }) : super(key: key);
  @override
  State<DetailSujet> createState() => _DetailSujetState();
  static const routeName = '/DetailSujet';
}

class _DetailSujetState extends State<DetailSujet> {
  @override
  Widget build(BuildContext context) {
    log("fonction::${widget.fonction}");
    log("doc::${widget.doc}");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Détail du sujet'),
      ),
      body: SingleChildScrollView(
        // controller: controller,
        child: Center(
          child: resiseWidget(
            context: context,
            child: Column(
              children: [
                Image.network(
                    "http://10.0.2.2:8080/api/document/image/${widget.doc.idDoc}"),
                Column(
                  children: [
                    // Text("Proprietaire: ${widget.doc.proprietaire!}"),
                    Text("Déscription: ${widget.doc.description!}"),
                    Text("Date dépot: ${widget.doc.datedepot!}"),
                    widget.fonction.contains("etudiant")
                        ? const MaterialButton(
                            onPressed: null,
                            child: Text("choisir"),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              MaterialButton(
                                onPressed: null,
                                child: Text("Annuler"),
                              ),
                              MaterialButton(
                                onPressed: null,
                                child: Text("Valider"),
                              ),
                            ],
                          )
                  ],
                )
                /* : widget.fonction.contains("encadrant")
                        ? Column(
                            children: [
                          Text("Proprietaire: ${widget.doc.proprietaire!}"),
                          Text("Déscription: ${widget.doc.description!}"),
                          Text("Date dépot: ${widget.doc.datedepot!}"),
                             
                            ],
                          )
                        : Container()*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
