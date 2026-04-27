// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/warehouse/component_warehouse.dart';
import 'package:primecare_ui/src/warehouse/offices/base_office_warehouse.dart';
import 'package:primecare_ui/src/components/generated_placeholders/primecare_placeholders.dart';
import 'package:primecare_ui/src/features/features_manifest.dart';

class FranchiseComponentWarehouse extends BaseOfficeWarehouse {
  @override
  Map<String, ComponentBuilder> get builders => {
    'franchiseDashboardAdapter': (context, payload) =>
        FranchisedashboardadapterPlaceholder(data: payload),
    'franchiseDashboardDto': (context, payload) =>
        FranchisedashboarddtoPlaceholder(data: payload),
    'franchiseDashboardDtoAdapter': (context, payload) =>
        FranchisedashboarddtoadapterPlaceholder(data: payload),
    'franchiseDashboardMapper': (context, payload) =>
        FranchisedashboardmapperPlaceholder(data: payload),
    'franchiseDashboardMapperAdapter': (context, payload) =>
        FranchisedashboardmapperadapterPlaceholder(data: payload),
    'franchiseDashboardViewModel': (context, payload) =>
        const FranchiseOwnerDashboardScreen(),
    'franchiseDashboardViewModelAdapter': (context, payload) =>
        FranchisedashboardviewmodeladapterPlaceholder(data: payload),

    'franchiseOwnerDashboardAdapter': (context, payload) =>
        FranchiseownerdashboardadapterPlaceholder(data: payload),
    'franchiseOwnerDashboardDto': (context, payload) =>
        FranchiseownerdashboarddtoPlaceholder(data: payload),
    'franchiseOwnerDashboardDtoAdapter': (context, payload) =>
        FranchiseownerdashboarddtoadapterPlaceholder(data: payload),
    'franchiseOwnerDashboardMapper': (context, payload) =>
        FranchiseownerdashboardmapperPlaceholder(data: payload),
    'franchiseOwnerDashboardMapperAdapter': (context, payload) =>
        FranchiseownerdashboardmapperadapterPlaceholder(data: payload),
    'franchiseOwnerDashboardViewModel': (context, payload) =>
        const FranchiseOwnerDashboardScreen(),

    'franchiseReconciliationDashboardDto': (context, payload) =>
        FranchisereconciliationdashboarddtoPlaceholder(data: payload),
    'franchiseRefundsDashboardAdapter': (context, payload) =>
        FranchiserefundsdashboardadapterPlaceholder(data: payload),
    'franchiseRefundsDashboardDto': (context, payload) =>
        FranchiserefundsdashboarddtoPlaceholder(data: payload),
    'franchiseRefundsDashboardDtoAdapter': (context, payload) =>
        FranchiserefundsdashboarddtoadapterPlaceholder(data: payload),
    'franchiseRefundsDashboardMapper': (context, payload) =>
        FranchiserefundsdashboardmapperPlaceholder(data: payload),
    'franchiseRefundsDashboardViewModel': (context, payload) =>
        const FranchiseOwnerDashboardScreen(),

    'franchiseReportsDashboardAdapter': (context, payload) =>
        FranchisereportsdashboardadapterPlaceholder(data: payload),
    'franchiseReportsDashboardDto': (context, payload) =>
        FranchisereportsdashboarddtoPlaceholder(data: payload),
    'franchiseReportsDashboardDtoAdapter': (context, payload) =>
        FranchisereportsdashboarddtoadapterPlaceholder(data: payload),
    'franchiseReportsDashboardMapper': (context, payload) =>
        FranchisereportsdashboardmapperPlaceholder(data: payload),
    'franchiseReportsDashboardViewModel': (context, payload) =>
        const FranchiseOwnerDashboardScreen(),

    'franchiseSalesManagerDashboardDto': (context, payload) =>
        FranchisesalesmanagerdashboarddtoPlaceholder(data: payload),
    'franchiseSalesManagerDashboardMapper': (context, payload) =>
        FranchisesalesmanagerdashboardmapperPlaceholder(data: payload),

    'franchiseOnboardingChecklistForm': (context, payload) =>
        FranchiseonboardingchecklistformPlaceholder(data: payload),
    'addFranchiseLeadForm': (context, payload) =>
        AddfranchiseleadformPlaceholder(data: payload),
    'approveFranchiseDisclosureForm': (context, payload) =>
        ApprovefranchisedisclosureformPlaceholder(data: payload),
    'logFranchiseevettingCallForm': (context, payload) =>
        LogfranchiseevettingcallformPlaceholder(data: payload),
    'auditRoyaltyPaymentForm': (context, payload) =>
        AuditroyaltypaymentformPlaceholder(data: payload),
    'approveRealEstateForm': (context, payload) =>
        ApproverealestateformPlaceholder(data: payload),
  };
}
