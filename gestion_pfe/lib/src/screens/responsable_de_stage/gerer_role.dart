// ignore_for_file: prefer_typing_uninitialized_variables, prefer_final_fields, no_leading_underscores_for_local_identifiers

import 'dart:developer';
// import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:gestion_pfe/src/helpers/encadrant_api.dart';
// import 'package:image_picker/image_picker.dart';
import '../../helpers/role_api.dart';
import '../../models/role.dart';
import '../../resize_widget.dart';

class GererRole extends StatefulWidget {
  const GererRole({Key? key}) : super(key: key);
  static const routeName = '/Role';
  @override
  State<GererRole> createState() => _GererRoleState();
}

class _GererRoleState extends State<GererRole> {
  late List<Role>? _role = [];
  String? value;
  Role? role = Role();
  final nomController = TextEditingController();
  final editNomController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Roles'),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        // controller: controller,
        child: Center(
          child: resiseWidget(
            context: context,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.description),
                    hintText: 'Saisir nom',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'entrez la nom du role';
                    }
                    return null;
                  },
                  controller: nomController,
                ),
                ElevatedButton(
                  // ignore: avoid_print
                  onPressed: () {
                    try {
                      addRole();
                    } catch (e) {
                      log("gerer-role-exception::${e.toString()}");
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("quelque chose ne va pas"),
                            backgroundColor: Colors.red),
                      );
                    }
                  },
                  child: const Text("Ajouter"),
                ),
                /*_Role == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    :*/
                _role != null
                    ? _role!.isEmpty
                        ? const Text("aucun Role existe")
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _role!.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                    title: Text(_role![index].nom.toString()),
                                    subtitle:
                                        Text(_role![index].nom.toString()),
                                    trailing: const Icon(Icons.more_vert),
                                    // isThreeLine: true,
                                    onTap: () =>
                                        dialog(context, _role![index])),
                              );
                            },
                          )
                    : const Text("aucun Role existe null")
                /*Card(
                  child: ListTile(
                      /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                      title: const Text('SampleItem'),
                      subtitle: const Text(
                          'A sufficiently long subtitle warrants three lines.'),
                      trailing: const Icon(Icons.more_vert),
                      isThreeLine: true,
                      onTap: () => dialog(context)),
                ),
                Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text('SampleItem'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () => dialog(context),
                  ),
                ),
                Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text('SampleItem'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () => dialog(context),
                  ),
                ),
                Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),*/
                    title: const Text('SampleItem'),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: () => dialog(context),
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

  Future<String?> dialog(BuildContext context, Role role) {
    editNomController.text = role.nom ?? "";
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Modifier / Supprimer Role'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                // initialValue: role.nom,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.description),
                  hintText: 'Saisir nom du role',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'entrez la nom du role';
                  }
                  return null;
                },
                controller: editNomController,
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
            onPressed: () {
              role.nom = editNomController.text;
              editRole(role: role);
              Navigator.pop(context, 'Modifer');
            },
            child: const Text('Modifer'),
          ),
          TextButton(
            onPressed: () async {
              log(role.idRole.toString());
              var _rolet;
              _rolet = await ApiRole().deleteRole(id: role.idRole.toString());
              log("_rolet::$_rolet");
              getData();
              Navigator.pop(context, 'Supprimer');
            },
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
    _role = await ApiRole().getAllRoles();
    // _listeRole.clear();

    //log("_Role::$_Role");
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }

  addRole() async {
    role?.nom = nomController.text;
    await ApiRole().addRole(role: role);

    getData();
  }

  editRole({Role? role}) async {
    await ApiRole().updateRole(role: role);

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
