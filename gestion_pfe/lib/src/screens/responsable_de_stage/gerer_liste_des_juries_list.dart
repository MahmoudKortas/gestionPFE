import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../helpers/api_service.dart';
import '../../models/enseignant.dart';
import '../../resize_widget.dart';

/// Displays detailed information about a SampleItem.
class GererListeDesJuries extends StatefulWidget {
  const GererListeDesJuries({Key? key}) : super(key: key);

  static const routeName = '/JuriesList';
  @override
  State<GererListeDesJuries> createState() => _GererListeDesJuriesState();
}

class _GererListeDesJuriesState extends State<GererListeDesJuries> {
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late List<Enseignant>? _enseignant = [];
  List<String> president = ["president"];
  // ignore: non_constant_identifier_names
  List<String> Papporteur = ["Papporteur"];
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gérer liste des jurys'),
      ),
      body: Center(
        // child: SingleChildScrollView(
        // controller: controller,

        child: resiseWidget(
          context: context,
          child: _enseignant!.isEmpty
              ? const Text("aucun document existe")
              : ListView.builder(
                  itemCount: _enseignant!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        leading: ElevatedButton(
                          onPressed: () {
                            if (kDebugMode) {
                              print("pfe${index + 1}");
                            }
                          },
                          child: Text("Enseignant ${index + 1}"),
                        ),
                        title: ElevatedButton(
                          onPressed: () {
                            dialog(context);
                            if (kDebugMode) {
                              print("Papporteur PFE ${index + 1}");
                            }
                          },
                          child: Text("Papporteur PFE ${index + 1}"),
                        ),
                        subtitle: ElevatedButton(
                          onPressed: () {
                            dialog(context);
                            if (kDebugMode) {
                              print("Président PFE ${index + 1}");
                            }
                          },
                          child: Text("Président PFE ${index + 1}"),
                        ),
                        isThreeLine: true,
                      ),
                    );
                  },
                ),
        ),
        // ),
      ),
    );
  }

  Future<String?> dialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Modifier / Supprimer rapporteur'),
        content: StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  for (var i in president)
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Saisir id du PFE',
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            log("i::$i");
                            president.remove("president");
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  IconButton(
                    onPressed: () {
                      president.add("president");
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.add_circle_outlined,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void getData() async {
    //await ApiService().updateEtudiants("3");
    //await ApiService().deleteEtudiants("17");
    // await ApiService().addEtudiants();
    // await ApiService().addDocument();
    //await ApiService().addEnseignant();
    _enseignant = await ApiService().getEnseignant();
    log("_enseignant::$_enseignant");
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }
}
