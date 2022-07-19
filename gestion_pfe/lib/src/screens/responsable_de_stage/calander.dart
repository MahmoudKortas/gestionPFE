import 'package:flutter/material.dart';
import '../../resize_widget.dart';
import '../calendar/events_example.dart';

/// Displays detailed information about a SampleItem.
class Calander extends StatelessWidget {
  const Calander({Key? key}) : super(key: key);

  static const routeName = '/Calander';
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  MaterialPageRoute(builder: (_) =>  TableEventsExample(fonction: 'admin',)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
