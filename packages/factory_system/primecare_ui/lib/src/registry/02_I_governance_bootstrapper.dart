// Layer: 02_I_GOVERNANCE_BOOTSTRAPPER
// AUTO-GENERATED - DO NOT EDIT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../features/features_manifest.dart';
import '05_I_blueprint_seeder.dart';

class GovernanceBootstrapper {
  static void bootstrap() {
    BlueprintSeeder.seed();
    GovernanceRegistry.register(
      ArchitecturePlanningDashboardIntent(),
      role: 'architecture_planning',
    );
    GovernanceRegistry.register(
      BillingAdminDashboardIntent(),
      role: 'billing_admin',
    );
    GovernanceRegistry.register(CeoDashboardIntent(), role: 'ceo');
    GovernanceRegistry.register(CfoDashboardIntent(), role: 'cfo');
    GovernanceRegistry.register(ClientDashboardIntent(), role: 'client');
    GovernanceRegistry.register(ClinicDashboardIntent(), role: 'clinic');
    GovernanceRegistry.register(
      ClinicalDirectorDashboardIntent(),
      role: 'clinical_director',
    );
    GovernanceRegistry.register(
      CommunityOutreachDashboardIntent(),
      role: 'community_outreach',
    );
    GovernanceRegistry.register(
      ComplianceManagerDashboardIntent(),
      role: 'compliance_manager',
    );
    GovernanceRegistry.register(CooDashboardIntent(), role: 'coo');
    GovernanceRegistry.register(
      CourseArchitectDashboardIntent(),
      role: 'course_architect',
    );
    GovernanceRegistry.register(CtoDashboardIntent(), role: 'cto');
    GovernanceRegistry.register(
      CustomerSupportDashboardIntent(),
      role: 'customer_support',
    );
    GovernanceRegistry.register(
      CxDirectorDashboardIntent(),
      role: 'cx_director',
    );
    GovernanceRegistry.register(
      DynamicScreenDashboardIntent(),
      role: 'dynamic_screen',
    );
    GovernanceRegistry.register(FamilyDashboardIntent(), role: 'family');
    GovernanceRegistry.register(
      FamilyMemberDashboardIntent(),
      role: 'family_member',
    );
    GovernanceRegistry.register(
      FinanceDirectorDashboardIntent(),
      role: 'finance_director',
    );
    GovernanceRegistry.register(
      FranchiseOwnerDashboardIntent(),
      role: 'franchise_owner',
    );
    GovernanceRegistry.register(
      FranchiseSalesManagerDashboardIntent(),
      role: 'franchise_sales_manager',
    );
    GovernanceRegistry.register(
      GeneralManagerDashboardIntent(),
      role: 'general_manager',
    );
    GovernanceRegistry.register(GuestDashboardIntent(), role: 'guest');
    GovernanceRegistry.register(
      HeadOfBusDevDashboardIntent(),
      role: 'head_of_bus_dev',
    );
    GovernanceRegistry.register(
      HeadOfMarketingDashboardIntent(),
      role: 'head_of_marketing',
    );
    GovernanceRegistry.register(
      HrDirectorDashboardIntent(),
      role: 'hr_director',
    );
    GovernanceRegistry.register(HrHiringDashboardIntent(), role: 'hr_hiring');
    GovernanceRegistry.register(
      IntakeCoordinatorDashboardIntent(),
      role: 'intake_coordinator',
    );
    GovernanceRegistry.register(IntakeDashboardIntent(), role: 'intake');
    GovernanceRegistry.register(
      LocalMarketingManagerDashboardIntent(),
      role: 'local_marketing_manager',
    );
    GovernanceRegistry.register(
      OperationsManagerDashboardIntent(),
      role: 'operations_manager',
    );
    GovernanceRegistry.register(OwnerDashboardIntent(), role: 'owner');
    GovernanceRegistry.register(
      PartnershipManagerDashboardIntent(),
      role: 'partnership_manager',
    );
    GovernanceRegistry.register(PatientDashboardIntent(), role: 'patient');
    GovernanceRegistry.register(PswDashboardIntent(), role: 'psw');
    GovernanceRegistry.register(QaDashboardIntent(), role: 'qa');
    GovernanceRegistry.register(
      QualityAssuranceDashboardIntent(),
      role: 'quality_assurance',
    );
    GovernanceRegistry.register(
      ReceptionistDashboardIntent(),
      role: 'receptionist',
    );
    GovernanceRegistry.register(
      RegionalBdmDashboardIntent(),
      role: 'regional_bdm',
    );
    GovernanceRegistry.register(
      RegionalManagerOntarioDashboardIntent(),
      role: 'regional_manager_ontario',
    );
    GovernanceRegistry.register(
      RegionalManagerUsaDashboardIntent(),
      role: 'regional_manager_usa',
    );
    GovernanceRegistry.register(RmtDashboardIntent(), role: 'rmt');
    GovernanceRegistry.register(RnDashboardIntent(), role: 'rn');
    GovernanceRegistry.register(SchedulerDashboardIntent(), role: 'scheduler');
    GovernanceRegistry.register(
      ScrumMasterDashboardIntent(),
      role: 'scrum_master',
    );
    GovernanceRegistry.register(SupportDashboardIntent(), role: 'support');
    GovernanceRegistry.register(
      SystemVerificationDashboardIntent(),
      role: 'system_verification',
    );
    GovernanceRegistry.register(
      TerritoryExpansionManagerDashboardIntent(),
      role: 'territory_expansion_manager',
    );
    GovernanceRegistry.register(
      TerritorySalesManagerDashboardIntent(),
      role: 'territory_sales_manager',
    );
    GovernanceRegistry.register(
      TrainingCoordinatorDashboardIntent(),
      role: 'training_coordinator',
    );
    GovernanceRegistry.register(
      TrainingDirectorCertificateDashboardIntent(),
      role: 'training_director_certificate',
    );
    GovernanceRegistry.register(
      TrainingDirectorDashboardIntent(),
      role: 'training_director',
    );
    GovernanceRegistry.register(
      TrainingHubDashboardIntent(),
      role: 'training_hub',
    );
    GovernanceRegistry.register(
      VolunteerCoordinatorDashboardIntent(),
      role: 'volunteer_coordinator',
    );

    // MOCK ORPHAN FOR VERIFICATION (Registered without role mapping)
    GovernanceRegistry.register(SystemVerificationDashboardIntent());
  }
}
