import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/screens/teacher/manage_pfe.dart';

import '../internship_service/dashboard.dart';
import '../teacher/manage_requests.dart';
import 'follow_pfe.dart';

/// Displays detailed information about a SampleItem.
class ChoosePropseSubject extends StatelessWidget {
  const ChoosePropseSubject({Key? key}) : super(key: key);

  static const routeName = '/Choose_propse_subject';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choisir ou proposer votre sujet '),
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
                title: Text('Suivre PFE'),
                subtitle: const Text(
                    'A sufficiently long subtitle warrants three lines.'),
                trailing: const Icon(Icons.more_vert),
                isThreeLine: true,
                onTap: () {
                  Navigator.restorablePushNamed(
                    context,
                    FollowPFE.routeName,
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: const CircleAvatar(
                  foregroundImage: AssetImage('assets/images/flutter_logo.png'),
                ),
                title: Text('Gerer demande de sujets'),
                subtitle: const Text(
                    'A sufficiently long subtitle warrants three lines.'),
                trailing: const Icon(Icons.more_vert),
                isThreeLine: true,
                onTap: () {
                  // Navigate to the details page. If the user leaves and returns to
                  // the app after it has been killed while running in the
                  // background, the navigation stack is restored.
                  Navigator.restorablePushNamed(
                    context,
                    ManageRequests.routeName,
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: const CircleAvatar(
                  foregroundImage: AssetImage('assets/images/flutter_logo.png'),
                ),
                title: Text('Tableau de bord'),
                subtitle: const Text(
                    'A sufficiently long subtitle warrants three lines.'),
                trailing: const Icon(Icons.more_vert),
                isThreeLine: true,
                onTap: () {
                  // Navigate to the details page. If the user leaves and returns to
                  // the app after it has been killed while running in the
                  // background, the navigation stack is restored.
                  Navigator.restorablePushNamed(
                    context,
                    Dashboard.routeName,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
