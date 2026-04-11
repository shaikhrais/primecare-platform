import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class GlobalsharedAdminDashboardScreenStitch extends ConsumerWidget {
  const GlobalsharedAdminDashboardScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'corporate.roles._global_shared.screens.glb_110.title',
        subtitle: 'corporate.roles._global_shared.screens.glb_110.subtitle',
        provider: commonFeatureDataProvider('glb_110'),
      );
}
