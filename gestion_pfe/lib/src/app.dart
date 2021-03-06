import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'custom_theme.dart';
import 'screens/accueil/accueil_enseignant.dart';
import 'screens/accueil/accueil_etudiant.dart';
import 'screens/responsable_de_stage/calander.dart';
import 'screens/responsable_de_stage/dashboard.dart';
import 'screens/responsable_de_stage/gerer_document.dart';
import 'screens/responsable_de_stage/gerer_liste_des_juries_list.dart';
import 'screens/responsable_de_stage/gerer_sujets_pfe.dart';
import 'screens/responsable_de_stage/gerer_etudiant.dart';
import 'screens/responsable_de_stage/gerer_enseignants.dart';
import 'screens/authentification/authentification.dart';
import 'screens/authentification/inscription.dart';
import 'screens/subjects/detail_sujet.dart';
import 'screens/subjects/proposer_sujet.dart';
import 'screens/subjects/consulter_planning.dart';
import 'screens/etudiant/liste_des_sujets.dart';
import 'screens/enseignant/gerer_demande_des_sujets.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

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
                  case AccueilEnseignant.routeName:
                    final args = routeSettings.arguments as AccueilEnseignant;
                    return  AccueilEnseignant(enseignant: args.enseignant);
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
                  case GererEnseignant.routeName:
                    return const GererEnseignant();
                  case Calander.routeName:
                    return const Calander();
                  case GererEtudiant.routeName:
                    return const GererEtudiant();
                  case GererListeDesJuries.routeName:
                    return const GererListeDesJuries();
                  case ProposerSujet.routeName:
                    final args = routeSettings.arguments as ProposerSujet;
                    return ProposerSujet(
                      fonction: args.fonction,
                      enseignant: args.enseignant,
                      etudiant: args.etudiant,
                    );
                  case ListeDesSujets.routeName:
                    return const ListeDesSujets();
                  case DetailSujet.routeName:
                    final args = routeSettings.arguments as DetailSujet;
                    return DetailSujet(
                      doc: args.doc,
                      fonction: args.fonction,
                    );
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
