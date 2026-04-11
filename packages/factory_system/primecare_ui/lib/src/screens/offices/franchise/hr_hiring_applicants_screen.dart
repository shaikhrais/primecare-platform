import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class HrHiringApplicantsScreen extends ConsumerWidget {
  const HrHiringApplicantsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'HrHiringApplicants',
        subtitle: '',
        provider: hrHiringDashboardDataProvider('all'),
      );
}
