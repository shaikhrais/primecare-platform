import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class SchedulerDashboard extends ConsumerWidget {
  const SchedulerDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Scheduler',
        subtitle: '',
        provider: schedulerDashboardDataProvider('all'),
      );
}
