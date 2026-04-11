import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class BillingAdminDashboardScreen extends ConsumerWidget {
  const BillingAdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'BillingAdmin',
        subtitle: '',
        provider: billingAdminDashboardDataProvider('all'),
      );
}
