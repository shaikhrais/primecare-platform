import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PswClinicIncidentReportScreenStitchScreenStitch extends ConsumerWidget {
  const PswClinicIncidentReportScreenStitchScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'clinical.roles.psw.screens.cln_305.title',
        subtitle: 'clinical.roles.psw.screens.cln_305.subtitle',
        provider: commonFeatureDataProvider('cln_305'),
      );
}
