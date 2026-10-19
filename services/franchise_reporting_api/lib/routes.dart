// Governance - Category: middleware | Purpose: UPGRADED_BY_AI Automatically querying the synced Prisma models const data = await prisma.franchisesalesmanagercontrac...
// UPGRADED_BY_AI
import 'dart:convert';
import 'package:server_core/server_core.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:database_client/database_client.dart';

part 'src/features/franchise_sales_manager_contracts_screen_routes/franchise_sales_manager_contracts_screen_routes.dart';
part 'src/features/franchise_sales_manager_dashboard_screen_routes/franchise_sales_manager_dashboard_screen_routes.dart';
part 'src/features/franchise_sales_manager_discovery_calls_screen_routes/franchise_sales_manager_discovery_calls_screen_routes.dart';
part 'src/features/franchise_sales_manager_follow_ups_screen_routes/franchise_sales_manager_follow_ups_screen_routes.dart';
part 'src/features/franchise_sales_manager_leads_screen_routes/franchise_sales_manager_leads_screen_routes.dart';
part 'src/features/franchise_sales_manager_proposals_screen_routes/franchise_sales_manager_proposals_screen_routes.dart';
part 'src/features/franchise_sales_manager_prospects_screen_routes/franchise_sales_manager_prospects_screen_routes.dart';
part 'src/features/franchise_sales_manager_reports_screen_routes/franchise_sales_manager_reports_screen_routes.dart';
part 'src/features/franchise_sales_manager_sales_pipeline_screen_routes/franchise_sales_manager_sales_pipeline_screen_routes.dart';
part 'src/features/general_manager_dashboard_screen_routes/general_manager_dashboard_screen_routes.dart';
part 'src/features/partnership_manager_dashboard_screen_routes/partnership_manager_dashboard_screen_routes.dart';
part 'src/features/regional_bdm_dashboard_screen_routes/regional_bdm_dashboard_screen_routes.dart';
part 'src/features/regional_bdm_franchise_pipeline_screen_routes/regional_bdm_franchise_pipeline_screen_routes.dart';
part 'src/features/regional_manager_ontario_dashboard_screen_routes/regional_manager_ontario_dashboard_screen_routes.dart';
part 'src/features/regional_manager_usa_dashboard_screen_routes/regional_manager_usa_dashboard_screen_routes.dart';
part 'src/features/territory_expansion_manager_dashboard_screen_routes/territory_expansion_manager_dashboard_screen_routes.dart';
part 'src/features/family_member_dashboard_screen_routes/family_member_dashboard_screen_routes.dart';
part 'src/features/unknown_dashboard_screen_routes/unknown_dashboard_screen_routes.dart';
part 'src/features/caregiver_dashboard_screen_routes/caregiver_dashboard_screen_routes.dart';
part 'src/features/chiropractor_dashboard_screen_routes/chiropractor_dashboard_screen_routes.dart';
part 'src/features/clinical_director_dashboard_screen_routes/clinical_director_dashboard_screen_routes.dart';
part 'src/features/infection_control_dashboard_screen_routes/infection_control_dashboard_screen_routes.dart';
part 'src/features/intake_coordinator_dashboard_screen_routes/intake_coordinator_dashboard_screen_routes.dart';
part 'src/features/nurse_dashboard_screen_routes/nurse_dashboard_screen_routes.dart';
part 'src/features/physician_dashboard_screen_routes/physician_dashboard_screen_routes.dart';
part 'src/features/physiotherapist_dashboard_screen_routes/physiotherapist_dashboard_screen_routes.dart';
part 'src/features/psw_dashboard_screen_routes/psw_dashboard_screen_routes.dart';
part 'src/features/rmt_dashboard_screen_routes/rmt_dashboard_screen_routes.dart';
part 'src/features/rn_dashboard_screen_routes/rn_dashboard_screen_routes.dart';
part 'src/features/rpn_dashboard_screen_routes/rpn_dashboard_screen_routes.dart';
part 'src/features/social_worker_dashboard_screen_routes/social_worker_dashboard_screen_routes.dart';
part 'src/features/therapist_dashboard_screen_routes/therapist_dashboard_screen_routes.dart';
part 'src/features/ceo_dashboard_screen_routes/ceo_dashboard_screen_routes.dart';
part 'src/features/ceo_franchise_overview_screen_routes/ceo_franchise_overview_screen_routes.dart';
part 'src/features/cfo_dashboard_screen_routes/cfo_dashboard_screen_routes.dart';
part 'src/features/cfo_franchise_financials_screen_routes/cfo_franchise_financials_screen_routes.dart';
part 'src/features/ciso_dashboard_screen_routes/ciso_dashboard_screen_routes.dart';
part 'src/features/coo_dashboard_screen_routes/coo_dashboard_screen_routes.dart';
part 'src/features/cto_dashboard_screen_routes/cto_dashboard_screen_routes.dart';
part 'src/features/cx_director_dashboard_screen_routes/cx_director_dashboard_screen_routes.dart';
part 'src/features/finance_director_dashboard_screen_routes/finance_director_dashboard_screen_routes.dart';
part 'src/features/head_of_bus_dev_dashboard_screen_routes/head_of_bus_dev_dashboard_screen_routes.dart';
part 'src/features/head_of_marketing_dashboard_screen_routes/head_of_marketing_dashboard_screen_routes.dart';
part 'src/features/hr_director_dashboard_screen_routes/hr_director_dashboard_screen_routes.dart';
part 'src/features/hr_hiring_dashboard_screen_routes/hr_hiring_dashboard_screen_routes.dart';
part 'src/features/hr_manager_dashboard_screen_routes/hr_manager_dashboard_screen_routes.dart';
part 'src/features/it_admin_dashboard_screen_routes/it_admin_dashboard_screen_routes.dart';
part 'src/features/legal_dashboard_screen_routes/legal_dashboard_screen_routes.dart';
part 'src/features/owner_dashboard_screen_routes/owner_dashboard_screen_routes.dart';
part 'src/features/shareholder_dashboard_screen_routes/shareholder_dashboard_screen_routes.dart';
part 'src/features/training_director_dashboard_screen_routes/training_director_dashboard_screen_routes.dart';
part 'src/features/volunteer_coordinator_dashboard_screen_routes/volunteer_coordinator_dashboard_screen_routes.dart';
part 'src/features/admin_dashboard_screen_routes/admin_dashboard_screen_routes.dart';
part 'src/features/franchise_owner_appointments_screen_routes/franchise_owner_appointments_screen_routes.dart';
part 'src/features/franchise_owner_branch_overview_screen_routes/franchise_owner_branch_overview_screen_routes.dart';
part 'src/features/franchise_owner_dashboard_screen_routes/franchise_owner_dashboard_screen_routes.dart';
part 'src/features/franchise_owner_financial_snapshot_screen_routes/franchise_owner_financial_snapshot_screen_routes.dart';
part 'src/features/franchise_owner_hiring_screen_routes/franchise_owner_hiring_screen_routes.dart';
part 'src/features/franchise_owner_reports_screen_routes/franchise_owner_reports_screen_routes.dart';
part 'src/features/franchise_owner_staff_screen_routes/franchise_owner_staff_screen_routes.dart';
part 'src/features/marketing_manager_dashboard_screen_routes/marketing_manager_dashboard_screen_routes.dart';
part 'src/features/operations_manager_dashboard_screen_routes/operations_manager_dashboard_screen_routes.dart';
part 'src/features/regional_manager_dashboard_screen_routes/regional_manager_dashboard_screen_routes.dart';
part 'src/features/scheduler_dashboard_screen_routes/scheduler_dashboard_screen_routes.dart';
part 'src/features/governance_dashboard_routes/governance_dashboard_routes.dart';
part 'src/features/community_outreach_dashboard_screen_routes/community_outreach_dashboard_screen_routes.dart';
part 'src/features/local_marketing_manager_dashboard_screen_routes/local_marketing_manager_dashboard_screen_routes.dart';
part 'src/features/territory_sales_manager_dashboard_screen_routes/territory_sales_manager_dashboard_screen_routes.dart';
part 'src/features/customer_support_dashboard_screen_routes/customer_support_dashboard_screen_routes.dart';
part 'src/features/quality_assurance_dashboard_screen_routes/quality_assurance_dashboard_screen_routes.dart';
part 'src/features/training_coordinator_dashboard_screen_routes/training_coordinator_dashboard_screen_routes.dart';

