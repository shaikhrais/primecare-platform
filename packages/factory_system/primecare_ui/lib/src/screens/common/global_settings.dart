import 'package:flutter/material.dart';
// ignore: unused_import

import 'package:primecare_ui/primecare_ui.dart';

class GlobalSettingsScreen extends ConsumerWidget {
  const GlobalSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
    title: 'common.settings.title',
    subtitle: 'common.settings.subtitle',
    provider: commonFeatureDataProvider('settings'),
  );
}
