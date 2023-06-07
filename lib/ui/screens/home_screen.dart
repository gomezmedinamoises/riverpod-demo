import 'package:flutter/material.dart';
import 'package:riverpod_demo/ui/screens/provider_screen.dart';
import 'package:riverpod_demo/ui/screens/state_notifier_provider_screen.dart';
import 'package:riverpod_demo/ui/screens/state_provider_screen.dart';
import 'package:riverpod_demo/ui/screens/stream_provider_screen.dart';
import 'package:riverpod_demo/ui/widgets/re_button.dart';

import 'change_notifier_provider_screen.dart';
import 'future_provider_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ReButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProviderScreen(
                            color: Theme.of(context).colorScheme.primary)));
              },
              text: 'Provider',
            ),
            const SizedBox(height: 15),
            ReButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StateProviderScreen(
                            color: Theme.of(context).colorScheme.secondary)));
              },
              text: 'State Provider',
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: 15),
            ReButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FutureProviderScreen(
                            color: Theme.of(context).colorScheme.tertiary)));
              },
              text: 'Future Provider',
              color: Theme.of(context).colorScheme.tertiary,
            ),
            const SizedBox(height: 15),
            ReButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StreamProviderScreen(
                            color: Theme.of(context).colorScheme.error)));
              },
              text: 'Stream Provider',
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 15),
            ReButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChangeNotifierProviderScreen(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer)));
              },
              text: 'Change Notifier Provider',
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            const SizedBox(height: 15),
            ReButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StateNotifierProviderScreen(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer)));
              },
              text: 'State Notifier Provider',
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
