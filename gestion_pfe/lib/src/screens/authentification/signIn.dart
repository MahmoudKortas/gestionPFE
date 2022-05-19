import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/screens/authentification/signUp.dart';
import 'package:gestion_pfe/src/screens/student/choose_propse_subject.dart';

/// Displays detailed information about a SampleItem.
class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);

  static const routeName = '/SignIn';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('logIn'),
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
                          ChoosePropseSubject.routeName,
                        );                  
                      },
                      child: const Text('Se connecter'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.restorablePushNamed(
                          context,
                          SignUp.routeName,
                        );
                      },
                      child: const Text('Créer votre compte'),
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
