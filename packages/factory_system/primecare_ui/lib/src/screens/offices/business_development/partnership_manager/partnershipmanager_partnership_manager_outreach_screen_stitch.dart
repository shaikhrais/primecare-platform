import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PartnershipmanagerPartnershipManagerOutreachScreenStitch extends ConsumerWidget {
  const PartnershipmanagerPartnershipManagerOutreachScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'business_development.roles.partnership_manager.screens.bdv_625.title',
        subtitle: 'business_development.roles.partnership_manager.screens.bdv_625.subtitle',
        provider: commonFeatureDataProvider('bdv_625'),
      );
}
