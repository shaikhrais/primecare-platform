import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class CoordinatorProfileScreen extends StatelessWidget {
  const CoordinatorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.architecture, size: 64, color: Colors.blueGrey),
            const SizedBox(height: 24),
            Text('Coordinator Profile', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 12),
            const Text('Structural Node Scaffolded.', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
