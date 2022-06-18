import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../resize_widget.dart';

/// Displays detailed information about a SampleItem.
class GererListeDesJuries extends StatelessWidget {
  const GererListeDesJuries({Key? key}) : super(key: key);

  static const routeName = '/JuriesList';
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                      dialog(context);
                      if (kDebugMode) {
                        print("pfe${index + 1}");
                      }
                    },
                    child: Text("PFE ${index + 1}"),
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
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
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
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Saisir le note du PFE',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
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
        ],
      ),
    );
  }
}
