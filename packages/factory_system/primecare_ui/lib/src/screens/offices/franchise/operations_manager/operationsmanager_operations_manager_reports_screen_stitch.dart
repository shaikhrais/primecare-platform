import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class OperationsmanagerOperationsManagerReportsScreenStitch extends ConsumerWidget {
  const OperationsmanagerOperationsManagerReportsScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'franchise.roles.operations_manager.screens.fra_821.title',
        subtitle: 'franchise.roles.operations_manager.screens.fra_821.subtitle',
        provider: commonFeatureDataProvider('fra_821'),
      );
}
