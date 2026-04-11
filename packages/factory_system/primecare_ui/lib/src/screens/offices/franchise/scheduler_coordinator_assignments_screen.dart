import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class SchedulerCoordinatorAssignmentsScreen extends ConsumerWidget {
  const SchedulerCoordinatorAssignmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'SchedulerCoordinatorAssignments',
        subtitle: '',
        provider: schedulerDashboardDataProvider('all'),
      );
}
