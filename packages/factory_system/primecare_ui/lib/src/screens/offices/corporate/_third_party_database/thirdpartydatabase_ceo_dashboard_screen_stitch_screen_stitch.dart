import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ThirdpartydatabaseCeoDashboardScreenStitchScreenStitch extends ConsumerWidget {
  const ThirdpartydatabaseCeoDashboardScreenStitchScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'corporate.roles._third_party_database.screens.rdb_201.title',
        subtitle: 'corporate.roles._third_party_database.screens.rdb_201.subtitle',
        provider: commonFeatureDataProvider('rdb_201'),
      );
}