class ApiRoutes extends BaseModularApiRoutes {
  final prisma = PrismaClient();


  @override
  Iterable<BaseApiRoutes> get modules => [
    FranchiseSalesManagerContractsScreenRoutes(prisma),
    FranchiseSalesManagerDashboardScreenRoutes(prisma),
    FranchiseSalesManagerDiscoveryCallsScreenRoutes(prisma),
    FranchiseSalesManagerFollowUpsScreenRoutes(prisma),
    FranchiseSalesManagerLeadsScreenRoutes(prisma),
    FranchiseSalesManagerProposalsScreenRoutes(prisma),
    FranchiseSalesManagerProspectsScreenRoutes(prisma),
    FranchiseSalesManagerReportsScreenRoutes(prisma),
    FranchiseSalesManagerSalesPipelineScreenRoutes(prisma),
    GeneralManagerDashboardScreenRoutes(prisma),
    PartnershipManagerDashboardScreenRoutes(prisma),
    RegionalBdmDashboardScreenRoutes(prisma),
    RegionalBdmFranchisePipelineScreenRoutes(prisma),
    RegionalManagerOntarioDashboardScreenRoutes(prisma),
    RegionalManagerUsaDashboardScreenRoutes(prisma),
    TerritoryExpansionManagerDashboardScreenRoutes(prisma),
    FamilyMemberDashboardScreenRoutes(prisma),
    UnknownDashboardScreenRoutes(prisma),
    CaregiverDashboardScreenRoutes(prisma),
    ChiropractorDashboardScreenRoutes(prisma),
    ClinicalDirectorDashboardScreenRoutes(prisma),
    InfectionControlDashboardScreenRoutes(prisma),
    IntakeCoordinatorDashboardScreenRoutes(prisma),
    NurseDashboardScreenRoutes(prisma),
    PhysicianDashboardScreenRoutes(prisma),
    PhysiotherapistDashboardScreenRoutes(prisma),
    PswDashboardScreenRoutes(prisma),
    RmtDashboardScreenRoutes(prisma),
    RnDashboardScreenRoutes(prisma),
    RpnDashboardScreenRoutes(prisma),
    SocialWorkerDashboardScreenRoutes(prisma),
    TherapistDashboardScreenRoutes(prisma),
    CeoDashboardScreenRoutes(prisma),
    CeoFranchiseOverviewScreenRoutes(prisma),
    CfoDashboardScreenRoutes(prisma),
    CfoFranchiseFinancialsScreenRoutes(prisma),
    CisoDashboardScreenRoutes(prisma),
    CooDashboardScreenRoutes(prisma),
    CtoDashboardScreenRoutes(prisma),
    CxDirectorDashboardScreenRoutes(prisma),
    FinanceDirectorDashboardScreenRoutes(prisma),
    HeadOfBusDevDashboardScreenRoutes(prisma),
    HeadOfMarketingDashboardScreenRoutes(prisma),
    HrDirectorDashboardScreenRoutes(prisma),
    HrHiringDashboardScreenRoutes(prisma),
    HrManagerDashboardScreenRoutes(prisma),
    ItAdminDashboardScreenRoutes(prisma),
    LegalDashboardScreenRoutes(prisma),
    OwnerDashboardScreenRoutes(prisma),
    ShareholderDashboardScreenRoutes(prisma),
    TrainingDirectorDashboardScreenRoutes(prisma),
    VolunteerCoordinatorDashboardScreenRoutes(prisma),
    AdminDashboardScreenRoutes(prisma),
    FranchiseOwnerAppointmentsScreenRoutes(prisma),
    FranchiseOwnerBranchOverviewScreenRoutes(prisma),
    FranchiseOwnerDashboardScreenRoutes(prisma),
    FranchiseOwnerFinancialSnapshotScreenRoutes(prisma),
    FranchiseOwnerHiringScreenRoutes(prisma),
    FranchiseOwnerReportsScreenRoutes(prisma),
    FranchiseOwnerStaffScreenRoutes(prisma),
    MarketingManagerDashboardScreenRoutes(prisma),
    OperationsManagerDashboardScreenRoutes(prisma),
    RegionalManagerDashboardScreenRoutes(prisma),
    SchedulerDashboardScreenRoutes(prisma),
    GovernanceDashboardRoutes(prisma),
    CommunityOutreachDashboardScreenRoutes(prisma),
    LocalMarketingManagerDashboardScreenRoutes(prisma),
    TerritorySalesManagerDashboardScreenRoutes(prisma),
    CustomerSupportDashboardScreenRoutes(prisma),
    QualityAssuranceDashboardScreenRoutes(prisma),
    TrainingCoordinatorDashboardScreenRoutes(prisma),
  ];
}
