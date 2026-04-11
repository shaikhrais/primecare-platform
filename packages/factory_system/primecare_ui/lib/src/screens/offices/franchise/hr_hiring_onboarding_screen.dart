import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class HrHiringOnboardingScreen extends ConsumerWidget {
  const HrHiringOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'HrHiringOnboarding',
        subtitle: '',
        provider: hrHiringDashboardDataProvider('all'),
      );
}
