import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PartnershipmanagerPartnershipManagerProposalsScreenStitch extends ConsumerWidget {
  const PartnershipmanagerPartnershipManagerProposalsScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'business_development.roles.partnership_manager.screens.bdv_627.title',
        subtitle: 'business_development.roles.partnership_manager.screens.bdv_627.subtitle',
        provider: commonFeatureDataProvider('bdv_627'),
      );
}
