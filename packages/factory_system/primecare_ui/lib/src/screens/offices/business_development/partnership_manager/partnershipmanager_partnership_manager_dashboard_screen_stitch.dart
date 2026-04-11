import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PartnershipmanagerPartnershipManagerDashboardScreenStitch extends ConsumerWidget {
  const PartnershipmanagerPartnershipManagerDashboardScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'business_development.roles.partnership_manager.screens.bdv_605.title',
        subtitle: 'business_development.roles.partnership_manager.screens.bdv_605.subtitle',
        provider: commonFeatureDataProvider('bdv_605'),
      );
}
