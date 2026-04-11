import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class NurseClinicMyShiftsScreenStitchScreenStitch extends ConsumerWidget {
  const NurseClinicMyShiftsScreenStitchScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'clinical.roles.nurse.screens.cln_306.title',
        subtitle: 'clinical.roles.nurse.screens.cln_306.subtitle',
        provider: commonFeatureDataProvider('cln_306'),
      );
}
