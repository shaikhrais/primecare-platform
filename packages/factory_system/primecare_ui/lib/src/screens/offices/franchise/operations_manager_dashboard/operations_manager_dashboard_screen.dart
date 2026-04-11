import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class OperationsManagerDashboardScreen extends ConsumerWidget {
  const OperationsManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'OperationsManager',
        subtitle: '',
        provider: operationsManagerDashboardDataProvider('all'),
      );
}
