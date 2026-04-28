import 'package:flutter/material.dart';
// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/warehouse/component_warehouse.dart';
import 'package:primecare_ui/src/warehouse/offices/base_office_warehouse.dart';
// import 'package:primecare_ui/src/components/generated_placeholders/primecare_placeholders.dart';
// import 'package:primecare_ui/src/features/features_manifest.dart';

class FranchiseComponentWarehouse extends BaseOfficeWarehouse {
  @override
  Map<String, ComponentBuilder> get builders => {
    'franchiseDashboardAdapter': (context, payload) => const SizedBox.shrink(),
    'franchiseDashboardDto': (context, payload) => const SizedBox.shrink(),
    'franchiseDashboardDtoAdapter': (context, payload) =>
        const SizedBox.shrink(),
    'franchiseDashboardMapper': (context, payload) => const SizedBox.shrink(),
    'franchiseDashboardMapperAdapter': (context, payload) =>
        const SizedBox.shrink(),
    'franchiseDashboardViewModel': (context, payload) =>
        const SizedBox.shrink(),
    'franchiseDashboardViewModelAdapter': (context, payload) =>
        const SizedBox.shrink(),

    'franchiseOwnerDashboardAdapter': (context, payload) =>
        const SizedBox.shrink(),
    'franchiseOwnerDashboardDto': (context, payload) => const SizedBox.shrink(),
    'franchiseOwnerDashboardDtoAdapter': (context, payload) =>
        const SizedBox.shrink(),
    'franchiseOwnerDashboardMapper': (context, payload) =>
        const SizedBox.shrink(),
    'franchiseOwnerDashboardMapperAdapter': (context, payload) =>
        const SizedBox.shrink(),
    'franchiseOwnerDashboardViewModel': (context, payload) =>
        const SizedBox.shrink(),

    'franchiseReconciliationDashboardDto': (context, payload) =>
        const SizedBox.shrink(),
    'franchiseRefundsDashboardAdapter': (context, payload) =>
        const SizedBox.shrink(),
    'franchiseRefundsDashboardDto': (context, payload) =>
        const SizedBox.shrink(),
    'franchiseRefundsDashboardDtoAdapter': (context, payload) =>
        const SizedBox.shrink(),
    'franchiseRefundsDashboardMapper': (context, payload) =>
        const SizedBox.shrink(),
    'franchiseRefundsDashboardViewModel': (context, payload) =>
        const SizedBox.shrink(),

    'franchiseReportsDashboardAdapter': (context, payload) =>
        const SizedBox.shrink(),
    'franchiseReportsDashboardDto': (context, payload) =>
        const SizedBox.shrink(),
    'franchiseReportsDashboardDtoAdapter': (context, payload) =>
        const SizedBox.shrink(),
    'franchiseReportsDashboardMapper': (context, payload) =>
        const SizedBox.shrink(),
    'franchiseReportsDashboardViewModel': (context, payload) =>
        const SizedBox.shrink(),

    'franchiseSalesManagerDashboardDto': (context, payload) =>
        const SizedBox.shrink(),
    'franchiseSalesManagerDashboardMapper': (context, payload) =>
        const SizedBox.shrink(),

    'franchiseOnboardingChecklistForm': (context, payload) =>
        const SizedBox.shrink(),
    'addFranchiseLeadForm': (context, payload) => const SizedBox.shrink(),
    'approveFranchiseDisclosureForm': (context, payload) =>
        const SizedBox.shrink(),
    'logFranchiseevettingCallForm': (context, payload) =>
        const SizedBox.shrink(),
    'auditRoyaltyPaymentForm': (context, payload) => const SizedBox.shrink(),
    'approveRealEstateForm': (context, payload) => const SizedBox.shrink(),
  };
}
