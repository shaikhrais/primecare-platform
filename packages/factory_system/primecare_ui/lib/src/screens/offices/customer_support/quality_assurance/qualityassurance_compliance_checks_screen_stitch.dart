import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class QualityassuranceComplianceChecksScreenStitch extends ConsumerWidget {
  const QualityassuranceComplianceChecksScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'customer_support.roles.quality_assurance.screens.sup_427.title',
        subtitle: 'customer_support.roles.quality_assurance.screens.sup_427.subtitle',
        provider: commonFeatureDataProvider('sup_427'),
      );
}
