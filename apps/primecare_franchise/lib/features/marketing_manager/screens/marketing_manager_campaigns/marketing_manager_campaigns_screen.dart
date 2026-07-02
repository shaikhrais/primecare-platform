// Governance - Category: view | Purpose: Coordinator layout for Marketing Manager Campaigns
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MarketingManagerCampaignsScreen extends ConsumerWidget {
  const MarketingManagerCampaignsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Marketing Manager Campaigns Coordinator'),
      ),
    );
  }
}
