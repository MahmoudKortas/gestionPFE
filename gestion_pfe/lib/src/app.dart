import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'custom_theme.dart';
import 'screens/internship_service/calander.dart';
import 'screens/internship_service/dashboard.dart';
import 'screens/internship_service/document.dart';
import 'screens/internship_service/juries_list.dart';
import 'screens/internship_service/pfe_subject.dart';
import 'screens/internship_service/result.dart';
import 'screens/internship_service/students.dart';
import 'screens/internship_service/teachers.dart';
import 'screens/authentification/sign_in.dart';
import 'screens/authentification/sign_up.dart';
import 'screens/subjects/propose_subject.dart';
import 'screens/student/follow_pfe.dart';
import 'screens/student/choose_propse_subject.dart';
import 'screens/subjects/subjects_list.dart';
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
          darkTheme:lightTheme, //darkTheme,
          theme: lightTheme,
          themeMode: ThemeMode.system,
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
                    return const SignUp();
                  case ChoosePropseSubject.routeName:
                    return const ChoosePropseSubject();
                  case FollowPFE.routeName:
                    return const FollowPFE();
                  case ManageRequests.routeName:
                    return const ManageRequests();
                  case ManagePFE.routeName:
                    return const ManagePFE();
                  case Dashboard.routeName:
                    return const Dashboard();
                  case Result.routeName:
                    return const Result();
                  case PFESubject.routeName:
                    return const PFESubject();
                  case Document.routeName:
                    return const Document();
                  case Teachers.routeName:
                    return const Teachers();
                  case Calander.routeName:
                    return const Calander();
                  case Students.routeName:
                    return const Students();
                  case JuriesList.routeName:
                    return const JuriesList();
                  case ProposeSubject.routeName:
                    return const ProposeSubject();
                  case SubjectsList.routeName:
                    return const SubjectsList();
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
