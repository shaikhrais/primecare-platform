import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PartnershipmanagerPartnershipManagerPartnersScreenStitch extends ConsumerWidget {
  const PartnershipmanagerPartnershipManagerPartnersScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'business_development.roles.partnership_manager.screens.bdv_624.title',
        subtitle: 'business_development.roles.partnership_manager.screens.bdv_624.subtitle',
        provider: commonFeatureDataProvider('bdv_624'),
      );
}
