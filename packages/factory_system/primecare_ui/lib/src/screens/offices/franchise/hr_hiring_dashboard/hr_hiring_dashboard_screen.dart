import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class HrHiringDashboardScreen extends ConsumerWidget {
  const HrHiringDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'HrHiring',
        subtitle: '',
        provider: hrHiringDashboardDataProvider('all'),
      );
}
