import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/screens/authentification/signIn.dart';

/// Displays detailed information about a SampleItem.
class Students extends StatelessWidget {
  Students({Key? key}) : super(key: key);

  static const routeName = '/Students';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gérer étudiants'),
      ),
      body: SingleChildScrollView(
        // controller: controller,
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: const CircleAvatar(
                  foregroundImage: AssetImage('assets/images/flutter_logo.png'),
                ),
                title: Text('SampleItem'),
                subtitle: const Text(
                    'A sufficiently long subtitle warrants three lines.'),
                trailing: const Icon(Icons.more_vert),
                isThreeLine: true,
                onTap: () {
                  /*Navigator.restorablePushNamed(
                    context,
                    FollowPFE.routeName,
                  );*/
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: const CircleAvatar(
                  foregroundImage: AssetImage('assets/images/flutter_logo.png'),
                ),
                title: Text('SampleItem'),
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
                leading: const CircleAvatar(
                  foregroundImage: AssetImage('assets/images/flutter_logo.png'),
                ),
                title: Text('SampleItem'),
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
                leading: const CircleAvatar(
                  foregroundImage: AssetImage('assets/images/flutter_logo.png'),
                ),
                title: Text('SampleItem'),
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
          ],
        ),
      ),
    );
  }
}
