import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class CommunityOutreachDashboard extends ConsumerWidget {
  const CommunityOutreachDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Community Outreach Dashboard',
        subtitle: '',
        provider: communityOutreachDashboardDataProvider('all'),
      );
}
