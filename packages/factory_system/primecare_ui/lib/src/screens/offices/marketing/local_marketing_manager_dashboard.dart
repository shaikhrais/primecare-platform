import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class LocalMarketingManagerDashboard extends ConsumerWidget {
  const LocalMarketingManagerDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'marketing.localMarketingManager.dashboard.title',
        subtitle: '',
        provider: localMarketingManagerDashboardDataProvider('all'),
      );
}
