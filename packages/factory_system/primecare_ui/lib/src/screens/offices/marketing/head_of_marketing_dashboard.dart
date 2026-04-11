import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class HeadOfMarketingDashboard extends ConsumerWidget {
  const HeadOfMarketingDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'HeadOfMarketing Dashboard',
        subtitle: '',
        provider: headOfMarketingDashboardDataProvider('all'),
      );
}
