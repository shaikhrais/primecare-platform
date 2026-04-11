import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class FamilymemberFamilyProfileScreenStitch extends ConsumerWidget {
  const FamilymemberFamilyProfileScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'client_family.roles.family_member.screens.fam_515.title',
        subtitle: 'client_family.roles.family_member.screens.fam_515.subtitle',
        provider: commonFeatureDataProvider('fam_515'),
      );
}
