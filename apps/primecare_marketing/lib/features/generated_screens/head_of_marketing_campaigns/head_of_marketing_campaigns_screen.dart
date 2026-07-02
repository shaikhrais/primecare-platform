// Governance - Category: view | Purpose: Coordinator layout for Head Of Marketing Campaigns
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HeadOfMarketingCampaignsScreen extends ConsumerWidget {
  const HeadOfMarketingCampaignsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Head Of Marketing Campaigns Coordinator'),
      ),
    );
  }
}
