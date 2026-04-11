import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class UnassignedAppRoutesgeneralManagerDashboardScreenStitch extends ConsumerWidget {
  const UnassignedAppRoutesgeneralManagerDashboardScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'business_development.roles._unassigned.screens.bdv_604.title',
        subtitle: 'business_development.roles._unassigned.screens.bdv_604.subtitle',
        provider: commonFeatureDataProvider('bdv_604'),
      );
}
