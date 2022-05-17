import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/sample_feature/logIn.dart';
import 'package:gestion_pfe/src/sample_feature/signIn.dart';
import '../settings/settings_view.dart';
import 'sample_item.dart';
import 'sujet_PFE.dart';


class SampleItemListView extends StatelessWidget {
  const SampleItemListView({
    Key? key,
    this.items = const [SampleItem(1), SampleItem(2), SampleItem(3)],
  }) : super(key: key);

  static const routeName = '/';

  final List<SampleItem> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Items'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
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
                title: Text('SampleItem ${items[0].id}'),
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
                    SignIn.routeName,
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: const CircleAvatar(
                  foregroundImage: AssetImage('assets/images/flutter_logo.png'),
                ),
                title: Text('SampleItem ${items[1].id}'),
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
                    LogIn.routeName,
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: const CircleAvatar(
                  foregroundImage: AssetImage('assets/images/flutter_logo.png'),
                ),
                title: Text('SampleItem ${items[2].id}'),
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
                    SujetPFE.routeName,
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
