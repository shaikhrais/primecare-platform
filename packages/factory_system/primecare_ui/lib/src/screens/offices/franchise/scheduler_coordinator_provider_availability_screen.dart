import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class SchedulerCoordinatorProviderAvailabilityScreen extends ConsumerWidget {
  const SchedulerCoordinatorProviderAvailabilityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'SchedulerCoordinatorProviderAvailability',
        subtitle: '',
        provider: schedulerDashboardDataProvider('all'),
      );
}
