import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class TerritorySalesManagerDashboard extends ConsumerWidget {
  const TerritorySalesManagerDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'marketing.territorySalesManager.dashboard.title',
        subtitle: '',
        provider: territorySalesManagerDashboardDataProvider('all'),
      );
}
