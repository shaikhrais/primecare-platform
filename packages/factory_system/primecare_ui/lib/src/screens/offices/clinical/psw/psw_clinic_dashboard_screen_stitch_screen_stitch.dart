import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PswClinicDashboardScreenStitchScreenStitch extends ConsumerWidget {
  const PswClinicDashboardScreenStitchScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'clinical.roles.psw.screens.rdb_203.title',
        subtitle: 'clinical.roles.psw.screens.rdb_203.subtitle',
        provider: commonFeatureDataProvider('rdb_203'),
      );
}
