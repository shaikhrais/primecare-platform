import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class TerritorySalesManagerPipelineScreen extends ConsumerWidget {
  const TerritorySalesManagerPipelineScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Territory Sales Manager Pipeline',
        subtitle: '',
        provider: territorySalesManagerDashboardDataProvider('all'),
      );
}
