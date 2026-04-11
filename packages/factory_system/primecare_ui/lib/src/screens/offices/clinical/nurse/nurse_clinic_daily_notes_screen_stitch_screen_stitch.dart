import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class NurseClinicDailyNotesScreenStitchScreenStitch extends ConsumerWidget {
  const NurseClinicDailyNotesScreenStitchScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'clinical.roles.nurse.screens.cln_304.title',
        subtitle: 'clinical.roles.nurse.screens.cln_304.subtitle',
        provider: commonFeatureDataProvider('cln_304'),
      );
}
