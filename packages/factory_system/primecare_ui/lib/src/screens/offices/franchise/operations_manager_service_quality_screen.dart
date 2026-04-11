import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class OperationsManagerServiceQualityScreen extends ConsumerWidget {
  const OperationsManagerServiceQualityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'OperationsManagerServiceQuality',
        subtitle: '',
        provider: operationsManagerDashboardDataProvider('all'),
      );
}
