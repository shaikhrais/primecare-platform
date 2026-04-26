// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/warehouse/01_I_component_warehouse.dart';
import 'package:primecare_ui/src/warehouse/offices/base_office_warehouse.dart';
import 'package:primecare_ui/src/components/generated_placeholders/01_I_primecare_placeholders.dart';
import 'package:primecare_ui/src/features/features_manifest.dart';

class SupportComponentWarehouse extends BaseOfficeWarehouse {
  @override
  Map<String, ComponentBuilder> get builders => {
    'customerSupportDashboardAdapter': (context, payload) =>
        CustomersupportdashboardadapterPlaceholder(data: payload),
    'customerSupportDashboardDto': (context, payload) =>
        CustomersupportdashboarddtoPlaceholder(data: payload),
    'customerSupportDashboardDtoAdapter': (context, payload) =>
        CustomersupportdashboarddtoadapterPlaceholder(data: payload),
    'customerSupportDashboardMapper': (context, payload) =>
        CustomersupportdashboardmapperPlaceholder(data: payload),
    'customerSupportDashboardViewModel': (context, payload) =>
        const CustomerSupportDashboardScreen(),

    'itAdminDashboardAdapter': (context, payload) =>
        ItadmindashboardadapterPlaceholder(data: payload),
    'itAdminDashboardDto': (context, payload) =>
        ItadmindashboarddtoPlaceholder(data: payload),
    'itAdminDashboardMapper': (context, payload) =>
        ItadmindashboardmapperPlaceholder(data: payload),
    'itAdminDashboardViewModel': (context, payload) =>
        const CustomerSupportDashboardScreen(), // Using customer support for IT for now

    'createCannedResponseForm': (context, payload) =>
        CreatecannedresponseformPlaceholder(data: payload),
    'resolveTicketForm': (context, payload) =>
        ResolveticketformPlaceholder(data: payload),
    'escalateTechnicalIssueForm': (context, payload) =>
        EscalatetechnicalissueformPlaceholder(data: payload),
    'assignCarePodForm': (context, payload) =>
        AssigncarepodformPlaceholder(data: payload),
    'logEmployeeGrievanceForm': (context, payload) =>
        LogemployeegrievanceformPlaceholder(data: payload),

    'auditSystemLogsForm': (context, payload) =>
        AuditsystemlogsformPlaceholder(data: payload),
    'approveSystemAccessForm': (context, payload) =>
        ApprovesystemaccessformPlaceholder(data: payload),
    'provisionNewHardwareForm': (context, payload) =>
        ProvisionnewhardwareformPlaceholder(data: payload),
    'rollbackSystemVersionForm': (context, payload) =>
        RollbacksystemversionformPlaceholder(data: payload),
  };
}
