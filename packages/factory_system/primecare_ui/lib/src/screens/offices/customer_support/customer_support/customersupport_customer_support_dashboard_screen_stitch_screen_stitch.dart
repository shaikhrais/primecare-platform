import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class CustomersupportCustomerSupportDashboardScreenStitchScreenStitch extends ConsumerWidget {
  const CustomersupportCustomerSupportDashboardScreenStitchScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'customer_support.roles.customer_support.screens.rdb_205.title',
        subtitle: 'customer_support.roles.customer_support.screens.rdb_205.subtitle',
        provider: commonFeatureDataProvider('rdb_205'),
      );
}
