// ignore_for_file: prefer_typing_uninitialized_variables, prefer_final_fields, no_leading_underscores_for_local_identifiers

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart'; 
import 'package:gestion_pfe/src/helpers/enseignant_api.dart';
import 'package:image_picker/image_picker.dart';  
import '../../helpers/specialite.dart';
import '../../models/specialite.dart';
import '../../resize_widget.dart';

class GererSpecialite extends StatefulWidget {
  const GererSpecialite({Key? key}) : super(key: key);
  static const routeName = '/Specialite';
  @override
  State<GererSpecialite> createState() => _GererSpecialiteState();
}

class _GererSpecialiteState extends State<GererSpecialite> {
  late List<Specialite>? _specialite = [];  
  String? value; 
  Specialite? specialite = Specialite(); 
  final nomController = TextEditingController();  
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Specialites'),
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
                      return 'entrez la nom du sujet';
                    }
                    return null;
                  },
                  controller: nomController,
                ), 
                ElevatedButton(
                  // ignore: avoid_print
                  onPressed: () => addSpecialite(),
                  child: const Text("Ajouter"),
                ),
                /*_Specialite == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    :*/_specialite!=null?
                _specialite!.isEmpty
                    ? const Text("aucun Specialite existe")
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _specialite!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                                title: Text(
                                    _specialite![index].nom.toString()),
                                subtitle: Text(
                                    _specialite![index].nom.toString()),
                                trailing: const Icon(Icons.more_vert),
                                // isThreeLine: true,
                                onTap: () => dialog(context, _specialite![index])),
                          );
                        },
                      ):const Text("aucun Specialite existe null")
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

  Future<String?> dialog(BuildContext context, Specialite specialite) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Modifier / Supprimer Specialite'),
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
              log(specialite.idSpecialite.toString());
              var _Specialitet;
              _Specialitet = await ApiSpecialite()
                  .deleteSpecialite(id: specialite.idSpecialite.toString());
              log("_Specialitet::$_Specialitet");
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
    _specialite=await ApiSpecialite().getAllSpecialites();
    // _listeSpecialite.clear(); 

    //log("_Specialite::$_Specialite");
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }

  addSpecialite() async {
    specialite?.nom = nomController.text;
    await ApiSpecialite().addSpecialite(specialite: specialite);

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
