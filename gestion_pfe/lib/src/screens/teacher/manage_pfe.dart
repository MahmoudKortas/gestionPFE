import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/screens/authentification/signIn.dart';
import 'package:gestion_pfe/src/screens/teacher/manage_requests.dart';

/// Displays detailed information about a SampleItem.
class ManagePFE extends StatelessWidget {
  ManagePFE({Key? key}) : super(key: key);

  static const routeName = '/ManagePFE';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gèrer PFE étudiant'),
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
                title: Text('Etudiant 1'),
                subtitle: const Text(
                    'A sufficiently long subtitle warrants three lines.'),
                trailing: const Icon(Icons.more_vert),
                isThreeLine: true,
                onTap: () {
                  /*Navigator.restorablePushNamed(
                    context,
                    ManageRequests.routeName,
                  );*/
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: const CircleAvatar(
                  foregroundImage: AssetImage('assets/images/flutter_logo.png'),
                ),
                title: Text('Etudiant 2'),
                subtitle: const Text(
                    'A sufficiently long subtitle warrants three lines.'),
                trailing: const Icon(Icons.more_vert),
                isThreeLine: true,
                onTap: () {
                  /*Navigator.restorablePushNamed(
                    context,
                    ManageRequests.routeName,
                  );*/
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: const CircleAvatar(
                  foregroundImage: AssetImage('assets/images/flutter_logo.png'),
                ),
                title: Text('Etudiant 3'),
                subtitle: const Text(
                    'A sufficiently long subtitle warrants three lines.'),
                trailing: const Icon(Icons.more_vert),
                isThreeLine: true,
                onTap: () {
                  /*Navigator.restorablePushNamed(
                    context,
                    ManageRequests.routeName,
                  );*/
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: const CircleAvatar(
                  foregroundImage: AssetImage('assets/images/flutter_logo.png'),
                ),
                title: Text('Etudiant 4'),
                subtitle: const Text(
                    'A sufficiently long subtitle warrants three lines.'),
                trailing: const Icon(Icons.more_vert),
                isThreeLine: true,
                onTap: () {
                  /*Navigator.restorablePushNamed(
                    context,
                    ManageRequests.routeName,
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
