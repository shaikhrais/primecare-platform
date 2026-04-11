import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class QualityassuranceCorrectiveActionsScreenStitch extends ConsumerWidget {
  const QualityassuranceCorrectiveActionsScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'customer_support.roles.quality_assurance.screens.sup_425.title',
        subtitle: 'customer_support.roles.quality_assurance.screens.sup_425.subtitle',
        provider: commonFeatureDataProvider('sup_425'),
      );
}
