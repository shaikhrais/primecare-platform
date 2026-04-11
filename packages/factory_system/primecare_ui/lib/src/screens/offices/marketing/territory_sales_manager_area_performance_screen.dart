import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class TerritorySalesManagerAreaPerformanceScreen extends ConsumerWidget {
  const TerritorySalesManagerAreaPerformanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Territory Sales Manager Area Performance',
        subtitle: '',
        provider: territorySalesManagerDashboardDataProvider('all'),
      );
}
