import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class HeadOfMarketingCampaignsScreen extends ConsumerWidget {
  const HeadOfMarketingCampaignsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Marketing Campaigns',
        subtitle: '',
        provider: headOfMarketingCampaignsDataProvider('all'),
      );
}
