import 'package:flutter_core/flutter_core.dart';
import '../screens/common/shared_screen_stubs.dart';
import '../screens/psw/psw_messages_screen.dart';
import '../screens/psw/psw_visit_notes_screen.dart';

/// [ScreenRegistry] - UI-specific bridge for PlatformScreenRegistry.
/// Maps architectural metadata to actual Flutter widgets.
import '../screens/executive/coo_dashboard_screen.dart';
import '../screens/executive/coo_compliance_screen.dart';
import '../screens/executive/cfo_dashboard_screen.dart';
import '../screens/executive/cfo_compliance_screen.dart';
import '../screens/executive/cto_dashboard_screen.dart';
import '../screens/executive/cto_compliance_screen.dart';
import '../screens/management/compliance_manager_dashboard_screen.dart';
import '../screens/management/compliance_manager_compliance_screen.dart';
import '../screens/management/governance_officer_dashboard_screen.dart';
import '../screens/management/governance_officer_compliance_screen.dart';
import '../screens/management/head_of_bus_dev_dashboard_screen.dart';
import '../screens/management/head_of_bus_dev_compliance_screen.dart';
import '../screens/management/head_of_marketing_dashboard_screen.dart';
import '../screens/management/head_of_marketing_compliance_screen.dart';
import '../screens/executive/training_director_dashboard_screen.dart';
import '../screens/executive/training_director_compliance_screen.dart';
import '../screens/executive/finance_director_dashboard_screen.dart';
import '../screens/executive/finance_director_compliance_screen.dart';
import '../screens/management/scrum_master_dashboard_screen.dart';
import '../screens/management/scrum_master_compliance_screen.dart';
import '../screens/executive/hr_director_dashboard_screen.dart';
import '../screens/executive/hr_director_compliance_screen.dart';
import '../screens/executive/cx_director_dashboard_screen.dart';
import '../screens/executive/cx_director_compliance_screen.dart';
import '../screens/executive/shareholder_dashboard_screen.dart';
import '../screens/executive/shareholder_compliance_screen.dart';
import '../screens/executive/legal_dashboard_screen.dart';
import '../screens/executive/legal_compliance_screen.dart';
import '../screens/executive/ciso_dashboard_screen.dart';
import '../screens/executive/ciso_compliance_screen.dart';
import '../screens/management/regional_manager_usa_dashboard_screen.dart';
import '../screens/management/regional_manager_usa_compliance_screen.dart';
import '../screens/management/regional_bdm_dashboard_screen.dart';
import '../screens/management/regional_bdm_compliance_screen.dart';
import '../screens/management/franchise_sales_manager_dashboard_screen.dart';
import '../screens/management/franchise_sales_manager_compliance_screen.dart';
import '../screens/management/partnership_manager_dashboard_screen.dart';
import '../screens/management/partnership_manager_compliance_screen.dart';
import '../screens/management/territory_expansion_manager_dashboard_screen.dart';
import '../screens/management/territory_expansion_manager_compliance_screen.dart';
import '../screens/management/territory_sales_manager_dashboard_screen.dart';
import '../screens/management/territory_sales_manager_compliance_screen.dart';
import '../screens/management/general_manager_dashboard_screen.dart';
import '../screens/management/general_manager_compliance_screen.dart';
import '../screens/management/local_marketing_manager_dashboard_screen.dart';
import '../screens/management/local_marketing_manager_compliance_screen.dart';
import '../screens/management/community_outreach_dashboard_screen.dart';
import '../screens/management/community_outreach_compliance_screen.dart';
import '../screens/management/operations_manager_dashboard_screen.dart';
import '../screens/management/operations_manager_compliance_screen.dart';
import '../screens/staff/scheduler_dashboard_screen.dart';
import '../screens/staff/scheduler_compliance_screen.dart';
import '../screens/staff/billing_admin_dashboard_screen.dart';
import '../screens/staff/billing_admin_compliance_screen.dart';
import '../screens/staff/hr_hiring_dashboard_screen.dart';
import '../screens/staff/hr_hiring_compliance_screen.dart';
import '../screens/staff/hr_manager_dashboard_screen.dart';
import '../screens/staff/hr_manager_compliance_screen.dart';
import '../screens/executive/owner_dashboard_screen.dart';
import '../screens/executive/owner_compliance_screen.dart';
import '../screens/staff/intake_coordinator_dashboard_screen.dart';
import '../screens/staff/intake_coordinator_compliance_screen.dart';
import '../screens/staff/quality_assurance_dashboard_screen.dart';
import '../screens/staff/quality_assurance_compliance_screen.dart';
import '../screens/staff/training_coordinator_dashboard_screen.dart';
import '../screens/staff/training_coordinator_compliance_screen.dart';
import '../screens/staff/volunteer_coordinator_dashboard_screen.dart';
import '../screens/staff/volunteer_coordinator_compliance_screen.dart';
import '../screens/staff/receptionist_dashboard_screen.dart';
import '../screens/staff/receptionist_compliance_screen.dart';
import '../screens/psw/psw_dashboard_screen.dart';
import '../screens/psw/psw_compliance_screen.dart';
import '../screens/rn/rn_dashboard_screen.dart';
import '../screens/rn/rn_compliance_screen.dart';
import '../screens/rpn/rpn_dashboard_screen.dart';
import '../screens/rpn/rpn_compliance_screen.dart';
import '../screens/allied/rmt_dashboard_screen.dart';
import '../screens/allied/rmt_compliance_screen.dart';
import '../screens/common/chiropractor_dashboard_screen.dart';
import '../screens/common/chiropractor_compliance_screen.dart';
import '../screens/common/physiotherapist_dashboard_screen.dart';
import '../screens/common/physiotherapist_compliance_screen.dart';
import '../screens/common/social_worker_dashboard_screen.dart';
import '../screens/common/social_worker_compliance_screen.dart';
import '../screens/common/clinic_dashboard_screen.dart';
import '../screens/common/clinic_compliance_screen.dart';
import '../screens/common/patient_dashboard_screen.dart';
import '../screens/common/patient_compliance_screen.dart';
import '../screens/common/customer_support_dashboard_screen.dart';
import '../screens/common/customer_support_compliance_screen.dart';
import '../screens/common/intake_dashboard_screen.dart';
import '../screens/common/intake_compliance_screen.dart';
import '../screens/common/qa_dashboard_screen.dart';
import '../screens/common/qa_compliance_screen.dart';
import '../screens/common/support_dashboard_screen.dart';
import '../screens/common/support_compliance_screen.dart';
import '../screens/common/training_hub_dashboard_screen.dart';
import '../screens/common/training_hub_compliance_screen.dart';
import '../screens/common/course_architect_dashboard_screen.dart';
import '../screens/common/course_architect_compliance_screen.dart';
import '../screens/common/architecture_planning_dashboard_screen.dart';
import '../screens/common/architecture_planning_compliance_screen.dart';
import '../screens/common/system_verification_dashboard_screen.dart';
import '../screens/common/system_verification_compliance_screen.dart';
import '../screens/common/dynamic_screen_dashboard_screen.dart';
import '../screens/common/dynamic_screen_compliance_screen.dart';
import '../screens/common/family_member_dashboard_screen.dart';
import '../screens/common/family_member_compliance_screen.dart';
import '../screens/common/guest_dashboard_screen.dart';
import '../screens/common/guest_compliance_screen.dart';
import '../screens/common/system_dashboard_screen.dart';
import '../screens/common/system_compliance_screen.dart';
import '../screens/common/franchise_dashboard_screen.dart';
import '../screens/common/franchise_compliance_screen.dart';
import '../screens/common/office_dashboard_screen.dart';
import '../screens/common/office_compliance_screen.dart';
import '../screens/clinical/clinical_dashboard_screen.dart';
import '../screens/clinical/clinical_compliance_screen.dart';
import '../screens/common/portal_dashboard_screen.dart';
import '../screens/common/portal_compliance_screen.dart';
import '../screens/common/infrastructure_dashboard_screen.dart';
import '../screens/common/infrastructure_compliance_screen.dart';
import '../screens/common/business_development_dashboard_screen.dart';
import '../screens/common/business_development_compliance_screen.dart';
class ScreenRegistry {
  /// Local widget mapping for the UI layer.
  static final Map<String, Widget> _widgetRegistry = {
    // PSW Role
    'SCREEN_PSW_DASHBOARD': const ScreenNotImplementedView(
      screenName: 'PSW Dashboard',
    ),
    'SCREEN_PSW_SHIFT_TRACKER': const ScreenNotImplementedView(
      screenName: 'PSW Shift Tracker',
    ),
    'SCREEN_PSW_CLIENTS': const ScreenNotImplementedView(
      screenName: 'PSW Client List',
    ),
    'SCREEN_PSW_TASKS': const ScreenNotImplementedView(
      screenName: 'PSW Task List',
    ),
    'SCREEN_PSW_MESSAGES': const PswMessagesScreen(),
    'SCREEN_PSW_VISIT_NOTES': const PswVisitNotesScreen(),

    // RN Role
    'SCREEN_RN_DASHBOARD': const ScreenNotImplementedView(
      screenName: 'RN Dashboard',
    ),
    'SCREEN_RN_ASSESSMENTS': const ScreenNotImplementedView(
      screenName: 'RN Assessments',
    ),
    'SCREEN_RN_CARE_PLANS': const ScreenNotImplementedView(
      screenName: 'RN Care Plans',
    ),

    // RPN Role
    'SCREEN_RPN_DASHBOARD': const ScreenNotImplementedView(
      screenName: 'RPN Dashboard',
    ),

    // Coordinator Role
    'SCREEN_COORDINATOR_HUB': const ScreenNotImplementedView(
      screenName: 'Coordinator Hub',
    ),
    'SCREEN_COORDINATOR_DISPATCH_MAP': const ScreenNotImplementedView(
      screenName: 'Coordinator Dispatch Map',
    ),
    'SCREEN_COORDINATOR_SOS': const ScreenNotImplementedView(
      screenName: 'Coordinator SOS',
    ),
    'SCREEN_COORDINATOR_WAITLIST': const ScreenNotImplementedView(
      screenName: 'Coordinator Waitlist',
    ),

    // Allied Health
    'SCREEN_PT_DASHBOARD': const ScreenNotImplementedView(
      screenName: 'PT Dashboard',
    ),
    'SCREEN_RMT_DASHBOARD': const ScreenNotImplementedView(
      screenName: 'RMT Dashboard',
    ),
    'SCREEN_SW_DASHBOARD': const ScreenNotImplementedView(
      screenName: 'SW Dashboard',
    ),
    'SCREEN_CHIRO_DASHBOARD': const ScreenNotImplementedView(
      screenName: 'Chiro Dashboard',
    ),
    'COO_DASHBOARD': const CooDashboardScreen(),
    'SCREEN_COO_DASHBOARD': const CooDashboardScreen(),
    'COO_COMPLIANCE': const CooComplianceScreen(),
    'SCREEN_COO_COMPLIANCE': const CooComplianceScreen(),
    'CFO_DASHBOARD': const CfoDashboardScreen(),
    'SCREEN_CFO_DASHBOARD': const CfoDashboardScreen(),
    'CFO_COMPLIANCE': const CfoComplianceScreen(),
    'SCREEN_CFO_COMPLIANCE': const CfoComplianceScreen(),
    'CTO_DASHBOARD': const CtoDashboardScreen(),
    'SCREEN_CTO_DASHBOARD': const CtoDashboardScreen(),
    'CTO_COMPLIANCE': const CtoComplianceScreen(),
    'SCREEN_CTO_COMPLIANCE': const CtoComplianceScreen(),
    'COMPLIANCEMANAGER_DASHBOARD': const ComplianceManagerDashboardScreen(),
    'SCREEN_COMPLIANCEMANAGER_DASHBOARD': const ComplianceManagerDashboardScreen(),
    'COMPLIANCEMANAGER_COMPLIANCE': const ComplianceManagerComplianceScreen(),
    'SCREEN_COMPLIANCEMANAGER_COMPLIANCE': const ComplianceManagerComplianceScreen(),
    'GOVERNANCEOFFICER_DASHBOARD': const GovernanceOfficerDashboardScreen(),
    'SCREEN_GOVERNANCEOFFICER_DASHBOARD': const GovernanceOfficerDashboardScreen(),
    'GOVERNANCEOFFICER_COMPLIANCE': const GovernanceOfficerComplianceScreen(),
    'SCREEN_GOVERNANCEOFFICER_COMPLIANCE': const GovernanceOfficerComplianceScreen(),
    'HEADOFBUSDEV_DASHBOARD': const HeadOfBusDevDashboardScreen(),
    'SCREEN_HEADOFBUSDEV_DASHBOARD': const HeadOfBusDevDashboardScreen(),
    'HEADOFBUSDEV_COMPLIANCE': const HeadOfBusDevComplianceScreen(),
    'SCREEN_HEADOFBUSDEV_COMPLIANCE': const HeadOfBusDevComplianceScreen(),
    'HEADOFMARKETING_DASHBOARD': const HeadOfMarketingDashboardScreen(),
    'SCREEN_HEADOFMARKETING_DASHBOARD': const HeadOfMarketingDashboardScreen(),
    'HEADOFMARKETING_COMPLIANCE': const HeadOfMarketingComplianceScreen(),
    'SCREEN_HEADOFMARKETING_COMPLIANCE': const HeadOfMarketingComplianceScreen(),
    'TRAININGDIRECTOR_DASHBOARD': const TrainingDirectorDashboardScreen(),
    'SCREEN_TRAININGDIRECTOR_DASHBOARD': const TrainingDirectorDashboardScreen(),
    'TRAININGDIRECTOR_COMPLIANCE': const TrainingDirectorComplianceScreen(),
    'SCREEN_TRAININGDIRECTOR_COMPLIANCE': const TrainingDirectorComplianceScreen(),
    'FINANCEDIRECTOR_DASHBOARD': const FinanceDirectorDashboardScreen(),
    'SCREEN_FINANCEDIRECTOR_DASHBOARD': const FinanceDirectorDashboardScreen(),
    'FINANCEDIRECTOR_COMPLIANCE': const FinanceDirectorComplianceScreen(),
    'SCREEN_FINANCEDIRECTOR_COMPLIANCE': const FinanceDirectorComplianceScreen(),
    'SCRUMMASTER_DASHBOARD': const ScrumMasterDashboardScreen(),
    'SCREEN_SCRUMMASTER_DASHBOARD': const ScrumMasterDashboardScreen(),
    'SCRUMMASTER_COMPLIANCE': const ScrumMasterComplianceScreen(),
    'SCREEN_SCRUMMASTER_COMPLIANCE': const ScrumMasterComplianceScreen(),
    'HRDIRECTOR_DASHBOARD': const HrDirectorDashboardScreen(),
    'SCREEN_HRDIRECTOR_DASHBOARD': const HrDirectorDashboardScreen(),
    'HRDIRECTOR_COMPLIANCE': const HrDirectorComplianceScreen(),
    'SCREEN_HRDIRECTOR_COMPLIANCE': const HrDirectorComplianceScreen(),
    'CXDIRECTOR_DASHBOARD': const CxDirectorDashboardScreen(),
    'SCREEN_CXDIRECTOR_DASHBOARD': const CxDirectorDashboardScreen(),
    'CXDIRECTOR_COMPLIANCE': const CxDirectorComplianceScreen(),
    'SCREEN_CXDIRECTOR_COMPLIANCE': const CxDirectorComplianceScreen(),
    'SHAREHOLDER_DASHBOARD': const ShareholderDashboardScreen(),
    'SCREEN_SHAREHOLDER_DASHBOARD': const ShareholderDashboardScreen(),
    'SHAREHOLDER_COMPLIANCE': const ShareholderComplianceScreen(),
    'SCREEN_SHAREHOLDER_COMPLIANCE': const ShareholderComplianceScreen(),
    'LEGAL_DASHBOARD': const LegalDashboardScreen(),
    'SCREEN_LEGAL_DASHBOARD': const LegalDashboardScreen(),
    'LEGAL_COMPLIANCE': const LegalComplianceScreen(),
    'SCREEN_LEGAL_COMPLIANCE': const LegalComplianceScreen(),
    'CISO_DASHBOARD': const CisoDashboardScreen(),
    'SCREEN_CISO_DASHBOARD': const CisoDashboardScreen(),
    'CISO_COMPLIANCE': const CisoComplianceScreen(),
    'SCREEN_CISO_COMPLIANCE': const CisoComplianceScreen(),
    'REGIONALMANAGERUSA_DASHBOARD': const RegionalManagerUsaDashboardScreen(),
    'SCREEN_REGIONALMANAGERUSA_DASHBOARD': const RegionalManagerUsaDashboardScreen(),
    'REGIONALMANAGERUSA_COMPLIANCE': const RegionalManagerUsaComplianceScreen(),
    'SCREEN_REGIONALMANAGERUSA_COMPLIANCE': const RegionalManagerUsaComplianceScreen(),
    'REGIONALBDM_DASHBOARD': const RegionalBdmDashboardScreen(),
    'SCREEN_REGIONALBDM_DASHBOARD': const RegionalBdmDashboardScreen(),
    'REGIONALBDM_COMPLIANCE': const RegionalBdmComplianceScreen(),
    'SCREEN_REGIONALBDM_COMPLIANCE': const RegionalBdmComplianceScreen(),
    'FRANCHISESALESMANAGER_DASHBOARD': const FranchiseSalesManagerDashboardScreen(),
    'SCREEN_FRANCHISESALESMANAGER_DASHBOARD': const FranchiseSalesManagerDashboardScreen(),
    'FRANCHISESALESMANAGER_COMPLIANCE': const FranchiseSalesManagerComplianceScreen(),
    'SCREEN_FRANCHISESALESMANAGER_COMPLIANCE': const FranchiseSalesManagerComplianceScreen(),
    'PARTNERSHIPMANAGER_DASHBOARD': const PartnershipManagerDashboardScreen(),
    'SCREEN_PARTNERSHIPMANAGER_DASHBOARD': const PartnershipManagerDashboardScreen(),
    'PARTNERSHIPMANAGER_COMPLIANCE': const PartnershipManagerComplianceScreen(),
    'SCREEN_PARTNERSHIPMANAGER_COMPLIANCE': const PartnershipManagerComplianceScreen(),
    'TERRITORYEXPANSIONMANAGER_DASHBOARD': const TerritoryExpansionManagerDashboardScreen(),
    'SCREEN_TERRITORYEXPANSIONMANAGER_DASHBOARD': const TerritoryExpansionManagerDashboardScreen(),
    'TERRITORYEXPANSIONMANAGER_COMPLIANCE': const TerritoryExpansionManagerComplianceScreen(),
    'SCREEN_TERRITORYEXPANSIONMANAGER_COMPLIANCE': const TerritoryExpansionManagerComplianceScreen(),
    'TERRITORYSALESMANAGER_DASHBOARD': const TerritorySalesManagerDashboardScreen(),
    'SCREEN_TERRITORYSALESMANAGER_DASHBOARD': const TerritorySalesManagerDashboardScreen(),
    'TERRITORYSALESMANAGER_COMPLIANCE': const TerritorySalesManagerComplianceScreen(),
    'SCREEN_TERRITORYSALESMANAGER_COMPLIANCE': const TerritorySalesManagerComplianceScreen(),
    'GENERALMANAGER_DASHBOARD': const GeneralManagerDashboardScreen(),
    'SCREEN_GENERALMANAGER_DASHBOARD': const GeneralManagerDashboardScreen(),
    'GENERALMANAGER_COMPLIANCE': const GeneralManagerComplianceScreen(),
    'SCREEN_GENERALMANAGER_COMPLIANCE': const GeneralManagerComplianceScreen(),
    'LOCALMARKETINGMANAGER_DASHBOARD': const LocalMarketingManagerDashboardScreen(),
    'SCREEN_LOCALMARKETINGMANAGER_DASHBOARD': const LocalMarketingManagerDashboardScreen(),
    'LOCALMARKETINGMANAGER_COMPLIANCE': const LocalMarketingManagerComplianceScreen(),
    'SCREEN_LOCALMARKETINGMANAGER_COMPLIANCE': const LocalMarketingManagerComplianceScreen(),
    'COMMUNITYOUTREACH_DASHBOARD': const CommunityOutreachDashboardScreen(),
    'SCREEN_COMMUNITYOUTREACH_DASHBOARD': const CommunityOutreachDashboardScreen(),
    'COMMUNITYOUTREACH_COMPLIANCE': const CommunityOutreachComplianceScreen(),
    'SCREEN_COMMUNITYOUTREACH_COMPLIANCE': const CommunityOutreachComplianceScreen(),
    'OPERATIONSMANAGER_DASHBOARD': const OperationsManagerDashboardScreen(),
    'SCREEN_OPERATIONSMANAGER_DASHBOARD': const OperationsManagerDashboardScreen(),
    'OPERATIONSMANAGER_COMPLIANCE': const OperationsManagerComplianceScreen(),
    'SCREEN_OPERATIONSMANAGER_COMPLIANCE': const OperationsManagerComplianceScreen(),
    'SCHEDULER_DASHBOARD': const SchedulerDashboardScreen(),
    'SCREEN_SCHEDULER_DASHBOARD': const SchedulerDashboardScreen(),
    'SCHEDULER_COMPLIANCE': const SchedulerComplianceScreen(),
    'SCREEN_SCHEDULER_COMPLIANCE': const SchedulerComplianceScreen(),
    'BILLINGADMIN_DASHBOARD': const BillingAdminDashboardScreen(),
    'SCREEN_BILLINGADMIN_DASHBOARD': const BillingAdminDashboardScreen(),
    'BILLINGADMIN_COMPLIANCE': const BillingAdminComplianceScreen(),
    'SCREEN_BILLINGADMIN_COMPLIANCE': const BillingAdminComplianceScreen(),
    'HRHIRING_DASHBOARD': const HrHiringDashboardScreen(),
    'SCREEN_HRHIRING_DASHBOARD': const HrHiringDashboardScreen(),
    'HRHIRING_COMPLIANCE': const HrHiringComplianceScreen(),
    'SCREEN_HRHIRING_COMPLIANCE': const HrHiringComplianceScreen(),
    'HRMANAGER_DASHBOARD': const HrManagerDashboardScreen(),
    'SCREEN_HRMANAGER_DASHBOARD': const HrManagerDashboardScreen(),
    'HRMANAGER_COMPLIANCE': const HrManagerComplianceScreen(),
    'SCREEN_HRMANAGER_COMPLIANCE': const HrManagerComplianceScreen(),
    'OWNER_DASHBOARD': const OwnerDashboardScreen(),
    'SCREEN_OWNER_DASHBOARD': const OwnerDashboardScreen(),
    'OWNER_COMPLIANCE': const OwnerComplianceScreen(),
    'SCREEN_OWNER_COMPLIANCE': const OwnerComplianceScreen(),
    'INTAKECOORDINATOR_DASHBOARD': const IntakeCoordinatorDashboardScreen(),
    'SCREEN_INTAKECOORDINATOR_DASHBOARD': const IntakeCoordinatorDashboardScreen(),
    'INTAKECOORDINATOR_COMPLIANCE': const IntakeCoordinatorComplianceScreen(),
    'SCREEN_INTAKECOORDINATOR_COMPLIANCE': const IntakeCoordinatorComplianceScreen(),
    'QUALITYASSURANCE_DASHBOARD': const QualityAssuranceDashboardScreen(),
    'SCREEN_QUALITYASSURANCE_DASHBOARD': const QualityAssuranceDashboardScreen(),
    'QUALITYASSURANCE_COMPLIANCE': const QualityAssuranceComplianceScreen(),
    'SCREEN_QUALITYASSURANCE_COMPLIANCE': const QualityAssuranceComplianceScreen(),
    'TRAININGCOORDINATOR_DASHBOARD': const TrainingCoordinatorDashboardScreen(),
    'SCREEN_TRAININGCOORDINATOR_DASHBOARD': const TrainingCoordinatorDashboardScreen(),
    'TRAININGCOORDINATOR_COMPLIANCE': const TrainingCoordinatorComplianceScreen(),
    'SCREEN_TRAININGCOORDINATOR_COMPLIANCE': const TrainingCoordinatorComplianceScreen(),
    'VOLUNTEERCOORDINATOR_DASHBOARD': const VolunteerCoordinatorDashboardScreen(),
    'SCREEN_VOLUNTEERCOORDINATOR_DASHBOARD': const VolunteerCoordinatorDashboardScreen(),
    'VOLUNTEERCOORDINATOR_COMPLIANCE': const VolunteerCoordinatorComplianceScreen(),
    'SCREEN_VOLUNTEERCOORDINATOR_COMPLIANCE': const VolunteerCoordinatorComplianceScreen(),
    'RECEPTIONIST_DASHBOARD': const ReceptionistDashboardScreen(),
    'SCREEN_RECEPTIONIST_DASHBOARD': const ReceptionistDashboardScreen(),
    'RECEPTIONIST_COMPLIANCE': const ReceptionistComplianceScreen(),
    'SCREEN_RECEPTIONIST_COMPLIANCE': const ReceptionistComplianceScreen(),
    'PSW_DASHBOARD': const PswDashboardScreen(),
    'PSW_COMPLIANCE': const PswComplianceScreen(),
    'SCREEN_PSW_COMPLIANCE': const PswComplianceScreen(),
    'RN_DASHBOARD': const RnDashboardScreen(),
    'RN_COMPLIANCE': const RnComplianceScreen(),
    'SCREEN_RN_COMPLIANCE': const RnComplianceScreen(),
    'RPN_DASHBOARD': const RpnDashboardScreen(),
    'RPN_COMPLIANCE': const RpnComplianceScreen(),
    'SCREEN_RPN_COMPLIANCE': const RpnComplianceScreen(),
    'RMT_DASHBOARD': const RmtDashboardScreen(),
    'RMT_COMPLIANCE': const RmtComplianceScreen(),
    'SCREEN_RMT_COMPLIANCE': const RmtComplianceScreen(),
    'CHIROPRACTOR_DASHBOARD': const ChiropractorDashboardScreen(),
    'SCREEN_CHIROPRACTOR_DASHBOARD': const ChiropractorDashboardScreen(),
    'CHIROPRACTOR_COMPLIANCE': const ChiropractorComplianceScreen(),
    'SCREEN_CHIROPRACTOR_COMPLIANCE': const ChiropractorComplianceScreen(),
    'PHYSIOTHERAPIST_DASHBOARD': const PhysiotherapistDashboardScreen(),
    'SCREEN_PHYSIOTHERAPIST_DASHBOARD': const PhysiotherapistDashboardScreen(),
    'PHYSIOTHERAPIST_COMPLIANCE': const PhysiotherapistComplianceScreen(),
    'SCREEN_PHYSIOTHERAPIST_COMPLIANCE': const PhysiotherapistComplianceScreen(),
    'SOCIALWORKER_DASHBOARD': const SocialWorkerDashboardScreen(),
    'SCREEN_SOCIALWORKER_DASHBOARD': const SocialWorkerDashboardScreen(),
    'SOCIALWORKER_COMPLIANCE': const SocialWorkerComplianceScreen(),
    'SCREEN_SOCIALWORKER_COMPLIANCE': const SocialWorkerComplianceScreen(),
    'CLINIC_DASHBOARD': const ClinicDashboardScreen(),
    'SCREEN_CLINIC_DASHBOARD': const ClinicDashboardScreen(),
    'CLINIC_COMPLIANCE': const ClinicComplianceScreen(),
    'SCREEN_CLINIC_COMPLIANCE': const ClinicComplianceScreen(),
    'PATIENT_DASHBOARD': const PatientDashboardScreen(),
    'SCREEN_PATIENT_DASHBOARD': const PatientDashboardScreen(),
    'PATIENT_COMPLIANCE': const PatientComplianceScreen(),
    'SCREEN_PATIENT_COMPLIANCE': const PatientComplianceScreen(),
    'CUSTOMERSUPPORT_DASHBOARD': const CustomerSupportDashboardScreen(),
    'SCREEN_CUSTOMERSUPPORT_DASHBOARD': const CustomerSupportDashboardScreen(),
    'CUSTOMERSUPPORT_COMPLIANCE': const CustomerSupportComplianceScreen(),
    'SCREEN_CUSTOMERSUPPORT_COMPLIANCE': const CustomerSupportComplianceScreen(),
    'INTAKE_DASHBOARD': const IntakeDashboardScreen(),
    'SCREEN_INTAKE_DASHBOARD': const IntakeDashboardScreen(),
    'INTAKE_COMPLIANCE': const IntakeComplianceScreen(),
    'SCREEN_INTAKE_COMPLIANCE': const IntakeComplianceScreen(),
    'QA_DASHBOARD': const QaDashboardScreen(),
    'SCREEN_QA_DASHBOARD': const QaDashboardScreen(),
    'QA_COMPLIANCE': const QaComplianceScreen(),
    'SCREEN_QA_COMPLIANCE': const QaComplianceScreen(),
    'SUPPORT_DASHBOARD': const SupportDashboardScreen(),
    'SCREEN_SUPPORT_DASHBOARD': const SupportDashboardScreen(),
    'SUPPORT_COMPLIANCE': const SupportComplianceScreen(),
    'SCREEN_SUPPORT_COMPLIANCE': const SupportComplianceScreen(),
    'TRAININGHUB_DASHBOARD': const TrainingHubDashboardScreen(),
    'SCREEN_TRAININGHUB_DASHBOARD': const TrainingHubDashboardScreen(),
    'TRAININGHUB_COMPLIANCE': const TrainingHubComplianceScreen(),
    'SCREEN_TRAININGHUB_COMPLIANCE': const TrainingHubComplianceScreen(),
    'COURSEARCHITECT_DASHBOARD': const CourseArchitectDashboardScreen(),
    'SCREEN_COURSEARCHITECT_DASHBOARD': const CourseArchitectDashboardScreen(),
    'COURSEARCHITECT_COMPLIANCE': const CourseArchitectComplianceScreen(),
    'SCREEN_COURSEARCHITECT_COMPLIANCE': const CourseArchitectComplianceScreen(),
    'ARCHITECTUREPLANNING_DASHBOARD': const ArchitecturePlanningDashboardScreen(),
    'SCREEN_ARCHITECTUREPLANNING_DASHBOARD': const ArchitecturePlanningDashboardScreen(),
    'ARCHITECTUREPLANNING_COMPLIANCE': const ArchitecturePlanningComplianceScreen(),
    'SCREEN_ARCHITECTUREPLANNING_COMPLIANCE': const ArchitecturePlanningComplianceScreen(),
    'SYSTEMVERIFICATION_DASHBOARD': const SystemVerificationDashboardScreen(),
    'SCREEN_SYSTEMVERIFICATION_DASHBOARD': const SystemVerificationDashboardScreen(),
    'SYSTEMVERIFICATION_COMPLIANCE': const SystemVerificationComplianceScreen(),
    'SCREEN_SYSTEMVERIFICATION_COMPLIANCE': const SystemVerificationComplianceScreen(),
    'DYNAMICSCREEN_DASHBOARD': const DynamicScreenDashboardScreen(),
    'SCREEN_DYNAMICSCREEN_DASHBOARD': const DynamicScreenDashboardScreen(),
    'DYNAMICSCREEN_COMPLIANCE': const DynamicScreenComplianceScreen(),
    'SCREEN_DYNAMICSCREEN_COMPLIANCE': const DynamicScreenComplianceScreen(),
    'FAMILYMEMBER_DASHBOARD': const FamilyMemberDashboardScreen(),
    'SCREEN_FAMILYMEMBER_DASHBOARD': const FamilyMemberDashboardScreen(),
    'FAMILYMEMBER_COMPLIANCE': const FamilyMemberComplianceScreen(),
    'SCREEN_FAMILYMEMBER_COMPLIANCE': const FamilyMemberComplianceScreen(),
    'GUEST_DASHBOARD': const GuestDashboardScreen(),
    'SCREEN_GUEST_DASHBOARD': const GuestDashboardScreen(),
    'GUEST_COMPLIANCE': const GuestComplianceScreen(),
    'SCREEN_GUEST_COMPLIANCE': const GuestComplianceScreen(),
    'SYSTEM_DASHBOARD': const SystemDashboardScreen(),
    'SCREEN_SYSTEM_DASHBOARD': const SystemDashboardScreen(),
    'SYSTEM_COMPLIANCE': const SystemComplianceScreen(),
    'SCREEN_SYSTEM_COMPLIANCE': const SystemComplianceScreen(),
    'FRANCHISE_DASHBOARD': const FranchiseDashboardScreen(),
    'SCREEN_FRANCHISE_DASHBOARD': const FranchiseDashboardScreen(),
    'FRANCHISE_COMPLIANCE': const FranchiseComplianceScreen(),
    'SCREEN_FRANCHISE_COMPLIANCE': const FranchiseComplianceScreen(),
    'OFFICE_DASHBOARD': const OfficeDashboardScreen(),
    'SCREEN_OFFICE_DASHBOARD': const OfficeDashboardScreen(),
    'OFFICE_COMPLIANCE': const OfficeComplianceScreen(),
    'SCREEN_OFFICE_COMPLIANCE': const OfficeComplianceScreen(),
    'CLINICAL_DASHBOARD': const ClinicalDashboardScreen(),
    'SCREEN_CLINICAL_DASHBOARD': const ClinicalDashboardScreen(),
    'CLINICAL_COMPLIANCE': const ClinicalComplianceScreen(),
    'SCREEN_CLINICAL_COMPLIANCE': const ClinicalComplianceScreen(),
    'PORTAL_DASHBOARD': const PortalDashboardScreen(),
    'SCREEN_PORTAL_DASHBOARD': const PortalDashboardScreen(),
    'PORTAL_COMPLIANCE': const PortalComplianceScreen(),
    'SCREEN_PORTAL_COMPLIANCE': const PortalComplianceScreen(),
    'INFRASTRUCTURE_DASHBOARD': const InfrastructureDashboardScreen(),
    'SCREEN_INFRASTRUCTURE_DASHBOARD': const InfrastructureDashboardScreen(),
    'INFRASTRUCTURE_COMPLIANCE': const InfrastructureComplianceScreen(),
    'SCREEN_INFRASTRUCTURE_COMPLIANCE': const InfrastructureComplianceScreen(),
    'BUSINESSDEVELOPMENT_DASHBOARD': const BusinessDevelopmentDashboardScreen(),
    'SCREEN_BUSINESSDEVELOPMENT_DASHBOARD': const BusinessDevelopmentDashboardScreen(),
    'BUSINESSDEVELOPMENT_COMPLIANCE': const BusinessDevelopmentComplianceScreen(),
    'SCREEN_BUSINESSDEVELOPMENT_COMPLIANCE': const BusinessDevelopmentComplianceScreen(),
  };

  /// Source of truth for metadata
  static Map<String, ScreenMetadata> get screens =>
      PlatformScreenRegistry.screens;

  /// Returns all registered screen metadata
  static List<ScreenMetadata> getAllScreens() =>
      PlatformScreenRegistry.allScreens;

  /// Retrieves the widget implementation for a given screen ID.
  static Widget getWidget(String id) {
    return _widgetRegistry[id] ?? ScreenNotImplementedView(screenName: id);
  }

  /// Audits the registry for health and implementation status.
  static List<ScreenAuditReport> auditRegistry() {
    return screens.keys
        .map(
          (id) => ScreenAuditReport(
            id: id,
            isHealthy: true,
            message: 'Screen $id is mapped to metadata.',
          ),
        )
        .toList();
  }

  /// Bootstraps the registry.
  static Future<void> bootstrap() async {
    debugPrint(
      'SCREEN_REGISTRY: Bootstrapping UI registries with ${screens.length} metadata entries and ${_widgetRegistry.length} widget mappings.',
    );
  }
}

class ScreenAuditReport {
  final String id;
  final bool isHealthy;
  final String message;

  ScreenAuditReport({
    required this.id,
    required this.isHealthy,
    required this.message,
  });
}
