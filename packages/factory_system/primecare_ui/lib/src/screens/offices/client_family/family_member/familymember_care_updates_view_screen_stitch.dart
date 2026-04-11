import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class FamilymemberCareUpdatesViewScreenStitch extends ConsumerWidget {
  const FamilymemberCareUpdatesViewScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'client_family.roles.family_member.screens.fam_512.title',
        subtitle: 'client_family.roles.family_member.screens.fam_512.subtitle',
        provider: commonFeatureDataProvider('fam_512'),
      );
}
