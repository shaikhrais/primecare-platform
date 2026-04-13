import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: unused_import
import 'package:primecare_core/flutter_core.dart';
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
