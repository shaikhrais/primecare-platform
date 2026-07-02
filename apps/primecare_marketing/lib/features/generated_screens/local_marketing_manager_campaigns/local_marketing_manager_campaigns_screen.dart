// Governance - Category: view | Purpose: Coordinator layout for Local Marketing Manager Campaigns
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalMarketingManagerCampaignsScreen extends ConsumerWidget {
  const LocalMarketingManagerCampaignsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Local Marketing Manager Campaigns Coordinator'),
      ),
    );
  }
}
