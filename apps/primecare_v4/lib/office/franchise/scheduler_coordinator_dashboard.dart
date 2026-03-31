import 'package:flutter/material.dart';
import '../layouts/master_layout.dart';

class SchedulerCoordinatorDashboardScreen extends StatelessWidget {
  const SchedulerCoordinatorDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MasterLayout(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('SchedulerCoordinatorDashboardScreen', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 16),
            const Text('Welcome to your personalized workspace.'),
          ],
        ),
      ),
    );
  }
}
