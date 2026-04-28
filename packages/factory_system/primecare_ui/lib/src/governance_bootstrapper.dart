// Layer: 02_I_GOVERNANCE_BOOTSTRAPPER
// AUTO-GENERATED - DO NOT EDIT
import 'package:flutter_core/flutter_core.dart';
import 'features/features_view.dart';
import 'blueprint_seeder.dart';

class GovernanceBootstrapper {
  static void bootstrap() {
    BlueprintSeeder.seed();
    GovernanceRegistry.register(
      ArchitecturalPlanningIntent(),
      role: PlatformRole.architecturePlanning.nameSnake,
    );
    GovernanceRegistry.register(
      BillingAdminDashboardIntent(),
      role: PlatformRole.billingAdmin.nameSnake,
    );
    GovernanceRegistry.register(
      CeoDashboardIntent(),
      role: PlatformRole.ceo.nameSnake,
    );
    GovernanceRegistry.register(
      CfoDashboardIntent(),
      role: PlatformRole.cfo.nameSnake,
    );
    GovernanceRegistry.register(
      ClientDashboardIntent(),
      role: PlatformRole.client.nameSnake,
    );
    GovernanceRegistry.register(
      ClinicDashboardIntent(),
      role: PlatformRole.clinic.nameSnake,
    );
    GovernanceRegistry.register(
      ClinicalDirectorDashboardIntent(),
      role: PlatformRole.clinicalDirector.nameSnake,
    );
    GovernanceRegistry.register(
      CommunityOutreachDashboardIntent(),
      role: PlatformRole.communityOutreach.nameSnake,
    );
    GovernanceRegistry.register(
      ComplianceHubIntent(),
      role: PlatformRole.complianceManager.nameSnake,
    );
    GovernanceRegistry.register(
      CooDashboardIntent(),
      role: PlatformRole.coo.nameSnake,
    );
    GovernanceRegistry.register(CorporateGovernanceDashboardIntent());
    GovernanceRegistry.register(
      CourseArchitectDashboardIntent(),
      role: PlatformRole.courseArchitect.nameSnake,
    );
    GovernanceRegistry.register(
      CtoDashboardIntent(),
      role: PlatformRole.cto.nameSnake,
    );
    GovernanceRegistry.register(
      CustomerSupportDashboardIntent(),
      role: PlatformRole.customerSupport.nameSnake,
    );
    GovernanceRegistry.register(
      CxDirectorDashboardIntent(),
      role: PlatformRole.cxDirector.nameSnake,
    );
    GovernanceRegistry.register(
      DynamicScreenDashboardIntent(),
      role: PlatformRole.dynamicScreen.nameSnake,
    );
    GovernanceRegistry.register(FamilyDashboardIntent());
    GovernanceRegistry.register(
      FamilyMemberDashboardIntent(),
      role: PlatformRole.familyMember.nameSnake,
    );
    GovernanceRegistry.register(
      FinanceDirectorDashboardIntent(),
      role: PlatformRole.financeDirector.nameSnake,
    );
    GovernanceRegistry.register(
      FranchiseOwnerDashboardIntent(),
      role: PlatformRole.franchiseOwner.nameSnake,
    );
    GovernanceRegistry.register(
      FranchiseSalesManagerDashboardIntent(),
      role: PlatformRole.franchiseSalesManager.nameSnake,
    );
    GovernanceRegistry.register(
      GeneralManagerDashboardIntent(),
      role: PlatformRole.generalManager.nameSnake,
    );
    GovernanceRegistry.register(
      GuestDashboardIntent(),
      role: PlatformRole.guest.nameSnake,
    );
    GovernanceRegistry.register(
      HeadOfBusDevDashboardIntent(),
      role: PlatformRole.headOfBusDev.nameSnake,
    );
    GovernanceRegistry.register(
      HeadOfMarketingDashboardIntent(),
      role: PlatformRole.headOfMarketing.nameSnake,
    );
    GovernanceRegistry.register(
      HrDirectorDashboardIntent(),
      role: PlatformRole.hrDirector.nameSnake,
    );
    GovernanceRegistry.register(
      HrHiringDashboardIntent(),
      role: PlatformRole.hrHiring.nameSnake,
    );
    GovernanceRegistry.register(HrManagerDashboardIntent());
    GovernanceRegistry.register(
      ITSecurityDashboardIntent(),
      role: PlatformRole.admin.nameSnake,
    );
    GovernanceRegistry.register(
      IntakeCoordinatorDashboardIntent(),
      role: PlatformRole.intakeCoordinator.nameSnake,
    );
    GovernanceRegistry.register(
      IntakeDashboardIntent(),
      role: PlatformRole.intake.nameSnake,
    );
    GovernanceRegistry.register(
      LocalMarketingManagerDashboardIntent(),
      role: PlatformRole.localMarketingManager.nameSnake,
    );
    GovernanceRegistry.register(
      OperationsManagerDashboardIntent(),
      role: PlatformRole.operationsManager.nameSnake,
    );
    GovernanceRegistry.register(
      OwnerDashboardIntent(),
      role: PlatformRole.owner.nameSnake,
    );
    GovernanceRegistry.register(
      PartnershipManagerDashboardIntent(),
      role: PlatformRole.partnershipManager.nameSnake,
    );
    GovernanceRegistry.register(
      PatientDashboardIntent(),
      role: PlatformRole.patient.nameSnake,
    );
    GovernanceRegistry.register(
      PswDashboardIntent(),
      role: PlatformRole.psw.nameSnake,
    );
    GovernanceRegistry.register(
      QaDashboardIntent(),
      role: PlatformRole.qa.nameSnake,
    );
    GovernanceRegistry.register(
      QualityAssuranceDashboardIntent(),
      role: PlatformRole.qualityAssurance.nameSnake,
    );
    GovernanceRegistry.register(
      ReceptionistDashboardIntent(),
      role: PlatformRole.receptionist.nameSnake,
    );
    GovernanceRegistry.register(
      RegionalBdmDashboardIntent(),
      role: PlatformRole.regionalBdm.nameSnake,
    );
    GovernanceRegistry.register(
      RegionalManagerOntarioDashboardIntent(),
      role: PlatformRole.regionalManagerOntario.nameSnake,
    );
    GovernanceRegistry.register(
      RegionalManagerUsaDashboardIntent(),
      role: PlatformRole.regionalManagerUsa.nameSnake,
    );
    GovernanceRegistry.register(
      RmtDashboardIntent(),
      role: PlatformRole.rmt.nameSnake,
    );
    GovernanceRegistry.register(
      RnDashboardIntent(),
      role: PlatformRole.rn.nameSnake,
    );
    GovernanceRegistry.register(
      SchedulerDashboardIntent(),
      role: PlatformRole.scheduler.nameSnake,
    );
    GovernanceRegistry.register(
      ScrumMasterDashboardIntent(),
      role: PlatformRole.scrumMaster.nameSnake,
    );
    GovernanceRegistry.register(
      ShareholderIntelligenceIntent(),
      role: PlatformRole.shareholder.nameSnake,
    );
    GovernanceRegistry.register(
      SocialWorkerDashboardIntent(),
      role: PlatformRole.socialWorker.nameSnake,
    );
    GovernanceRegistry.register(
      SupportDashboardIntent(),
      role: PlatformRole.support.nameSnake,
    );
    GovernanceRegistry.register(
      VerificationHubIntent(),
      role: PlatformRole.systemVerification.nameSnake,
    );
    GovernanceRegistry.register(RegionDashboardIntent());
    GovernanceRegistry.register(
      SystemDashboardIntent(),
      role: PlatformRole.system.nameSnake,
    );
    GovernanceRegistry.register(
      TerritoryExpansionManagerDashboardIntent(),
      role: PlatformRole.territoryExpansionManager.nameSnake,
    );
    GovernanceRegistry.register(
      TerritorySalesManagerDashboardIntent(),
      role: PlatformRole.territorySalesManager.nameSnake,
    );
    GovernanceRegistry.register(
      TrainingCoordinatorDashboardIntent(),
      role: PlatformRole.trainingCoordinator.nameSnake,
    );
    GovernanceRegistry.register(
      TrainingDirectorCertificateDashboardIntent(),
      role: PlatformRole.trainingDirectorCertificate.nameSnake,
    );
    GovernanceRegistry.register(
      TrainingDirectorDashboardIntent(),
      role: PlatformRole.trainingDirector.nameSnake,
    );
    GovernanceRegistry.register(
      TrainingHubDashboardIntent(),
      role: PlatformRole.trainingHub.nameSnake,
    );
    GovernanceRegistry.register(
      VolunteerCoordinatorDashboardIntent(),
      role: PlatformRole.volunteerCoordinator.nameSnake,
    );
  }
}
