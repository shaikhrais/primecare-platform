import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class HeadOfMarketingContentApprovalScreen extends ConsumerWidget {
  const HeadOfMarketingContentApprovalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Head Of Marketing Content Approval',
        subtitle: '',
        provider: headOfMarketingDashboardDataProvider('all'),
      );
}
