import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ThirdpartydatabaseHeadOfBusDevDashboardScreenStitchScreenStitch extends ConsumerWidget {
  const ThirdpartydatabaseHeadOfBusDevDashboardScreenStitchScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'corporate.roles._third_party_database.screens.rdb_207.title',
        subtitle: 'corporate.roles._third_party_database.screens.rdb_207.subtitle',
        provider: commonFeatureDataProvider('rdb_207'),
      );
}
