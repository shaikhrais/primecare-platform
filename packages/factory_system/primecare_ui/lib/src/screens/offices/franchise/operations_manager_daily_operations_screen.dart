import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class OperationsManagerDailyOperationsScreen extends ConsumerWidget {
  const OperationsManagerDailyOperationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'OperationsManagerDailyOperations',
        subtitle: '',
        provider: operationsManagerDashboardDataProvider('all'),
      );
}
