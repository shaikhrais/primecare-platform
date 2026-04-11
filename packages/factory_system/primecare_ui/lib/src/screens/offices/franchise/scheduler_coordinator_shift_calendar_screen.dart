import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class SchedulerCoordinatorShiftCalendarScreen extends ConsumerWidget {
  const SchedulerCoordinatorShiftCalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'SchedulerCoordinatorShiftCalendar',
        subtitle: '',
        provider: schedulerDashboardDataProvider('all'),
      );
}
