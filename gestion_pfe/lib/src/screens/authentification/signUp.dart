import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/screens/authentification/signIn.dart';

/// Displays detailed information about a SampleItem.
class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  static const routeName = '/signUp';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('signIn'),
      ),
      body: SingleChildScrollView(
        // controller: controller,
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Saisir votre nom',
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
                      hintText: 'Saisir votre prenom',
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
                      hintText: 'Saisir votre telephone',
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
                      hintText: 'Saisir votre adresse',
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
                      hintText: 'Saisir votre email',
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
                      hintText: 'Saisir votre password',
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
                      hintText: 'Saisir votre role',
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
                      hintText: 'Saisir votre specialité',
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
                      hintText: 'Saisir votre specialité',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
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
                        Navigator.restorablePushNamed(
                          context,
                          SignIn.routeName,
                        );
                      },
                      child: const Text("S'inscrire"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
