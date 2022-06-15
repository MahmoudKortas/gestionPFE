import 'package:flutter/material.dart';

import '../../resize_widget.dart';

/// Displays detailed information about a SampleItem.
class DetailSujet extends StatelessWidget {
  const DetailSujet({Key? key}) : super(key: key);

  static const routeName = '/DetailSujet';
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail du sujet'),
      ),
      body: SingleChildScrollView(
        // controller: controller,
        child: Center(
          child: resiseWidget(
            context: context,
            child: Column(
              children: [
                Image.asset("assets/images/logo-epi.png"),
                const MaterialButton(
                  onPressed: null,
                  child: Text("choisir"),
                ),
                const MaterialButton(
                  onPressed: null,
                  child: Text("Valider"),
                ),
                const MaterialButton(
                  onPressed: null,
                  child: Text("Annuler"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
