import 'package:flutter/material.dart';

import '../../resize_widget.dart';
import '../calendar/events_example.dart';

/// Displays detailed information about a SampleItem.
class ConsulterPlanning extends StatelessWidget {
  const ConsulterPlanning({Key? key}) : super(key: key);

  static const routeName = '/ConsulterPlanning';
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suivre PFE'),
      ),
      body: Center(
        child: resiseWidget(
          context: context,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text('Events'),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) =>  TableEventsExample(fonction: 'SS',)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
