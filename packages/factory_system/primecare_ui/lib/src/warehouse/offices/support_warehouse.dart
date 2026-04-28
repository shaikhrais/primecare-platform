import 'package:flutter/material.dart';
// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/warehouse/component_warehouse.dart';
import 'package:primecare_ui/src/warehouse/offices/base_office_warehouse.dart';
// import 'package:primecare_ui/src/components/generated_placeholders/primecare_placeholders.dart';
// import 'package:primecare_ui/src/features/features_manifest.dart';

class SupportComponentWarehouse extends BaseOfficeWarehouse {
  @override
  Map<String, ComponentBuilder> get builders => {
    'customerSupportDashboardAdapter': (context, payload) =>
        const SizedBox.shrink(),
    'customerSupportDashboardDto': (context, payload) =>
        const SizedBox.shrink(),
    'customerSupportDashboardDtoAdapter': (context, payload) =>
        const SizedBox.shrink(),
    'customerSupportDashboardMapper': (context, payload) =>
        const SizedBox.shrink(),
    'customerSupportDashboardViewModel': (context, payload) =>
        const SizedBox.shrink(),

    'itAdminDashboardAdapter': (context, payload) => const SizedBox.shrink(),
    'itAdminDashboardDto': (context, payload) => const SizedBox.shrink(),
    'itAdminDashboardMapper': (context, payload) => const SizedBox.shrink(),
    'itAdminDashboardViewModel': (context, payload) =>
        const SizedBox.shrink(), // Using customer support for IT for now

    'createCannedResponseForm': (context, payload) => const SizedBox.shrink(),
    'resolveTicketForm': (context, payload) => const SizedBox.shrink(),
    'escalateTechnicalIssueForm': (context, payload) => const SizedBox.shrink(),
    'assignCarePodForm': (context, payload) => const SizedBox.shrink(),
    'logEmployeeGrievanceForm': (context, payload) => const SizedBox.shrink(),

    'auditSystemLogsForm': (context, payload) => const SizedBox.shrink(),
    'approveSystemAccessForm': (context, payload) => const SizedBox.shrink(),
    'provisionNewHardwareForm': (context, payload) => const SizedBox.shrink(),
    'rollbackSystemVersionForm': (context, payload) => const SizedBox.shrink(),
  };
}
