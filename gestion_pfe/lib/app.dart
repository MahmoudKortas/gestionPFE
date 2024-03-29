import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gestion_pfe/src/screens/encadrant/affecter_note.dart';
import 'package:gestion_pfe/src/screens/encadrant/approuver_documents.dart';
import 'package:gestion_pfe/src/screens/encadrant/proposer_sujet.dart';
import 'package:gestion_pfe/src/screens/encadrant/traiter_demande.dart';
import 'package:gestion_pfe/src/screens/etudiant/choisirEncadrant.dart';
import 'package:gestion_pfe/src/screens/etudiant/consulter_note.dart';
import 'package:gestion_pfe/src/screens/etudiant/enquete_satisfaction.dart';
import 'package:gestion_pfe/src/screens/etudiant/gerer_document.dart';
import 'package:gestion_pfe/src/screens/etudiant/proposer_sujet.dart';
import 'package:gestion_pfe/src/screens/etudiant/reclamation.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/chart.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/gerer_departement.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/gerer_ligne_soutenance.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/gerer_role.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/gerer_salle_calender.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/gerer_seance.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/gerer_soutenance.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/gerer_specialite.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/gerer_sujet.dart';
import 'package:gestion_pfe/src/screens/responsable_de_stage/resultatPfe.dart';
import 'src/custom_theme.dart';
import 'src/screens/encadrant/accueil_encadrant.dart';
import 'src/screens/etudiant/accueil_etudiant.dart';
import 'src/screens/responsable_de_stage/calander.dart';
import 'src/screens/responsable_de_stage/dashboard.dart';
import 'src/screens/responsable_de_stage/gerer_document.dart';
import 'src/screens/responsable_de_stage/gerer_responsable.dart';
import 'src/screens/responsable_de_stage/gerer_salle.dart';
import 'src/screens/responsable_de_stage/gerer_sujets_pfe.dart';
import 'src/screens/responsable_de_stage/gerer_etudiant.dart';
import 'src/screens/responsable_de_stage/gerer_encadrant.dart';
import 'src/screens/authentification/authentification.dart';
import 'src/screens/authentification/inscription.dart';
import 'src/screens/subjects/detail_sujet.dart';
import 'src/screens/subjects/proposer_sujet.dart';
import 'src/screens/subjects/consulter_planning.dart';
import 'src/screens/etudiant/liste_des_sujets.dart';
import 'src/screens/encadrant/gerer_demande_des_sujets.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          /*theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,*/
          darkTheme: lightTheme, //darkTheme,
          theme: lightTheme,
          themeMode: ThemeMode.system,
          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case Authentification.routeName:
                    return const Authentification();
                  case Inscription.routeName:
                    return const Inscription();
                  case AccueilEncadrant.routeName:
                    // final args = routeSettings.arguments as AccueilEncadrant;
                    return AccueilEncadrant(
                        // encadrant: args.encadrant
                        );
                  case AccueilEtudiant.routeName:
                    final args = routeSettings.arguments as AccueilEtudiant;
                    return AccueilEtudiant(
                      etudiant: args.etudiant,
                    );
                  case ConsulterPlanning.routeName:
                    return const ConsulterPlanning();
                  case GererDemandeDesSujetsPFE.routeName:
                    return const GererDemandeDesSujetsPFE();
                  case Dashboard.routeName:
                    return const Dashboard();
                  case GererSujetsPFE.routeName:
                    return const GererSujetsPFE();
                  case GererDocument.routeName:
                    return const GererDocument();
                  case DeposerDocument.routeName:
                    return const DeposerDocument();
                  case GererSeance.routeName:
                    return const GererSeance();
                  case GererSalle.routeName:
                    return const GererSalle();
                  case GererSujet.routeName:
                    return const GererSujet();
                  case GererLigneSoutenance.routeName:
                    return const GererLigneSoutenance();
                  case GererSalleCalender.routeName:
                    return const GererSalleCalender();
                  case GererDepartement.routeName:
                    return const GererDepartement();
                  case GererRole.routeName:
                    return const GererRole();
                  case GererSpecialite.routeName:
                    return const GererSpecialite();
                  case GererResponsable.routeName:
                    return const GererResponsable();
                  case GererEncadrant.routeName:
                    return const GererEncadrant();
                  case Calander.routeName:
                    return const Calander();
                  case GererEtudiant.routeName:
                    return const GererEtudiant();
                  case AffecterNote.routeName:
                    return AffecterNote();
                  case ConsulterNote.routeName:
                    return ConsulterNote(); 
                  case ChoisirEncadrant.routeName:
                    return ChoisirEncadrant();
                  case GererSoutenance.routeName:
                    return const GererSoutenance();
                  case ResultatPfe.routeName:
                    return const ResultatPfe();
                  case Chart.routeName:
                    return const Chart();
                  case ProposerSujet.routeName:
                    // final args = routeSettings.arguments as ProposerSujet;
                    return ProposerSujet(
                        // fonction: args.fonction,
                        // encadrant: args.encadrant,
                        // etudiant: args.etudiant,
                        );
                  case ProposerSujetEtudiant.routeName:
                    // final args = routeSettings.arguments as ProposerSujet;
                    return ProposerSujetEtudiant(
                        // fonction: args.fonction,
                        // encadrant: args.encadrant,
                        // etudiant: args.etudiant,
                        );
                  case ProposerSujetEncadrant.routeName:
                    // final args = routeSettings.arguments as ProposerSujet;
                    return ProposerSujetEncadrant(
                        // fonction: args.fonction,
                        // encadrant: args.encadrant,
                        // etudiant: args.etudiant,
                        );
                  case ListeDesSujets.routeName:
                    return const ListeDesSujets();
                  case TraiterDemande.routeName:
                    return const TraiterDemande();
                  case ApprouverDocuments.routeName:
                    return const ApprouverDocuments();
                  case DetailSujet.routeName:
                    final args = routeSettings.arguments as DetailSujet;
                    return DetailSujet(
                      sujet: args.sujet,
                      fonction: args.fonction,
                    );
                  case EnqueteSatisfaction.routeName:
                    return const EnqueteSatisfaction();
                  case Reclamation.routeName:
                    return const Reclamation();
                  default:
                    return const Authentification();
                }
              },
            );
          },
        );
      },
    );
  }
}
