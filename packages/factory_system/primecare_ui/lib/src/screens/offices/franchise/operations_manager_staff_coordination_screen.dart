import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class OperationsManagerStaffCoordinationScreen extends ConsumerWidget {
  const OperationsManagerStaffCoordinationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'OperationsManagerStaffCoordination',
        subtitle: '',
        provider: operationsManagerDashboardDataProvider('all'),
      );
}
