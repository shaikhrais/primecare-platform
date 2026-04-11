import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class TerritorySalesManagerLeadsScreen extends ConsumerWidget {
  const TerritorySalesManagerLeadsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Territory Sales Manager Leads',
        subtitle: '',
        provider: territorySalesManagerDashboardDataProvider('all'),
      );
}
