import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class TerritorySalesManagerCompetitorsScreen extends ConsumerWidget {
  const TerritorySalesManagerCompetitorsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Territory Sales Manager Competitors',
        subtitle: '',
        provider: territorySalesManagerDashboardDataProvider('all'),
      );
}
