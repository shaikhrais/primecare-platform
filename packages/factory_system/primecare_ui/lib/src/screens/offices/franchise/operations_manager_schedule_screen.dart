import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class OperationsManagerScheduleScreen extends ConsumerWidget {
  const OperationsManagerScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'OperationsManagerSchedule',
        subtitle: '',
        provider: operationsManagerDashboardDataProvider('all'),
      );
}
