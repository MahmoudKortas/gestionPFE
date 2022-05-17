import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gestion_pfe/src/screens/internship_service/calander.dart';
import 'package:gestion_pfe/src/screens/internship_service/dashboard.dart';
import 'package:gestion_pfe/src/screens/internship_service/document.dart';
import 'package:gestion_pfe/src/screens/internship_service/juries_list.dart';
import 'package:gestion_pfe/src/screens/internship_service/pfe_subject.dart';
import 'package:gestion_pfe/src/screens/internship_service/result.dart';
import 'package:gestion_pfe/src/screens/internship_service/students.dart';
import 'package:gestion_pfe/src/screens/internship_service/teachers.dart';
import 'sample_feature/sample_item_list_view.dart';
import 'screens/authentification/signIn.dart';
import 'screens/authentification/signUp.dart';
import 'screens/student/follow_pfe.dart';
import 'screens/student/choose_propse_subject.dart';
import 'screens/teacher/manage_pfe.dart';
import 'screens/teacher/manage_requests.dart';
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
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case SignIn.routeName:
                    return SignIn();
                  case SignUp.routeName:
                    return SignUp();
                  case ChoosePropseSubject.routeName:
                    return const ChoosePropseSubject();
                  case FollowPFE.routeName:
                    return FollowPFE();
                  case ManageRequests.routeName:
                    return ManageRequests();
                  case ManagePFE.routeName:
                    return ManagePFE();
                  case Dashboard.routeName:
                    return Dashboard();
                  case Result.routeName:
                    return Result();
                  case PFESubject.routeName:
                    return PFESubject();
                  case Document.routeName:
                    return Document();
                  case Teachers.routeName:
                    return Teachers();
                  case Calander.routeName:
                    return Calander();
                  case Students.routeName:
                    return Students();
                  case JuriesList.routeName:
                    return JuriesList();
                  case SampleItemListView.routeName:
                    return const SampleItemListView();
                  default:
                    return SignIn();
                }
              },
            );
          },
        );
      },
    );
  }
}
