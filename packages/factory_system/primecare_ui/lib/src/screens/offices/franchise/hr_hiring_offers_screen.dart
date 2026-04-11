import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class HrHiringOffersScreen extends ConsumerWidget {
  const HrHiringOffersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'HrHiringOffers',
        subtitle: '',
        provider: hrHiringDashboardDataProvider('all'),
      );
}
