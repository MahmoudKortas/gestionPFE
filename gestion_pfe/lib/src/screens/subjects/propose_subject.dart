import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/screens/authentification/signIn.dart';

/// Displays detailed information about a SampleItem.
class ProposeSubject extends StatelessWidget {
  ProposeSubject({Key? key}) : super(key: key);

  static const routeName = '/ProposeSubject';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proposer sujet'),
      ),
      body: SingleChildScrollView(
        // controller: controller,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'sujet',
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
                hintText: 'Date debut',
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
                hintText: 'Date fin',
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
                hintText: 'Domaine',
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
                hintText: 'Titre',
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
                hintText: 'Note',
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
                hintText: 'Document',
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
                hintText: 'Entreprise de stage',
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
                hintText: 'choisir encadrant',
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
    );
  }
}
