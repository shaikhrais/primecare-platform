import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class GlobalsharedGlobalProfileScreenStitch extends ConsumerWidget {
  const GlobalsharedGlobalProfileScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'corporate.roles._global_shared.screens.glb_106.title',
        subtitle: 'corporate.roles._global_shared.screens.glb_106.subtitle',
        provider: commonFeatureDataProvider('glb_106'),
      );
}
