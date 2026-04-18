import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class CampaignAnalytics extends ConsumerWidget {
  const CampaignAnalytics({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const PageTemplate(
      title: 'CampaignAnalytics',
      subtitle: 'Auto-scaffolded module',
      kpiCards: SizedBox(),
      child: Center(child: Text('Provisioning...')),
    );
  }
}
