import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class TerritorySalesManagerConversionsScreen extends ConsumerWidget {
  const TerritorySalesManagerConversionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Territory Sales Manager Conversions',
        subtitle: '',
        provider: territorySalesManagerDashboardDataProvider('all'),
      );
}
