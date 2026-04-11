import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class HeadOfMarketingBrandAssetsScreen extends ConsumerWidget {
  const HeadOfMarketingBrandAssetsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Head Of Marketing Brand Assets',
        subtitle: '',
        provider: headOfMarketingDashboardDataProvider('all'),
      );
}
