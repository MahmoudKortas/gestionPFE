import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../resize_widget.dart';

/// Displays detailed information about a SampleItem.
class GererListeDesJuries extends StatefulWidget {
  GererListeDesJuries({Key? key}) : super(key: key);

  static const routeName = '/JuriesList';
  @override
  State<GererListeDesJuries> createState() => _GererListeDesJuriesState();
}

class _GererListeDesJuriesState extends State<GererListeDesJuries> {
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> president = ["president"];
  List<String> Papporteur = ["Papporteur"];

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
          child: ListView.builder(
            itemCount: 3,
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
        title: const Text('Modifier / Supprimer document'),
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
                            print("i::${i}");
                            president.remove("president");
                            setState(() {});
                          },
                          icon: const Icon(Icons.close,color: Colors.red,),
                        ),
                      ],
                    ),
                  IconButton(
                    onPressed: () {
                      president.add("president");
                      setState(() {});
                    },
                    icon: const Icon(Icons.add_circle_outlined,color: Colors.green,),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
