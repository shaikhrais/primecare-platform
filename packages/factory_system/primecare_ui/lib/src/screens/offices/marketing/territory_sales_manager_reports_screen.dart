import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class TerritorySalesManagerReportsScreen extends ConsumerWidget {
  const TerritorySalesManagerReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Territory Sales Manager Reports',
        subtitle: '',
        provider: territorySalesManagerDashboardDataProvider('all'),
      );
}
