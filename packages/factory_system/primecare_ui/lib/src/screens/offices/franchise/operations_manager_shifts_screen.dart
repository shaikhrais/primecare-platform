import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class OperationsManagerShiftsScreen extends ConsumerWidget {
  const OperationsManagerShiftsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'OperationsManagerShifts',
        subtitle: '',
        provider: operationsManagerDashboardDataProvider('all'),
      );
}
