import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PswDashboardScreen extends ConsumerWidget {
  const PswDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'clinical.psw.dashboard.title',
        subtitle: 'clinical.psw.dashboard.subtitle',
        provider: PswDashboardScreenDataProvider('all'),
      );
}
