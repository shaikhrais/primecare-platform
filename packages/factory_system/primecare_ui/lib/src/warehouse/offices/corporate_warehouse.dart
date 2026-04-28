import 'package:flutter/material.dart';
// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/warehouse/component_warehouse.dart';
import 'package:primecare_ui/src/warehouse/offices/base_office_warehouse.dart';
// import 'package:primecare_ui/src/components/generated_placeholders/primecare_placeholders.dart';

// import 'package:primecare_ui/src/features/operations_manager_dashboard/presentation/widgets/operations_manager_dashboard_screen.dart';

class CorporateComponentWarehouse extends BaseOfficeWarehouse {
  @override
  Map<String, ComponentBuilder> get builders => {
    'ceoDashboardAdapter': (context, payload) => const SizedBox.shrink(),
    'ceoDashboardDto': (context, payload) => const SizedBox.shrink(),
    'ceoDashboardDtoAdapter': (context, payload) => const SizedBox.shrink(),
    'ceoDashboardMapper': (context, payload) => const SizedBox.shrink(),
    'ceoDashboardMapperAdapter': (context, payload) => const SizedBox.shrink(),
    'ceoDashboardProvider': (context, payload) => const SizedBox.shrink(),
    'ceoDashboardScreen': (context, payload) => const SizedBox.shrink(),
    'ceoDashboardViewModel': (context, payload) => const SizedBox.shrink(),
    'ceoDashboardViewModelAdapter': (context, payload) =>
        const SizedBox.shrink(),

    'cfoDashboardAdapter': (context, payload) => const SizedBox.shrink(),
    'cfoDashboardDto': (context, payload) => const SizedBox.shrink(),
    'cfoDashboardDtoAdapter': (context, payload) => const SizedBox.shrink(),
    'cfoDashboardMapper': (context, payload) => const SizedBox.shrink(),
    'cfoDashboardMapperAdapter': (context, payload) => const SizedBox.shrink(),
    'cfoDashboardProvider': (context, payload) => const SizedBox.shrink(),
    'cfoDashboardScreen': (context, payload) => const SizedBox.shrink(),
    'cfoDashboardViewModel': (context, payload) => const SizedBox.shrink(),
    'cfoDashboardViewModelAdapter': (context, payload) =>
        const SizedBox.shrink(),

    'cooDashboardAdapter': (context, payload) => const SizedBox.shrink(),
    'cooDashboardDto': (context, payload) => const SizedBox.shrink(),
    'cooDashboardDtoAdapter': (context, payload) => const SizedBox.shrink(),
    'cooDashboardMapper': (context, payload) => const SizedBox.shrink(),
    'cooDashboardMapperAdapter': (context, payload) => const SizedBox.shrink(),
    'cooDashboardProvider': (context, payload) => const SizedBox.shrink(),
    'cooDashboardScreen': (context, payload) => const SizedBox.shrink(),
    'cooDashboardViewModel': (context, payload) => const SizedBox.shrink(),
    'cooDashboardViewModelAdapter': (context, payload) =>
        const SizedBox.shrink(),

    'generalManagerDashboardAdapter': (context, payload) =>
        const SizedBox.shrink(),
    'generalManagerDashboardDto': (context, payload) => const SizedBox.shrink(),
    'generalManagerDashboardDtoAdapter': (context, payload) =>
        const SizedBox.shrink(),
    'generalManagerDashboardMapper': (context, payload) =>
        const SizedBox.shrink(),
    'generalManagerDashboardMapperAdapter': (context, payload) =>
        const SizedBox.shrink(),
    'generalManagerDashboardViewModel': (context, payload) =>
        const SizedBox.shrink(),

    'hrManagerDashboardViewModel': (context, payload) =>
        const SizedBox.shrink(),

    'operationsManagerDashboardAdapter': (context, payload) =>
        const SizedBox.shrink(),
    'operationsManagerDashboardDto': (context, payload) =>
        const SizedBox.shrink(),
    'operationsManagerDashboardDtoAdapter': (context, payload) =>
        const SizedBox.shrink(),
    'operationsManagerDashboardMapper': (context, payload) =>
        const SizedBox.shrink(),
    'operationsManagerDashboardViewModel': (context, payload) =>
        const SizedBox.shrink(),

    'ownerDashboardAdapter': (context, payload) => const SizedBox.shrink(),
    'ownerDashboardDto': (context, payload) => const SizedBox.shrink(),
    'ownerDashboardDtoAdapter': (context, payload) => const SizedBox.shrink(),
    'ownerDashboardMapper': (context, payload) => const SizedBox.shrink(),
    'ownerDashboardMapperAdapter': (context, payload) =>
        const SizedBox.shrink(),
    'ownerDashboardViewModel': (context, payload) => const SizedBox.shrink(),
    'ownerDashboardViewModelAdapter': (context, payload) =>
        const SizedBox.shrink(),

    'regionalManagerDashboardAdapter': (context, payload) =>
        const SizedBox.shrink(),
    'regionalManagerDashboardDto': (context, payload) =>
        const SizedBox.shrink(),
    'regionalManagerDashboardMapper': (context, payload) =>
        const SizedBox.shrink(),
    'regionalManagerDashboardViewModel': (context, payload) =>
        const SizedBox.shrink(),
  };
}
