import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class NurseClinicShiftDetailsScreenStitchScreenStitch extends ConsumerWidget {
  const NurseClinicShiftDetailsScreenStitchScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'clinical.roles.nurse.screens.cln_307.title',
        subtitle: 'clinical.roles.nurse.screens.cln_307.subtitle',
        provider: commonFeatureDataProvider('cln_307'),
      );
}
