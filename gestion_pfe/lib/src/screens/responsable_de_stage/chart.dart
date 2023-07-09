// ignore_for_file: prefer_typing_uninitialized_variables, prefer_final_fields, no_leading_underscores_for_local_identifiers

import 'dart:developer';
// import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:gestion_pfe/src/helpers/departement.dart';
import 'package:gestion_pfe/src/helpers/encadrant_api.dart';
import 'package:gestion_pfe/src/helpers/pfe_api.dart';
import 'package:gestion_pfe/src/helpers/salle_api.dart';
import 'package:gestion_pfe/src/helpers/seance_api.dart';
import 'package:gestion_pfe/src/icon_widget.dart';
// import 'package:gestion_pfe/src/models/departement.dart';
import 'package:gestion_pfe/src/models/encadrant.dart';
import 'package:gestion_pfe/src/models/pfe.dart';
import 'package:gestion_pfe/src/models/salle.dart';
import 'package:gestion_pfe/src/models/seance_model.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/resultatPfe.dart';
// import 'package:image_picker/image_picker.dart';
import '../../helpers/soutenance_api.dart';
import '../../models/soutenance.dart';
import '../../resize_widget.dart';

class Chart extends StatefulWidget {
  const Chart({Key? key}) : super(key: key);
  static const routeName = '/Chart';
  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  late List<Soutenance?>? _soutenance = [];
  String? value;
  Soutenance? soutenance = Soutenance();
  final dateController = TextEditingController();
  final descriptionController = TextEditingController();
  final etatController = TextEditingController();
  final motdepasseController = TextEditingController();
  final telController = TextEditingController();
  final dateResponsabiliteController = TextEditingController();

  Encadrant? rapporteurValue;
  Encadrant? presidentValue;
  Salle? salleValue;
  Seance? seanceValue;
  PFE? pfeValue;

  List<Encadrant?>? _rapporteur;
  List<Encadrant?>? _president;
  List<Salle?>? _salle;
  List<Seance?>? _seance;
  List<PFE?>? _pfe;
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
        title: const Text('Statistiques'),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        // controller: controller,
        child: Center(
          child: resiseWidget(
            context: context,
            child: Column(
              children: [
                Card(
                  child: ListTile(
                    leading: iconWidget(Icons.present_to_all),
                    title: const Text(' Pfe'),
                    subtitle: const Text(' 50'),
                    trailing: const Icon(Icons.more_vert),
                    //isThreeLine: true,
                    onTap: () {
                      // Navigator.restorablePushNamed(
                      //   context,
                      //   ResultatPfe.routeName,
                      // );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: iconWidget(Icons.present_to_all),
                    title: const Text(' Etudiant'),
                    subtitle: const Text(' 45'),
                    trailing: const Icon(Icons.more_vert),
                    //isThreeLine: true,
                    onTap: () {
                      // Navigator.restorablePushNamed(
                      //   context,
                      //   ResultatPfe.routeName,
                      // );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: iconWidget(Icons.present_to_all),
                    title: const Text(' Enseignant'),
                    subtitle: const Text(' 10'),
                    trailing: const Icon(Icons.more_vert),
                    //isThreeLine: true,
                    onTap: () {
                      // Navigator.restorablePushNamed(
                      //   context,
                      //   ResultatPfe.routeName,
                      // );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: iconWidget(Icons.present_to_all),
                    title: const Text(' Sujet'),
                    subtitle: const Text(' 60'),
                    trailing: const Icon(Icons.more_vert),
                    //isThreeLine: true,
                    onTap: () {
                      // Navigator.restorablePushNamed(
                      //   context,
                      //   ResultatPfe.routeName,
                      // );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getData() async {
    await Future.wait([
      ApiSoutenance().getAllSoutenance(),
      ApiEncadrant().getAllEncadrant(),
      ApiSalle().getAllSalles(),
      ApiSeance().getAllSeances(),
      ApiPfe().getAllPFE()
    ]).then((value) async {
      _soutenance = value[0]?.cast<Soutenance?>();
      _rapporteur = value[1]?.cast<Encadrant?>();
      // _president = value[2]?.cast<Encadrant?>();
      _salle = value[2]?.cast<Salle?>();
      _seance = value[3]?.cast<Seance?>();
      _pfe = value[4]?.cast<PFE?>();
    });

    // _listeSoutenance.clear();

    //log("_Soutenance::$_Soutenance");
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }
}
