import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class HrHiringCredentialsScreen extends ConsumerWidget {
  const HrHiringCredentialsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'HrHiringCredentials',
        subtitle: '',
        provider: hrHiringDashboardDataProvider('all'),
      );
}
