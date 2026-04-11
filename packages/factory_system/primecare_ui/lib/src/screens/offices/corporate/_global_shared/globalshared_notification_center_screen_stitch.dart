import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class GlobalsharedNotificationCenterScreenStitch extends ConsumerWidget {
  const GlobalsharedNotificationCenterScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'corporate.roles._global_shared.screens.glb_109.title',
        subtitle: 'corporate.roles._global_shared.screens.glb_109.subtitle',
        provider: commonFeatureDataProvider('glb_109'),
      );
}
