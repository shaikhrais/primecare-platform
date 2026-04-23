// Layer: 02_I_GOVERNANCE_BOOTSTRAPPER
// AUTO-GENERATED - DO NOT EDIT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../features/features_manifest.dart';
import '05_I_blueprint_seeder.dart';

class GovernanceBootstrapper {
  static void bootstrap() {
    BlueprintSeeder.seed();
    GovernanceRegistry.register(const ArchitecturePlanningDashboardIntent(), role: 'architecture_planning');
    GovernanceRegistry.register(const BillingAdminDashboardIntent(), role: 'billing_admin');
    GovernanceRegistry.register(const CeoDashboardIntent(), role: 'ceo');
    GovernanceRegistry.register(const CfoDashboardIntent(), role: 'cfo');
    GovernanceRegistry.register(const ClientDashboardIntent(), role: 'client');
    GovernanceRegistry.register(const ClinicDashboardIntent(), role: 'clinic');
    GovernanceRegistry.register(const ClinicalDirectorDashboardIntent(), role: 'clinical_director');
    GovernanceRegistry.register(const CommunityOutreachDashboardIntent(), role: 'community_outreach');
    GovernanceRegistry.register(const ComplianceManagerDashboardIntent(), role: 'compliance_manager');
    GovernanceRegistry.register(const CooDashboardIntent(), role: 'coo');
    GovernanceRegistry.register(const CourseArchitectDashboardIntent(), role: 'course_architect');
    GovernanceRegistry.register(CtoDashboardIntent(), role: 'cto');
    GovernanceRegistry.register(const CustomerSupportDashboardIntent(), role: 'customer_support');
    GovernanceRegistry.register(const CxDirectorDashboardIntent(), role: 'cx_director');
    GovernanceRegistry.register(const DynamicScreenDashboardIntent(), role: 'dynamic_screen');
    GovernanceRegistry.register(const FamilyDashboardIntent(), role: 'family');
    GovernanceRegistry.register(const FamilyMemberDashboardIntent(), role: 'family_member');
    GovernanceRegistry.register(const FinanceDirectorDashboardIntent(), role: 'finance_director');
    GovernanceRegistry.register(const FranchiseOwnerDashboardIntent(), role: 'franchise_owner');
    GovernanceRegistry.register(const FranchiseSalesManagerDashboardIntent(), role: 'franchise_sales_manager');
    GovernanceRegistry.register(const GeneralManagerDashboardIntent(), role: 'general_manager');
    GovernanceRegistry.register(const GuestDashboardIntent(), role: 'guest');
    GovernanceRegistry.register(const HeadOfBusDevDashboardIntent(), role: 'head_of_bus_dev');
    GovernanceRegistry.register(const HeadOfMarketingDashboardIntent(), role: 'head_of_marketing');
    GovernanceRegistry.register(const HrDirectorDashboardIntent(), role: 'hr_director');
    GovernanceRegistry.register(const HrHiringDashboardIntent(), role: 'hr_hiring');
    GovernanceRegistry.register(const IntakeCoordinatorDashboardIntent(), role: 'intake_coordinator');
    GovernanceRegistry.register(const IntakeDashboardIntent(), role: 'intake');
    GovernanceRegistry.register(const LocalMarketingManagerDashboardIntent(), role: 'local_marketing_manager');
    GovernanceRegistry.register(const OperationsManagerDashboardIntent(), role: 'operations_manager');
    GovernanceRegistry.register(const OwnerDashboardIntent(), role: 'owner');
    GovernanceRegistry.register(const PartnershipManagerDashboardIntent(), role: 'partnership_manager');
    GovernanceRegistry.register(const PatientDashboardIntent(), role: 'patient');
    GovernanceRegistry.register(const PswDashboardIntent(), role: 'psw');
    GovernanceRegistry.register(const QaDashboardIntent(), role: 'qa');
    GovernanceRegistry.register(const QualityAssuranceDashboardIntent(), role: 'quality_assurance');
    GovernanceRegistry.register(const ReceptionistDashboardIntent(), role: 'receptionist');
    GovernanceRegistry.register(const RegionalBdmDashboardIntent(), role: 'regional_bdm');
    GovernanceRegistry.register(const RegionalManagerOntarioDashboardIntent(), role: 'regional_manager_ontario');
    GovernanceRegistry.register(const RegionalManagerUsaDashboardIntent(), role: 'regional_manager_usa');
    GovernanceRegistry.register(const RmtDashboardIntent(), role: 'rmt');
    GovernanceRegistry.register(const RnDashboardIntent(), role: 'rn');
    GovernanceRegistry.register(const SchedulerDashboardIntent(), role: 'scheduler');
    GovernanceRegistry.register(const ScrumMasterDashboardIntent(), role: 'scrum_master');
    GovernanceRegistry.register(const SupportDashboardIntent(), role: 'support');
    GovernanceRegistry.register(const SystemVerificationDashboardIntent(), role: 'system_verification');
    GovernanceRegistry.register(const TerritoryExpansionManagerDashboardIntent(), role: 'territory_expansion_manager');
    GovernanceRegistry.register(const TerritorySalesManagerDashboardIntent(), role: 'territory_sales_manager');
    GovernanceRegistry.register(const TrainingCoordinatorDashboardIntent(), role: 'training_coordinator');
    GovernanceRegistry.register(const TrainingDirectorCertificateDashboardIntent(), role: 'training_director_certificate');
    GovernanceRegistry.register(const TrainingDirectorDashboardIntent(), role: 'training_director');
    GovernanceRegistry.register(const TrainingHubDashboardIntent(), role: 'training_hub');
    GovernanceRegistry.register(const VolunteerCoordinatorDashboardIntent(), role: 'volunteer_coordinator');
  }
}

