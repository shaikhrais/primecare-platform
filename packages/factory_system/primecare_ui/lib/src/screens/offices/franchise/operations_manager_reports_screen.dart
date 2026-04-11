import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class OperationsManagerReportsScreen extends ConsumerWidget {
  const OperationsManagerReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'OperationsManagerReports',
        subtitle: '',
        provider: operationsManagerDashboardDataProvider('all'),
      );
}
