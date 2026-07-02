// Governance - Category: view | Purpose: Coordinator layout for Community Outreach Follow Ups
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommunityOutreachFollowUpsScreen extends ConsumerWidget {
  const CommunityOutreachFollowUpsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Community Outreach Follow Ups Coordinator'),
      ),
    );
  }
}
