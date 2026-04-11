import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ClientClientDashboardScreenStitch extends ConsumerWidget {
  const ClientClientDashboardScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'client_family.roles.client.screens.cli_501.title',
        subtitle: 'client_family.roles.client.screens.cli_501.subtitle',
        provider: commonFeatureDataProvider('cli_501'),
      );
}
