import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class GlobalsharedDocumentVaultScreenStitch extends ConsumerWidget {
  const GlobalsharedDocumentVaultScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'corporate.roles._global_shared.screens.glb_107.title',
        subtitle: 'corporate.roles._global_shared.screens.glb_107.subtitle',
        provider: commonFeatureDataProvider('glb_107'),
      );
}
