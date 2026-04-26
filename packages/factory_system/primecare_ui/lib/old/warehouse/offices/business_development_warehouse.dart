// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/warehouse/01_I_component_warehouse.dart';
import 'package:primecare_ui/src/warehouse/offices/base_office_warehouse.dart';
import 'package:primecare_ui/src/components/generated_placeholders/01_I_primecare_placeholders.dart';
import 'package:primecare_ui/src/features/features_manifest.dart';

class BusinessDevelopmentComponentWarehouse extends BaseOfficeWarehouse {
  @override
  Map<String, ComponentBuilder> get builders => {
    'communityOutreachDashboardAdapter': (context, payload) =>
        CommunityoutreachdashboardadapterPlaceholder(data: payload),
    'communityOutreachDashboardDto': (context, payload) =>
        CommunityoutreachdashboarddtoPlaceholder(data: payload),
    'communityOutreachDashboardDtoAdapter': (context, payload) =>
        CommunityoutreachdashboarddtoadapterPlaceholder(data: payload),
    'communityOutreachDashboardMapper': (context, payload) =>
        CommunityoutreachdashboardmapperPlaceholder(data: payload),
    'communityOutreachDashboardViewModel': (context, payload) =>
        const CommunityOutreachDashboardScreen(),

    'headOfBusDevDashboardAdapter': (context, payload) =>
        HeadofbusdevdashboardadapterPlaceholder(data: payload),
    'headOfBusDevDashboardDto': (context, payload) =>
        HeadofbusdevdashboarddtoPlaceholder(data: payload),
    'headOfBusDevDashboardDtoAdapter': (context, payload) =>
        HeadofbusdevdashboarddtoadapterPlaceholder(data: payload),
    'headOfBusDevDashboardMapper': (context, payload) =>
        HeadofbusdevdashboardmapperPlaceholder(data: payload),
    'headOfBusDevDashboardMapperAdapter': (context, payload) =>
        HeadofbusdevdashboardmapperadapterPlaceholder(data: payload),
    'headOfBusDevDashboardViewModel': (context, payload) =>
        const HeadOfBusDevDashboardScreen(),

    'partnershipManagerDashboardAdapter': (context, payload) =>
        PartnershipmanagerdashboardadapterPlaceholder(data: payload),
    'partnershipManagerDashboardDto': (context, payload) =>
        PartnershipmanagerdashboarddtoPlaceholder(data: payload),
    'partnershipManagerDashboardMapper': (context, payload) =>
        PartnershipmanagerdashboardmapperPlaceholder(data: payload),
    'partnershipManagerDashboardViewModel': (context, payload) =>
        const PartnershipManagerDashboardScreen(),

    'regionalBdmDashboardAdapter': (context, payload) =>
        RegionalbdmdashboardadapterPlaceholder(data: payload),
    'regionalBdmDashboardDto': (context, payload) =>
        RegionalbdmdashboarddtoPlaceholder(data: payload),
    'regionalBdmDashboardMapper': (context, payload) =>
        RegionalbdmdashboardmapperPlaceholder(data: payload),
    'regionalBdmDashboardViewModel': (context, payload) =>
        const RegionalBdmDashboardScreen(),

    'assignLeadForm': (context, payload) =>
        AssignleadformPlaceholder(data: payload),
    'nurtureLocalizedLeadForm': (context, payload) =>
        NurturelocalizedleadformPlaceholder(data: payload),
    'trackPartnershipRoiForm': (context, payload) =>
        TrackpartnershiproiformPlaceholder(data: payload),
    'scheduleOutreachEventForm': (context, payload) =>
        ScheduleoutreacheventformPlaceholder(data: payload),
    'submitSalesProposalForm': (context, payload) =>
        SubmitsalesproposalformPlaceholder(data: payload),
  };
}
