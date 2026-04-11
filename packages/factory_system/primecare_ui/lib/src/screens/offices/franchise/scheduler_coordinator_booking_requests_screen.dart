import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class SchedulerCoordinatorBookingRequestsScreen extends ConsumerWidget {
  const SchedulerCoordinatorBookingRequestsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'SchedulerCoordinatorBookingRequests',
        subtitle: '',
        provider: schedulerDashboardDataProvider('all'),
      );
}
