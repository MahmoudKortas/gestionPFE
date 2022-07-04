import 'package:flutter/material.dart';

import '../../resize_widget.dart';

/// Displays detailed information about a SampleItem.
class ProposerSujet extends StatefulWidget {
  ProposerSujet({Key? key}) : super(key: key);
  static const routeName = '/ProposerSujet';
  @override
  State<ProposerSujet> createState() => _ProposerSujetState();
}

class _ProposerSujetState extends State<ProposerSujet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _items = [
    'informatique',
    'mecanique',
    'electrique',
    'genie civile',
    'langues',
    'mathematique'
  ];
  String? value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proposer sujet'),
      ),
      body: SingleChildScrollView(
        // controller: controller,
        child: Center(
          child: resiseWidget(
            context: context,
            child: Column(
              children: [
                const TextButton(
                  onPressed: null,
                  child: Text("upload file"),
                ),
                DropdownButton<String>(
                  hint: const Text("choisir l'encadrant"),
                  value: value,
                  iconSize: 36,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                  items: _items.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(() => this.value = value),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.
                      /*if (_formKey.currentState!.validate()) {
                          // Process data.
                        }*/
                    },
                    child: const Text("upload"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ), // Text
      );
}
