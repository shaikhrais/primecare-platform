import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class TerritorySalesManagerFieldActivityScreen extends ConsumerWidget {
  const TerritorySalesManagerFieldActivityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Territory Sales Manager Field Activity',
        subtitle: '',
        provider: territorySalesManagerDashboardDataProvider('all'),
      );
}
