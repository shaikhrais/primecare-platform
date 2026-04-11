import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class OperationsManagerIssuesScreen extends ConsumerWidget {
  const OperationsManagerIssuesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'OperationsManagerIssues',
        subtitle: '',
        provider: operationsManagerDashboardDataProvider('all'),
      );
}
