import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

class LocalMarketingManagerReportsScreen extends ConsumerWidget {
  const LocalMarketingManagerReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Local Marketing Manager Reports',
      provider: localMarketingManagerDashboardDataProvider('all'),
      builder: (context, ref, HeadOfMarketingDashboardViewModel vm) => AssemblyLine(
        blueprints: vm.blueprints,
      ),
    );
  }
}
