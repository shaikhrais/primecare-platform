import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class SchedulerCoordinatorOpenShiftsScreen extends ConsumerWidget {
  const SchedulerCoordinatorOpenShiftsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'SchedulerCoordinatorOpenShifts',
        subtitle: '',
        provider: schedulerDashboardDataProvider('all'),
      );
}
