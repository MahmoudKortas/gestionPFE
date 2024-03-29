import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/helpers/etudiant_api.dart';
import '../../resize_widget.dart';

/// Displays detailed information about a SampleItem.
class EnqueteSatisfaction extends StatefulWidget {
  const EnqueteSatisfaction({Key? key}) : super(key: key);
  static const routeName = '/enqueteSatisfaction';
  @override
  State<EnqueteSatisfaction> createState() => _EnqueteSatisfactionState();
}

class _EnqueteSatisfactionState extends State<EnqueteSatisfaction> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String?>? gender = [
    "",
    "",
    "",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Votre satisfaction"),
      ),
      body: SingleChildScrollView(
        // controller: controller,
        child: Center(
          child: resiseWidget(
            context: context,
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Nous sommes ravis de savoir que vous souhaitez mener une enquête de satisfaction sur les conditions de déroulement des projets de fin d'études. Une enquête de ce type peut fournir des informations précieuses pour identifier les points forts et les domaines à améliorer dans le processus de réalisation des projets de fin d'études:",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Quel est votre niveau de satisfaction global par rapport aux conditions de déroulement de votre projet de fin d'études ?",
                        style: TextStyle(fontSize: 14),
                      ),
                      RadioListTile(
                        title: const Text("Satisfait"),
                        value: "Satisfait",
                        groupValue: gender?[0],
                        onChanged: (value) {
                          setState(() {
                            gender?[0] = value.toString();
                          });
                        },
                      ),
                      RadioListTile(
                        title: const Text("Neutre"),
                        value: "Neutre",
                        groupValue: gender?[0],
                        onChanged: (value) {
                          setState(() {
                            gender?[0] = value.toString();
                          });
                        },
                      ),
                      RadioListTile(
                        title: const Text("Insatisfait"),
                        value: "Insatisfait",
                        groupValue: gender?[0],
                        onChanged: (value) {
                          setState(() {
                            gender?[0] = value.toString();
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Dans quelle mesure les ressources et les infrastructures mises à votre disposition ont-elles été adéquates pour mener à bien votre projet de fin d'études ?",
                        style: TextStyle(fontSize: 14),
                      ),
                      RadioListTile(
                        title: const Text("Adéquates"),
                        value: "Satisfait",
                        groupValue: gender?[1],
                        onChanged: (value) {
                          setState(() {
                            gender?[1] = value.toString();
                          });
                        },
                      ),
                      RadioListTile(
                        title: const Text("Neutre"),
                        value: "Neutre",
                        groupValue: gender?[1],
                        onChanged: (value) {
                          setState(() {
                            gender?[1] = value.toString();
                          });
                        },
                      ),
                      RadioListTile(
                        title: const Text("Inadéquates"),
                        value: "Insatisfait",
                        groupValue: gender?[1],
                        onChanged: (value) {
                          setState(() {
                            gender?[1] = value.toString();
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Comment évaluez-vous la clarté des objectifs et des attentes de votre projet de fin d'études  ?",
                        style: TextStyle(fontSize: 14),
                      ),
                      RadioListTile(
                        title: const Text("Clairs"),
                        value: "Satisfait",
                        groupValue: gender?[2],
                        onChanged: (value) {
                          setState(() {
                            gender?[2] = value.toString();
                          });
                        },
                      ),
                      RadioListTile(
                        title: const Text("Neutre"),
                        value: "Neutre",
                        groupValue: gender?[2],
                        onChanged: (value) {
                          setState(() {
                            gender?[2] = value.toString();
                          });
                        },
                      ),
                      RadioListTile(
                        title: const Text("Peu clairs"),
                        value: "Insatisfait",
                        groupValue: gender?[2],
                        onChanged: (value) {
                          setState(() {
                            gender?[2] = value.toString();
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text("Valider"),
                        ),
                      ),
                    ],
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
