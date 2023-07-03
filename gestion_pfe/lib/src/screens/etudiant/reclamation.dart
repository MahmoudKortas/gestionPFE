import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/helpers/etudiant_api.dart';
import '../../resize_widget.dart';

/// Displays detailed information about a SampleItem.
class Reclamation extends StatefulWidget {
  const Reclamation({Key? key}) : super(key: key);
  static const routeName = '/Reclamation';
  @override
  State<Reclamation> createState() => _ReclamationState();
}

class _ReclamationState extends State<Reclamation> {
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
        title: const Text("Votre réclamation"),
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
                      /*const Text(
                        "Nous sommes ravis de savoir que vous souhaitez mener une enquête de satisfaction sur les conditions de déroulement des projets de fin d'études. Une enquête de ce type peut fournir des informations précieuses pour identifier les points forts et les domaines à améliorer dans le processus de réalisation des projets de fin d'études:",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),*/
                      const Text(
                        "Dans quelle mesure êtes-vous satisfait de la résolution des problèmes ou des réclamations que vous avez soulevés pendant le déroulement de votre projet de fin d'études ?",
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
                        "Avez-vous signalé ces problèmes ou difficultés aux personnes responsables du projet de fin d'études ?",
                        style: TextStyle(fontSize: 14),
                      ),
                      RadioListTile(
                        title: const Text("Oui"),
                        value: "Satisfait",
                        groupValue: gender?[2],
                        onChanged: (value) {
                          setState(() {
                            gender?[2] = value.toString();
                          });
                        },
                      ),
                      RadioListTile(
                        title: const Text("Non"),
                        value: "Neutre",
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
                      const Text(
                        "Avez-vous rencontré des problèmes ou des difficultés majeurs pendant le déroulement de votre projet de fin d'études ?",
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            // prefixIcon: Icon(Icons.alternate_email),
                            // hintText: 'Saisir votre e-mail',
                            ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            // return 'entrez votre email';
                          }
                          return null;
                        },
                        // controller: emailController,
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
