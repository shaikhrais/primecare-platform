import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class HrHiringReportsScreen extends ConsumerWidget {
  const HrHiringReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'HrHiringReports',
        subtitle: '',
        provider: hrHiringDashboardDataProvider('all'),
      );
}
