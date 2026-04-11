import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

class TerritorySalesManagerConversionsScreen extends ConsumerWidget {
  const TerritorySalesManagerConversionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Territory Sales Manager Conversions',
      provider: territorySalesManagerDashboardDataProvider('all'),
      builder: (context, ref, HeadOfMarketingDashboardViewModel vm) => AssemblyLine(
        blueprints: vm.blueprints,
      ),
    );
  }
}
