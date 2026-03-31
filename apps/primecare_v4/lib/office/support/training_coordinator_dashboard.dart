import 'package:flutter/material.dart';
import '../layouts/master_layout.dart';

class TrainingCoordinatorDashboardScreen extends StatelessWidget {
  const TrainingCoordinatorDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MasterLayout(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('TrainingCoordinatorDashboardScreen', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 16),
            const Text('Welcome to your personalized workspace.'),
          ],
        ),
      ),
    );
  }
}
