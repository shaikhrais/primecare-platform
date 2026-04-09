import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/auth_service.dart';

class PswDashboardScreen extends ConsumerWidget {
  const PswDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PSW Dashboard'),
        actions: [
          IconButton(
            key: const Key('data-status-id=shared-global-psw-action-1'),
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.health_and_safety,
              size: 80,
              color: Color(0xFF03DAC6),
            ),
            const SizedBox(height: 24),
            Text(
              'Welcome, Personal Support Worker',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text('Here is your daily schedule and tasks.'),
          ],
        ),
      ),
    );
  }
}
