import 'dart:developer';

import 'package:flutter/material.dart';

import '../../helpers/api_service.dart';
import '../../models/etudiant.dart';
import '../../resize_widget.dart';

/// Displays detailed information about a SampleItem.
class GererEtudiant extends StatefulWidget {
  GererEtudiant({Key? key}) : super(key: key);

  static const routeName = '/GererEtudiant';
  @override
  State<GererEtudiant> createState() => _GererEtudiantState();
}

class _GererEtudiantState extends State<GererEtudiant> {
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
  late List<Etudiant>? _etudiant = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gérer Etudiants'),
      ),
      body: SingleChildScrollView(
        // controller: controller,
        physics: const ScrollPhysics(),
        child: Center(
          child: resiseWidget(
            context: context,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Saisir votre nom',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Entrez votre nom';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Saisir votre prenom',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Entrez votre prenom';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    hintText: 'Saisir votre telephone',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Entrez votre telephone';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.location_city),
                    hintText: 'Saisir votre adresse',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Entrez votre adresse';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Saisir votre email',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Entrez votre email';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: 'Saisir votre password',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Entrez votre password';
                    }
                    return null;
                  },
                ),
                DropdownButton<String>(
                  hint: const Text("choisir votre domaine"),
                  value: value,
                  iconSize: 36,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                  items: _items.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(() => this.value = value),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                DropdownButton<String>(
                  hint: const Text("choisir votre diplome"),
                  value: value,
                  iconSize: 36,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                  items: _items.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(() => this.value = value),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                DropdownButton<String>(
                  hint: const Text("choisir votre departement"),
                  value: value,
                  iconSize: 36,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                  items: _items.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(() => this.value = value),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                DropdownButton<String>(
                  hint: const Text("choisir votre niveau"),
                  value: value,
                  iconSize: 36,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                  items: _items.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(() => this.value = value),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                DropdownButton<String>(
                  hint: const Text("choisir votre specialité"),
                  value: value,
                  iconSize: 36,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                  items: _items.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(() => this.value = value),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                ElevatedButton(
                  onPressed: () => addData(),
                  child: const Text("Ajouter"),
                ),
                _etudiant!.isEmpty
                    ? const Text("aucun étudiant existe")
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _etudiant!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                                /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                                title: Text('Etudiant $index'),
                                subtitle: const Text(
                                    'A sufficiently long subtitle warrants three lines.'),
                                trailing: const Icon(Icons.more_vert),
                                isThreeLine: true,
                                onTap: () => dialog(context)),
                          );
                        },
                      ),

                /*Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text('Etudiant 2'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () {
                      // Navigate to the details page. If the user leaves and returns to
                      // the app after it has been killed while running in the
                      // background, the navigation stack is restored.
                      /*Navigator.restorablePushNamed(
                    context,
                    LogIn.routeName,
                  );*/
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text('Etudiant 2'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () {
                      // Navigate to the details page. If the user leaves and returns to
                      // the app after it has been killed while running in the
                      // background, the navigation stack is restored.
                      /*Navigator.restorablePushNamed(
                    context,
                    LogIn.routeName,
                  );*/
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text('Etudiant 3'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () {
                      // Navigate to the details page. If the user leaves and returns to
                      // the app after it has been killed while running in the
                      // background, the navigation stack is restored.
                      /*Navigator.restorablePushNamed(
                    context,
                    LogIn.routeName,
                  );*/
                    },
                  ),
                ),
              */
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> dialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Modifier / Supprimer etudiant'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Saisir votre nom',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Entrez votre nom';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Saisir votre prenom',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Entrez votre prenom';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  hintText: 'Saisir votre telephone',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Entrez votre telephone';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.location_city),
                  hintText: 'Saisir votre adresse',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Entrez votre adresse';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Saisir votre email',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Entrez votre email';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText: 'Saisir votre password',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Entrez votre password';
                  }
                  return null;
                },
              ),
              DropdownButton<String>(
                hint: const Text("choisir votre domaine"),
                value: value,
                iconSize: 36,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                items: _items.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() => this.value = value),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              DropdownButton<String>(
                hint: const Text("choisir votre diplome"),
                value: value,
                iconSize: 36,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                items: _items.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() => this.value = value),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              DropdownButton<String>(
                hint: const Text("choisir votre departement"),
                value: value,
                iconSize: 36,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                items: _items.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() => this.value = value),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              DropdownButton<String>(
                hint: const Text("choisir votre niveau"),
                value: value,
                iconSize: 36,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                items: _items.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() => this.value = value),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              DropdownButton<String>(
                hint: const Text("choisir votre specialité"),
                value: value,
                iconSize: 36,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                items: _items.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() => this.value = value),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
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
          /*TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),*/
        ],
      ),
    );
  }

  void getData() async {
    //await ApiService().updateEtudiants("3");
    //await ApiService().deleteEtudiants("17");
    // await ApiService().addEtudiants();
    // await ApiService().addDocument();
    //await ApiService().addEnseignant();
    log("get");
    _etudiant = await ApiService().getEtudiants();
    log("_etudiant::$_etudiant");
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }

  void addData() async {
    log("add");
    //await ApiService().updateEtudiants("3");
    //await ApiService().deleteEtudiants("17");
     await ApiService().addEtudiants();
    // await ApiService().addDocument();
    //await ApiService().addEnseignant();
    getData();
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ), // Text
      );
}
