import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/flutter_ui.dart';

class MyShiftsScreen extends ConsumerWidget {
  const MyShiftsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'My Shifts',
      subtitle: 'Manage your assigned shifts.',
      children: [
        PrimeCard(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Text(
              'My Shifts Content',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
      ],
    );
  }
}
