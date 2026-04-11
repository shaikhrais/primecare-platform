import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class FranchiseOwnerAppointmentsScreen extends ConsumerWidget {
  const FranchiseOwnerAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'FranchiseOwnerAppointments',
        subtitle: '',
        provider: franchiseOwnerDashboardDataProvider('all'),
      );
}
