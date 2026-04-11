import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class CustomersupportSupportReportsScreenStitch extends ConsumerWidget {
  const CustomersupportSupportReportsScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'customer_support.roles.customer_support.screens.sup_406.title',
        subtitle: 'customer_support.roles.customer_support.screens.sup_406.subtitle',
        provider: commonFeatureDataProvider('sup_406'),
      );
}
