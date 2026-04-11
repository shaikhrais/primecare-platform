import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class OperationsManagerAttendanceScreen extends ConsumerWidget {
  const OperationsManagerAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'OperationsManagerAttendance',
        subtitle: '',
        provider: operationsManagerDashboardDataProvider('all'),
      );
}
