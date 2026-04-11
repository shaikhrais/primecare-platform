import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class SchedulerCoordinatorAppointmentCalendarScreen extends ConsumerWidget {
  const SchedulerCoordinatorAppointmentCalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'SchedulerCoordinatorAppointmentCalendar',
        subtitle: '',
        provider: schedulerDashboardDataProvider('all'),
      );
}
