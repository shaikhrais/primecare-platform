import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class FranchiseownerFranchiseOwnerReportsScreenStitch extends ConsumerWidget {
  const FranchiseownerFranchiseOwnerReportsScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'franchise.roles.franchise_owner.screens.fra_812.title',
        subtitle: 'franchise.roles.franchise_owner.screens.fra_812.subtitle',
        provider: commonFeatureDataProvider('fra_812'),
      );
}
