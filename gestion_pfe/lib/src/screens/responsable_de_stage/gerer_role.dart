// ignore_for_file: prefer_typing_uninitialized_variables, prefer_final_fields, no_leading_underscores_for_local_identifiers

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart'; 
import 'package:gestion_pfe/src/helpers/enseignant_api.dart';
import 'package:image_picker/image_picker.dart';  
import '../../helpers/role.dart';
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
  final descriptionController = TextEditingController();  
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gérer Roles'),
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
                    hintText: 'Saisir description',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'entrez la description du sujet';
                    }
                    return null;
                  },
                  controller: descriptionController,
                ), 
                ElevatedButton(
                  // ignore: avoid_print
                  onPressed: () => addRole(),
                  child: const Text("Ajouter"),
                ),
                /*_Role == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    :*/_role!=null?
                _role!.isEmpty
                    ? const Text("aucun Role existe")
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _role!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                                title: Text(
                                    _role![index].nom.toString()),
                                subtitle: Text(
                                    _role![index].nom.toString()),
                                trailing: const Icon(Icons.more_vert),
                                // isThreeLine: true,
                                onTap: () => dialog(context, _role![index])),
                          );
                        },
                      ):const Text("aucun Role existe null")
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
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Modifier / Supprimer Role'),
        content: SingleChildScrollView(
          child: Column(
            children: const [],
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
            onPressed: () async {
              log(role.idRole.toString());
              var _Rolet;
              _Rolet = await ApiRole()
                  .deleteRole(id: role.idRole.toString());
              log("_Rolet::$_Rolet");
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
    _role=await ApiRole().getAllRoles();
    // _listeRole.clear(); 

    //log("_Role::$_Role");
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }

  addRole() async {
    role?.nom = descriptionController.text;
    await ApiRole().addRole(role: role);

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
