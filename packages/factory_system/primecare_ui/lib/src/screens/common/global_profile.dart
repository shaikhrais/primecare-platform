import 'package:flutter/material.dart';
// ignore: unused_import

import 'package:primecare_ui/primecare_ui.dart';

class GlobalProfileScreen extends ConsumerWidget {
  const GlobalProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
    title: 'common.profile.title',
    subtitle: 'common.profile.subtitle',
    provider: commonFeatureDataProvider('profile'),
  );
}
