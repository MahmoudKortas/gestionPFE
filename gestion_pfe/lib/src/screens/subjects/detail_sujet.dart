import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../resize_widget.dart';

/// Displays detailed information about a SampleItem.
// ignore: must_be_immutable
class DetailSujet extends StatefulWidget {
  String fonction;

  DetailSujet({
    Key? key,
    required this.fonction,
  }) : super(key: key);
  @override
  State<DetailSujet> createState() => _DetailSujetState();
  static const routeName = '/DetailSujet';
}

class _DetailSujetState extends State<DetailSujet> {
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("fonction::${widget.fonction}");
    }
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
                Image.asset("assets/images/logo-epi.png"),
                widget.fonction.contains("etudiant")
                    ? const MaterialButton(
                        onPressed: null,
                        child: Text("choisir"),
                      )
                    : widget.fonction.contains("enseignant")
                        ? Row(
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
                        : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
