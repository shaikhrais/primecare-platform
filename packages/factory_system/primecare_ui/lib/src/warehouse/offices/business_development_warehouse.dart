import 'package:flutter/material.dart';
// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/warehouse/component_warehouse.dart';
import 'package:primecare_ui/src/warehouse/offices/base_office_warehouse.dart';
// import 'package:primecare_ui/src/components/generated_placeholders/primecare_placeholders.dart';
// import 'package:primecare_ui/src/features/features_manifest.dart';

class BusinessDevelopmentComponentWarehouse extends BaseOfficeWarehouse {
  @override
  Map<String, ComponentBuilder> get builders => {
    'communityOutreachDashboardAdapter': (context, payload) =>
        const SizedBox.shrink(),
    'communityOutreachDashboardDto': (context, payload) =>
        const SizedBox.shrink(),
    'communityOutreachDashboardDtoAdapter': (context, payload) =>
        const SizedBox.shrink(),
    'communityOutreachDashboardMapper': (context, payload) =>
        const SizedBox.shrink(),
    'communityOutreachDashboardViewModel': (context, payload) =>
        const SizedBox.shrink(),

    'headOfBusDevDashboardAdapter': (context, payload) =>
        const SizedBox.shrink(),
    'headOfBusDevDashboardDto': (context, payload) => const SizedBox.shrink(),
    'headOfBusDevDashboardDtoAdapter': (context, payload) =>
        const SizedBox.shrink(),
    'headOfBusDevDashboardMapper': (context, payload) =>
        const SizedBox.shrink(),
    'headOfBusDevDashboardMapperAdapter': (context, payload) =>
        const SizedBox.shrink(),
    'headOfBusDevDashboardViewModel': (context, payload) =>
        const SizedBox.shrink(),

    'partnershipManagerDashboardAdapter': (context, payload) =>
        const SizedBox.shrink(),
    'partnershipManagerDashboardDto': (context, payload) =>
        const SizedBox.shrink(),
    'partnershipManagerDashboardMapper': (context, payload) =>
        const SizedBox.shrink(),
    'partnershipManagerDashboardViewModel': (context, payload) =>
        const SizedBox.shrink(),

    'regionalBdmDashboardAdapter': (context, payload) =>
        const SizedBox.shrink(),
    'regionalBdmDashboardDto': (context, payload) => const SizedBox.shrink(),
    'regionalBdmDashboardMapper': (context, payload) => const SizedBox.shrink(),
    'regionalBdmDashboardViewModel': (context, payload) =>
        const SizedBox.shrink(),

    'assignLeadForm': (context, payload) => const SizedBox.shrink(),
    'nurtureLocalizedLeadForm': (context, payload) => const SizedBox.shrink(),
    'trackPartnershipRoiForm': (context, payload) => const SizedBox.shrink(),
    'scheduleOutreachEventForm': (context, payload) => const SizedBox.shrink(),
    'submitSalesProposalForm': (context, payload) => const SizedBox.shrink(),
  };
}
