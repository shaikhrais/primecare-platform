import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class LocalMarketingManagerCampaignsScreen extends ConsumerWidget {
  const LocalMarketingManagerCampaignsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Local Marketing Manager Campaigns',
        subtitle: '',
        provider: localMarketingManagerDashboardDataProvider('all'),
      );
}
