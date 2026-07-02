// Governance - Category: adapter | Purpose: Generated type-safe API client wrappers connected to the central API Registry.
// THIS FILE IS GENERATED. DO NOT EDIT DIRECTLY.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';

class GeneratedApiClient {
  final Ref ref;

  GeneratedApiClient(this.ref);

  /// Load Rmt List Data
  /// Method: GET | Path: /v1/rmt | Status: mocked
  Future<ApiResponse> loadApiV1RmtList() async {
    return ref.read(apiClientProvider).get('/v1/rmt');
  }

  /// Create New Rmt Record
  /// Method: POST | Path: /v1/rmt | Status: mocked
  Future<ApiResponse> createApiV1RmtCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rmt', body: data);
  }

  /// Update Existing Rmt Record
  /// Method: PATCH | Path: /v1/rmt/:id | Status: mocked
  Future<ApiResponse> updateApiV1RmtUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rmt/$id', body: data);
  }

  /// Load Therapist List Data
  /// Method: GET | Path: /v1/therapist | Status: mocked
  Future<ApiResponse> loadApiV1TherapistList() async {
    return ref.read(apiClientProvider).get('/v1/therapist');
  }

  /// Load Clinical List Data
  /// Method: GET | Path: /v1/clinical | Status: mocked
  Future<ApiResponse> loadApiV1ClinicalList() async {
    return ref.read(apiClientProvider).get('/v1/clinical');
  }

  /// Load Cns List Data
  /// Method: GET | Path: /v1/cns | Status: mocked
  Future<ApiResponse> loadApiV1CnsList() async {
    return ref.read(apiClientProvider).get('/v1/cns');
  }

  /// Load Hsw List Data
  /// Method: GET | Path: /v1/hsw | Status: mocked
  Future<ApiResponse> loadApiV1HswList() async {
    return ref.read(apiClientProvider).get('/v1/hsw');
  }

  /// Load Lpn List Data
  /// Method: GET | Path: /v1/lpn | Status: mocked
  Future<ApiResponse> loadApiV1LpnList() async {
    return ref.read(apiClientProvider).get('/v1/lpn');
  }

  /// Load Np List Data
  /// Method: GET | Path: /v1/np | Status: mocked
  Future<ApiResponse> loadApiV1NpList() async {
    return ref.read(apiClientProvider).get('/v1/np');
  }

  /// Load Pediatric List Data
  /// Method: GET | Path: /v1/pediatric | Status: mocked
  Future<ApiResponse> loadApiV1PediatricList() async {
    return ref.read(apiClientProvider).get('/v1/pediatric');
  }

  /// Load Physician List Data
  /// Method: GET | Path: /v1/physician | Status: mocked
  Future<ApiResponse> loadApiV1PhysicianList() async {
    return ref.read(apiClientProvider).get('/v1/physician');
  }

  /// Load Architecture Planning List Data
  /// Method: GET | Path: /v1/architecture-planning | Status: mocked
  Future<ApiResponse> loadApiV1ArchitecturePlanningList() async {
    return ref.read(apiClientProvider).get('/v1/architecture-planning');
  }

  /// Load Business Development List Data
  /// Method: GET | Path: /v1/business-development | Status: mocked
  Future<ApiResponse> loadApiV1BusinessDevelopmentList() async {
    return ref.read(apiClientProvider).get('/v1/business-development');
  }

  /// Load Caregivers List Data
  /// Method: GET | Path: /v1/caregivers | Status: mocked
  Future<ApiResponse> loadApiV1CaregiversList() async {
    return ref.read(apiClientProvider).get('/v1/caregivers');
  }

  /// Load Chiropractor List Data
  /// Method: GET | Path: /v1/chiropractor | Status: mocked
  Future<ApiResponse> loadApiV1ChiropractorList() async {
    return ref.read(apiClientProvider).get('/v1/chiropractor');
  }

  /// Load Clinic List Data
  /// Method: GET | Path: /v1/clinic | Status: mocked
  Future<ApiResponse> loadApiV1ClinicList() async {
    return ref.read(apiClientProvider).get('/v1/clinic');
  }

  /// Load Course Architect List Data
  /// Method: GET | Path: /v1/course-architect | Status: mocked
  Future<ApiResponse> loadApiV1CourseArchitectList() async {
    return ref.read(apiClientProvider).get('/v1/course-architect');
  }

  /// Load Customer Support List Data
  /// Method: GET | Path: /v1/customer-support | Status: mocked
  Future<ApiResponse> loadApiV1CustomerSupportList() async {
    return ref.read(apiClientProvider).get('/v1/customer-support');
  }

  /// Load Dynamic List Data
  /// Method: GET | Path: /v1/dynamic | Status: mocked
  Future<ApiResponse> loadApiV1DynamicList() async {
    return ref.read(apiClientProvider).get('/v1/dynamic');
  }

  /// Create New Dynamic Record
  /// Method: POST | Path: /v1/dynamic | Status: mocked
  Future<ApiResponse> createApiV1DynamicCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/dynamic', body: data);
  }

  /// Update Existing Dynamic Record
  /// Method: PATCH | Path: /v1/dynamic/:id | Status: mocked
  Future<ApiResponse> updateApiV1DynamicUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/dynamic/$id', body: data);
  }

  /// Load Family Member List Data
  /// Method: GET | Path: /v1/family-member | Status: mocked
  Future<ApiResponse> loadApiV1FamilyMemberList() async {
    return ref.read(apiClientProvider).get('/v1/family-member');
  }

  /// Load Franchise List Data
  /// Method: GET | Path: /v1/franchise | Status: mocked
  Future<ApiResponse> loadApiV1FranchiseList() async {
    return ref.read(apiClientProvider).get('/v1/franchise');
  }

  /// Load Guest List Data
  /// Method: GET | Path: /v1/guest | Status: mocked
  Future<ApiResponse> loadApiV1GuestList() async {
    return ref.read(apiClientProvider).get('/v1/guest');
  }

  /// Load Infrastructure List Data
  /// Method: GET | Path: /v1/infrastructure | Status: mocked
  Future<ApiResponse> loadApiV1InfrastructureList() async {
    return ref.read(apiClientProvider).get('/v1/infrastructure');
  }

  /// Load Intake List Data
  /// Method: GET | Path: /v1/intake | Status: mocked
  Future<ApiResponse> loadApiV1IntakeList() async {
    return ref.read(apiClientProvider).get('/v1/intake');
  }

  /// Create New Intake Record
  /// Method: POST | Path: /v1/intake | Status: mocked
  Future<ApiResponse> createApiV1IntakeCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/intake', body: data);
  }

  /// Update Existing Intake Record
  /// Method: PATCH | Path: /v1/intake/:id | Status: mocked
  Future<ApiResponse> updateApiV1IntakeUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/intake/$id', body: data);
  }

  /// Load Office List Data
  /// Method: GET | Path: /v1/office | Status: mocked
  Future<ApiResponse> loadApiV1OfficeList() async {
    return ref.read(apiClientProvider).get('/v1/office');
  }

  /// Load Patients List Data
  /// Method: GET | Path: /v1/patients | Status: mocked
  Future<ApiResponse> loadApiV1PatientsList() async {
    return ref.read(apiClientProvider).get('/v1/patients');
  }

  /// Load Physiotherapist List Data
  /// Method: GET | Path: /v1/physiotherapist | Status: mocked
  Future<ApiResponse> loadApiV1PhysiotherapistList() async {
    return ref.read(apiClientProvider).get('/v1/physiotherapist');
  }

  /// Load Portal List Data
  /// Method: GET | Path: /v1/portal | Status: mocked
  Future<ApiResponse> loadApiV1PortalList() async {
    return ref.read(apiClientProvider).get('/v1/portal');
  }

  /// Load Qa List Data
  /// Method: GET | Path: /v1/qa | Status: mocked
  Future<ApiResponse> loadApiV1QaList() async {
    return ref.read(apiClientProvider).get('/v1/qa');
  }

  /// Load Social Worker List Data
  /// Method: GET | Path: /v1/social-worker | Status: mocked
  Future<ApiResponse> loadApiV1SocialWorkerList() async {
    return ref.read(apiClientProvider).get('/v1/social-worker');
  }

  /// Load Support List Data
  /// Method: GET | Path: /v1/support | Status: mocked
  Future<ApiResponse> loadApiV1SupportList() async {
    return ref.read(apiClientProvider).get('/v1/support');
  }

  /// Load System List Data
  /// Method: GET | Path: /v1/system | Status: mocked
  Future<ApiResponse> loadApiV1SystemList() async {
    return ref.read(apiClientProvider).get('/v1/system');
  }

  /// Load System Verification List Data
  /// Method: GET | Path: /v1/system-verification | Status: mocked
  Future<ApiResponse> loadApiV1SystemVerificationList() async {
    return ref.read(apiClientProvider).get('/v1/system-verification');
  }

  /// Load Training Hub List Data
  /// Method: GET | Path: /v1/training-hub | Status: mocked
  Future<ApiResponse> loadApiV1TrainingHubList() async {
    return ref.read(apiClientProvider).get('/v1/training-hub');
  }

  /// Load Cfo List Data
  /// Method: GET | Path: /v1/cfo | Status: mocked
  Future<ApiResponse> loadApiV1CfoList() async {
    return ref.read(apiClientProvider).get('/v1/cfo');
  }

  /// Load Ciso List Data
  /// Method: GET | Path: /v1/ciso | Status: mocked
  Future<ApiResponse> loadApiV1CisoList() async {
    return ref.read(apiClientProvider).get('/v1/ciso');
  }

  /// Create New Ciso Record
  /// Method: POST | Path: /v1/ciso | Status: mocked
  Future<ApiResponse> createApiV1CisoCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/ciso', body: data);
  }

  /// Update Existing Ciso Record
  /// Method: PATCH | Path: /v1/ciso/:id | Status: mocked
  Future<ApiResponse> updateApiV1CisoUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/ciso/$id', body: data);
  }

  /// Load Coo List Data
  /// Method: GET | Path: /v1/coo | Status: mocked
  Future<ApiResponse> loadApiV1CooList() async {
    return ref.read(apiClientProvider).get('/v1/coo');
  }

  /// Load Cto List Data
  /// Method: GET | Path: /v1/cto | Status: mocked
  Future<ApiResponse> loadApiV1CtoList() async {
    return ref.read(apiClientProvider).get('/v1/cto');
  }

  /// Load Cx Director List Data
  /// Method: GET | Path: /v1/cx-director | Status: mocked
  Future<ApiResponse> loadApiV1CxDirectorList() async {
    return ref.read(apiClientProvider).get('/v1/cx-director');
  }

  /// Load Finance Director List Data
  /// Method: GET | Path: /v1/finance-director | Status: mocked
  Future<ApiResponse> loadApiV1FinanceDirectorList() async {
    return ref.read(apiClientProvider).get('/v1/finance-director');
  }

  /// Load Hr Director List Data
  /// Method: GET | Path: /v1/hr-director | Status: mocked
  Future<ApiResponse> loadApiV1HrDirectorList() async {
    return ref.read(apiClientProvider).get('/v1/hr-director');
  }

  /// Load Legal List Data
  /// Method: GET | Path: /v1/legal | Status: mocked
  Future<ApiResponse> loadApiV1LegalList() async {
    return ref.read(apiClientProvider).get('/v1/legal');
  }

  /// Load Owner List Data
  /// Method: GET | Path: /v1/owner | Status: mocked
  Future<ApiResponse> loadApiV1OwnerList() async {
    return ref.read(apiClientProvider).get('/v1/owner');
  }

  /// Load Shareholder List Data
  /// Method: GET | Path: /v1/shareholder | Status: mocked
  Future<ApiResponse> loadApiV1ShareholderList() async {
    return ref.read(apiClientProvider).get('/v1/shareholder');
  }

  /// Load Training Director List Data
  /// Method: GET | Path: /v1/training-director | Status: mocked
  Future<ApiResponse> loadApiV1TrainingDirectorList() async {
    return ref.read(apiClientProvider).get('/v1/training-director');
  }

  /// Load Community Outreach List Data
  /// Method: GET | Path: /v1/community-outreach | Status: mocked
  Future<ApiResponse> loadApiV1CommunityOutreachList() async {
    return ref.read(apiClientProvider).get('/v1/community-outreach');
  }

  /// Load Compliance Manager List Data
  /// Method: GET | Path: /v1/compliance-manager | Status: mocked
  Future<ApiResponse> loadApiV1ComplianceManagerList() async {
    return ref.read(apiClientProvider).get('/v1/compliance-manager');
  }

  /// Load Franchise Sales Manager List Data
  /// Method: GET | Path: /v1/franchise-sales-manager | Status: mocked
  Future<ApiResponse> loadApiV1FranchiseSalesManagerList() async {
    return ref.read(apiClientProvider).get('/v1/franchise-sales-manager');
  }

  /// Load General Manager List Data
  /// Method: GET | Path: /v1/general-manager | Status: mocked
  Future<ApiResponse> loadApiV1GeneralManagerList() async {
    return ref.read(apiClientProvider).get('/v1/general-manager');
  }

  /// Load Governance Officer List Data
  /// Method: GET | Path: /v1/governance-officer | Status: mocked
  Future<ApiResponse> loadApiV1GovernanceOfficerList() async {
    return ref.read(apiClientProvider).get('/v1/governance-officer');
  }

  /// Load Head Of Bus Dev List Data
  /// Method: GET | Path: /v1/head-of-bus-dev | Status: mocked
  Future<ApiResponse> loadApiV1HeadOfBusDevList() async {
    return ref.read(apiClientProvider).get('/v1/head-of-bus-dev');
  }

  /// Load Head Of Marketing List Data
  /// Method: GET | Path: /v1/head-of-marketing | Status: mocked
  Future<ApiResponse> loadApiV1HeadOfMarketingList() async {
    return ref.read(apiClientProvider).get('/v1/head-of-marketing');
  }

  /// Load Local Marketing Manager List Data
  /// Method: GET | Path: /v1/local-marketing-manager | Status: mocked
  Future<ApiResponse> loadApiV1LocalMarketingManagerList() async {
    return ref.read(apiClientProvider).get('/v1/local-marketing-manager');
  }

  /// Load Operations Manager List Data
  /// Method: GET | Path: /v1/operations-manager | Status: mocked
  Future<ApiResponse> loadApiV1OperationsManagerList() async {
    return ref.read(apiClientProvider).get('/v1/operations-manager');
  }

  /// Load Partnership Manager List Data
  /// Method: GET | Path: /v1/partnership-manager | Status: mocked
  Future<ApiResponse> loadApiV1PartnershipManagerList() async {
    return ref.read(apiClientProvider).get('/v1/partnership-manager');
  }

  /// Load Premium Concierge List Data
  /// Method: GET | Path: /v1/premium-concierge | Status: mocked
  Future<ApiResponse> loadApiV1PremiumConciergeList() async {
    return ref.read(apiClientProvider).get('/v1/premium-concierge');
  }

  /// Load Regional Bdm List Data
  /// Method: GET | Path: /v1/regional-bdm | Status: mocked
  Future<ApiResponse> loadApiV1RegionalBdmList() async {
    return ref.read(apiClientProvider).get('/v1/regional-bdm');
  }

  /// Load Regional Manager Usa List Data
  /// Method: GET | Path: /v1/regional-manager-usa | Status: mocked
  Future<ApiResponse> loadApiV1RegionalManagerUsaList() async {
    return ref.read(apiClientProvider).get('/v1/regional-manager-usa');
  }

  /// Load Scrum Master List Data
  /// Method: GET | Path: /v1/scrum-master | Status: mocked
  Future<ApiResponse> loadApiV1ScrumMasterList() async {
    return ref.read(apiClientProvider).get('/v1/scrum-master');
  }

  /// Load Territory Expansion Manager List Data
  /// Method: GET | Path: /v1/territory-expansion-manager | Status: mocked
  Future<ApiResponse> loadApiV1TerritoryExpansionManagerList() async {
    return ref.read(apiClientProvider).get('/v1/territory-expansion-manager');
  }

  /// Load Territory Sales Manager List Data
  /// Method: GET | Path: /v1/territory-sales-manager | Status: mocked
  Future<ApiResponse> loadApiV1TerritorySalesManagerList() async {
    return ref.read(apiClientProvider).get('/v1/territory-sales-manager');
  }

  /// Load Vip Manager List Data
  /// Method: GET | Path: /v1/vip-manager | Status: mocked
  Future<ApiResponse> loadApiV1VipManagerList() async {
    return ref.read(apiClientProvider).get('/v1/vip-manager');
  }

  /// Load Psw List Data
  /// Method: GET | Path: /v1/psw | Status: mocked
  Future<ApiResponse> loadApiV1PswList() async {
    return ref.read(apiClientProvider).get('/v1/psw');
  }

  /// Load Rn List Data
  /// Method: GET | Path: /v1/rn | Status: mocked
  Future<ApiResponse> loadApiV1RnList() async {
    return ref.read(apiClientProvider).get('/v1/rn');
  }

  /// Create New Rn Record
  /// Method: POST | Path: /v1/rn | Status: mocked
  Future<ApiResponse> createApiV1RnCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rn', body: data);
  }

  /// Update Existing Rn Record
  /// Method: PATCH | Path: /v1/rn/:id | Status: mocked
  Future<ApiResponse> updateApiV1RnUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rn/$id', body: data);
  }

  /// Load Rn Field Supervisor List Data
  /// Method: GET | Path: /v1/rn-field-supervisor | Status: mocked
  Future<ApiResponse> loadApiV1RnFieldSupervisorList() async {
    return ref.read(apiClientProvider).get('/v1/rn-field-supervisor');
  }

  /// Create New Rn Field Supervisor Record
  /// Method: POST | Path: /v1/rn-field-supervisor | Status: mocked
  Future<ApiResponse> createApiV1RnFieldSupervisorCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rn-field-supervisor', body: data);
  }

  /// Update Existing Rn Field Supervisor Record
  /// Method: PATCH | Path: /v1/rn-field-supervisor/:id | Status: mocked
  Future<ApiResponse> updateApiV1RnFieldSupervisorUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rn-field-supervisor/$id', body: data);
  }

  /// Load Rpn List Data
  /// Method: GET | Path: /v1/rpn | Status: mocked
  Future<ApiResponse> loadApiV1RpnList() async {
    return ref.read(apiClientProvider).get('/v1/rpn');
  }

  /// Create New Rpn Record
  /// Method: POST | Path: /v1/rpn | Status: mocked
  Future<ApiResponse> createApiV1RpnCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rpn', body: data);
  }

  /// Update Existing Rpn Record
  /// Method: PATCH | Path: /v1/rpn/:id | Status: mocked
  Future<ApiResponse> updateApiV1RpnUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rpn/$id', body: data);
  }

  /// Load Billing Admin List Data
  /// Method: GET | Path: /v1/billing-admin | Status: mocked
  Future<ApiResponse> loadApiV1BillingAdminList() async {
    return ref.read(apiClientProvider).get('/v1/billing-admin');
  }

  /// Load Employees List Data
  /// Method: GET | Path: /v1/employees | Status: mocked
  Future<ApiResponse> loadApiV1EmployeesList() async {
    return ref.read(apiClientProvider).get('/v1/employees');
  }

  /// Load Hr Hiring List Data
  /// Method: GET | Path: /v1/hr-hiring | Status: mocked
  Future<ApiResponse> loadApiV1HrHiringList() async {
    return ref.read(apiClientProvider).get('/v1/hr-hiring');
  }

  /// Create New Hr Hiring Record
  /// Method: POST | Path: /v1/hr-hiring | Status: mocked
  Future<ApiResponse> createApiV1HrHiringCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/hr-hiring', body: data);
  }

  /// Update Existing Hr Hiring Record
  /// Method: PATCH | Path: /v1/hr-hiring/:id | Status: mocked
  Future<ApiResponse> updateApiV1HrHiringUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/hr-hiring/$id', body: data);
  }

  /// Load Hr Manager List Data
  /// Method: GET | Path: /v1/hr-manager | Status: mocked
  Future<ApiResponse> loadApiV1HrManagerList() async {
    return ref.read(apiClientProvider).get('/v1/hr-manager');
  }

  /// Load Intake Coordinator List Data
  /// Method: GET | Path: /v1/intake-coordinator | Status: mocked
  Future<ApiResponse> loadApiV1IntakeCoordinatorList() async {
    return ref.read(apiClientProvider).get('/v1/intake-coordinator');
  }

  /// Create New Intake Coordinator Record
  /// Method: POST | Path: /v1/intake-coordinator | Status: mocked
  Future<ApiResponse> createApiV1IntakeCoordinatorCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/intake-coordinator', body: data);
  }

  /// Update Existing Intake Coordinator Record
  /// Method: PATCH | Path: /v1/intake-coordinator/:id | Status: mocked
  Future<ApiResponse> updateApiV1IntakeCoordinatorUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/intake-coordinator/$id', body: data);
  }

  /// Load Quality Assurance List Data
  /// Method: GET | Path: /v1/quality-assurance | Status: mocked
  Future<ApiResponse> loadApiV1QualityAssuranceList() async {
    return ref.read(apiClientProvider).get('/v1/quality-assurance');
  }

  /// Load Receptionist List Data
  /// Method: GET | Path: /v1/receptionist | Status: mocked
  Future<ApiResponse> loadApiV1ReceptionistList() async {
    return ref.read(apiClientProvider).get('/v1/receptionist');
  }

  /// Load Scheduler List Data
  /// Method: GET | Path: /v1/scheduler | Status: mocked
  Future<ApiResponse> loadApiV1SchedulerList() async {
    return ref.read(apiClientProvider).get('/v1/scheduler');
  }

  /// Load Training Coordinator List Data
  /// Method: GET | Path: /v1/training-coordinator | Status: mocked
  Future<ApiResponse> loadApiV1TrainingCoordinatorList() async {
    return ref.read(apiClientProvider).get('/v1/training-coordinator');
  }

  /// Load Volunteer Coordinator List Data
  /// Method: GET | Path: /v1/volunteer-coordinator | Status: mocked
  Future<ApiResponse> loadApiV1VolunteerCoordinatorList() async {
    return ref.read(apiClientProvider).get('/v1/volunteer-coordinator');
  }

  /// Load Volunteer List Data
  /// Method: GET | Path: /v1/volunteer | Status: mocked
  Future<ApiResponse> loadApiV1VolunteerList() async {
    return ref.read(apiClientProvider).get('/v1/volunteer');
  }

  /// Load Rmt Analytics List Data
  /// Method: GET | Path: /v1/rmt-analytics | Status: mocked
  Future<ApiResponse> loadApiV1RmtAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/rmt-analytics');
  }

  /// Create New Rmt Analytics Record
  /// Method: POST | Path: /v1/rmt-analytics | Status: mocked
  Future<ApiResponse> createApiV1RmtAnalyticsCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rmt-analytics', body: data);
  }

  /// Update Existing Rmt Analytics Record
  /// Method: PATCH | Path: /v1/rmt-analytics/:id | Status: mocked
  Future<ApiResponse> updateApiV1RmtAnalyticsUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rmt-analytics/$id', body: data);
  }

  /// Load Rmt Compliance List Data
  /// Method: GET | Path: /v1/rmt-compliance | Status: mocked
  Future<ApiResponse> loadApiV1RmtComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/rmt-compliance');
  }

  /// Create New Rmt Compliance Record
  /// Method: POST | Path: /v1/rmt-compliance | Status: mocked
  Future<ApiResponse> createApiV1RmtComplianceCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rmt-compliance', body: data);
  }

  /// Update Existing Rmt Compliance Record
  /// Method: PATCH | Path: /v1/rmt-compliance/:id | Status: mocked
  Future<ApiResponse> updateApiV1RmtComplianceUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rmt-compliance/$id', body: data);
  }

  /// Load Rmt Workflow List Data
  /// Method: GET | Path: /v1/rmt-workflow | Status: mocked
  Future<ApiResponse> loadApiV1RmtWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/rmt-workflow');
  }

  /// Create New Rmt Workflow Record
  /// Method: POST | Path: /v1/rmt-workflow | Status: mocked
  Future<ApiResponse> createApiV1RmtWorkflowCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rmt-workflow', body: data);
  }

  /// Update Existing Rmt Workflow Record
  /// Method: PATCH | Path: /v1/rmt-workflow/:id | Status: mocked
  Future<ApiResponse> updateApiV1RmtWorkflowUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rmt-workflow/$id', body: data);
  }

  /// Load Clinical Analytics List Data
  /// Method: GET | Path: /v1/clinical-analytics | Status: mocked
  Future<ApiResponse> loadApiV1ClinicalAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/clinical-analytics');
  }

  /// Load Clinical Compliance List Data
  /// Method: GET | Path: /v1/clinical-compliance | Status: mocked
  Future<ApiResponse> loadApiV1ClinicalComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/clinical-compliance');
  }

  /// Load Clinical Workflow List Data
  /// Method: GET | Path: /v1/clinical-workflow | Status: mocked
  Future<ApiResponse> loadApiV1ClinicalWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/clinical-workflow');
  }

  /// Load Hsw Adl Logger List Data
  /// Method: GET | Path: /v1/hsw-adl-logger | Status: mocked
  Future<ApiResponse> loadApiV1HswAdlLoggerList() async {
    return ref.read(apiClientProvider).get('/v1/hsw-adl-logger');
  }

  /// Create New Hsw Adl Logger Record
  /// Method: POST | Path: /v1/hsw-adl-logger | Status: mocked
  Future<ApiResponse> createApiV1HswAdlLoggerCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/hsw-adl-logger', body: data);
  }

  /// Update Existing Hsw Adl Logger Record
  /// Method: PATCH | Path: /v1/hsw-adl-logger/:id | Status: mocked
  Future<ApiResponse> updateApiV1HswAdlLoggerUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/hsw-adl-logger/$id', body: data);
  }

  /// Load Hsw Care Plans List Data
  /// Method: GET | Path: /v1/hsw-care-plans | Status: mocked
  Future<ApiResponse> loadApiV1HswCarePlansList() async {
    return ref.read(apiClientProvider).get('/v1/hsw-care-plans');
  }

  /// Load Hsw Incident Reports List Data
  /// Method: GET | Path: /v1/hsw-incident-reports | Status: mocked
  Future<ApiResponse> loadApiV1HswIncidentReportsList() async {
    return ref.read(apiClientProvider).get('/v1/hsw-incident-reports');
  }

  /// Create New Hsw Incident Reports Record
  /// Method: POST | Path: /v1/hsw-incident-reports | Status: mocked
  Future<ApiResponse> createApiV1HswIncidentReportsCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/hsw-incident-reports', body: data);
  }

  /// Update Existing Hsw Incident Reports Record
  /// Method: PATCH | Path: /v1/hsw-incident-reports/:id | Status: mocked
  Future<ApiResponse> updateApiV1HswIncidentReportsUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/hsw-incident-reports/$id', body: data);
  }

  /// Load Hsw Schedule List Data
  /// Method: GET | Path: /v1/hsw-schedule | Status: mocked
  Future<ApiResponse> loadApiV1HswScheduleList() async {
    return ref.read(apiClientProvider).get('/v1/hsw-schedule');
  }

  /// Create New Hsw Schedule Record
  /// Method: POST | Path: /v1/hsw-schedule | Status: mocked
  Future<ApiResponse> createApiV1HswScheduleCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/hsw-schedule', body: data);
  }

  /// Update Existing Hsw Schedule Record
  /// Method: PATCH | Path: /v1/hsw-schedule/:id | Status: mocked
  Future<ApiResponse> updateApiV1HswScheduleUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/hsw-schedule/$id', body: data);
  }

  /// Load Architecture Planning Analytics List Data
  /// Method: GET | Path: /v1/architecture-planning-analytics | Status: mocked
  Future<ApiResponse> loadApiV1ArchitecturePlanningAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/architecture-planning-analytics');
  }

  /// Load Architecture Planning Compliance List Data
  /// Method: GET | Path: /v1/architecture-planning-compliance | Status: mocked
  Future<ApiResponse> loadApiV1ArchitecturePlanningComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/architecture-planning-compliance');
  }

  /// Load Architecture Planning Workflow List Data
  /// Method: GET | Path: /v1/architecture-planning-workflow | Status: mocked
  Future<ApiResponse> loadApiV1ArchitecturePlanningWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/architecture-planning-workflow');
  }

  /// Load Business Development Analytics List Data
  /// Method: GET | Path: /v1/business-development-analytics | Status: mocked
  Future<ApiResponse> loadApiV1BusinessDevelopmentAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/business-development-analytics');
  }

  /// Load Business Development Compliance List Data
  /// Method: GET | Path: /v1/business-development-compliance | Status: mocked
  Future<ApiResponse> loadApiV1BusinessDevelopmentComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/business-development-compliance');
  }

  /// Load Business Development Workflow List Data
  /// Method: GET | Path: /v1/business-development-workflow | Status: mocked
  Future<ApiResponse> loadApiV1BusinessDevelopmentWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/business-development-workflow');
  }

  /// Load Chiropractor Analytics List Data
  /// Method: GET | Path: /v1/chiropractor-analytics | Status: mocked
  Future<ApiResponse> loadApiV1ChiropractorAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/chiropractor-analytics');
  }

  /// Load Chiropractor Compliance List Data
  /// Method: GET | Path: /v1/chiropractor-compliance | Status: mocked
  Future<ApiResponse> loadApiV1ChiropractorComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/chiropractor-compliance');
  }

  /// Load Chiropractor Workflow List Data
  /// Method: GET | Path: /v1/chiropractor-workflow | Status: mocked
  Future<ApiResponse> loadApiV1ChiropractorWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/chiropractor-workflow');
  }

  /// Load Clinic Analytics List Data
  /// Method: GET | Path: /v1/clinic-analytics | Status: mocked
  Future<ApiResponse> loadApiV1ClinicAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/clinic-analytics');
  }

  /// Load Clinic Compliance List Data
  /// Method: GET | Path: /v1/clinic-compliance | Status: mocked
  Future<ApiResponse> loadApiV1ClinicComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/clinic-compliance');
  }

  /// Load Clinic Workflow List Data
  /// Method: GET | Path: /v1/clinic-workflow | Status: mocked
  Future<ApiResponse> loadApiV1ClinicWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/clinic-workflow');
  }

  /// Load Course Architect Analytics List Data
  /// Method: GET | Path: /v1/course-architect-analytics | Status: mocked
  Future<ApiResponse> loadApiV1CourseArchitectAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/course-architect-analytics');
  }

  /// Load Course Architect Compliance List Data
  /// Method: GET | Path: /v1/course-architect-compliance | Status: mocked
  Future<ApiResponse> loadApiV1CourseArchitectComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/course-architect-compliance');
  }

  /// Load Course Architect Workflow List Data
  /// Method: GET | Path: /v1/course-architect-workflow | Status: mocked
  Future<ApiResponse> loadApiV1CourseArchitectWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/course-architect-workflow');
  }

  /// Load Customer Support Analytics List Data
  /// Method: GET | Path: /v1/customer-support-analytics | Status: mocked
  Future<ApiResponse> loadApiV1CustomerSupportAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/customer-support-analytics');
  }

  /// Load Customer Support Compliance List Data
  /// Method: GET | Path: /v1/customer-support-compliance | Status: mocked
  Future<ApiResponse> loadApiV1CustomerSupportComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/customer-support-compliance');
  }

  /// Load Customer Support Workflow List Data
  /// Method: GET | Path: /v1/customer-support-workflow | Status: mocked
  Future<ApiResponse> loadApiV1CustomerSupportWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/customer-support-workflow');
  }

  /// Load Dynamic Analytics List Data
  /// Method: GET | Path: /v1/dynamic-analytics | Status: mocked
  Future<ApiResponse> loadApiV1DynamicAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/dynamic-analytics');
  }

  /// Load Dynamic Compliance List Data
  /// Method: GET | Path: /v1/dynamic-compliance | Status: mocked
  Future<ApiResponse> loadApiV1DynamicComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/dynamic-compliance');
  }

  /// Load Dynamic Workflow List Data
  /// Method: GET | Path: /v1/dynamic-workflow | Status: mocked
  Future<ApiResponse> loadApiV1DynamicWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/dynamic-workflow');
  }

  /// Load Family Member Analytics List Data
  /// Method: GET | Path: /v1/family-member-analytics | Status: mocked
  Future<ApiResponse> loadApiV1FamilyMemberAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/family-member-analytics');
  }

  /// Load Family Member Compliance List Data
  /// Method: GET | Path: /v1/family-member-compliance | Status: mocked
  Future<ApiResponse> loadApiV1FamilyMemberComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/family-member-compliance');
  }

  /// Load Family Member Workflow List Data
  /// Method: GET | Path: /v1/family-member-workflow | Status: mocked
  Future<ApiResponse> loadApiV1FamilyMemberWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/family-member-workflow');
  }

  /// Load Franchise Analytics List Data
  /// Method: GET | Path: /v1/franchise-analytics | Status: mocked
  Future<ApiResponse> loadApiV1FranchiseAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/franchise-analytics');
  }

  /// Load Franchise Compliance List Data
  /// Method: GET | Path: /v1/franchise-compliance | Status: mocked
  Future<ApiResponse> loadApiV1FranchiseComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/franchise-compliance');
  }

  /// Load Franchise Workflow List Data
  /// Method: GET | Path: /v1/franchise-workflow | Status: mocked
  Future<ApiResponse> loadApiV1FranchiseWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/franchise-workflow');
  }

  /// Load Guest Analytics List Data
  /// Method: GET | Path: /v1/guest-analytics | Status: mocked
  Future<ApiResponse> loadApiV1GuestAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/guest-analytics');
  }

  /// Load Guest Compliance List Data
  /// Method: GET | Path: /v1/guest-compliance | Status: mocked
  Future<ApiResponse> loadApiV1GuestComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/guest-compliance');
  }

  /// Load Guest Workflow List Data
  /// Method: GET | Path: /v1/guest-workflow | Status: mocked
  Future<ApiResponse> loadApiV1GuestWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/guest-workflow');
  }

  /// Load Infrastructure Analytics List Data
  /// Method: GET | Path: /v1/infrastructure-analytics | Status: mocked
  Future<ApiResponse> loadApiV1InfrastructureAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/infrastructure-analytics');
  }

  /// Load Infrastructure Compliance List Data
  /// Method: GET | Path: /v1/infrastructure-compliance | Status: mocked
  Future<ApiResponse> loadApiV1InfrastructureComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/infrastructure-compliance');
  }

  /// Load Infrastructure Workflow List Data
  /// Method: GET | Path: /v1/infrastructure-workflow | Status: mocked
  Future<ApiResponse> loadApiV1InfrastructureWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/infrastructure-workflow');
  }

  /// Load Intake Analytics List Data
  /// Method: GET | Path: /v1/intake-analytics | Status: mocked
  Future<ApiResponse> loadApiV1IntakeAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/intake-analytics');
  }

  /// Create New Intake Analytics Record
  /// Method: POST | Path: /v1/intake-analytics | Status: mocked
  Future<ApiResponse> createApiV1IntakeAnalyticsCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/intake-analytics', body: data);
  }

  /// Update Existing Intake Analytics Record
  /// Method: PATCH | Path: /v1/intake-analytics/:id | Status: mocked
  Future<ApiResponse> updateApiV1IntakeAnalyticsUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/intake-analytics/$id', body: data);
  }

  /// Load Intake Compliance List Data
  /// Method: GET | Path: /v1/intake-compliance | Status: mocked
  Future<ApiResponse> loadApiV1IntakeComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/intake-compliance');
  }

  /// Create New Intake Compliance Record
  /// Method: POST | Path: /v1/intake-compliance | Status: mocked
  Future<ApiResponse> createApiV1IntakeComplianceCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/intake-compliance', body: data);
  }

  /// Update Existing Intake Compliance Record
  /// Method: PATCH | Path: /v1/intake-compliance/:id | Status: mocked
  Future<ApiResponse> updateApiV1IntakeComplianceUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/intake-compliance/$id', body: data);
  }

  /// Load Intake Workflow List Data
  /// Method: GET | Path: /v1/intake-workflow | Status: mocked
  Future<ApiResponse> loadApiV1IntakeWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/intake-workflow');
  }

  /// Create New Intake Workflow Record
  /// Method: POST | Path: /v1/intake-workflow | Status: mocked
  Future<ApiResponse> createApiV1IntakeWorkflowCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/intake-workflow', body: data);
  }

  /// Update Existing Intake Workflow Record
  /// Method: PATCH | Path: /v1/intake-workflow/:id | Status: mocked
  Future<ApiResponse> updateApiV1IntakeWorkflowUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/intake-workflow/$id', body: data);
  }

  /// Load Office Analytics List Data
  /// Method: GET | Path: /v1/office-analytics | Status: mocked
  Future<ApiResponse> loadApiV1OfficeAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/office-analytics');
  }

  /// Load Office Compliance List Data
  /// Method: GET | Path: /v1/office-compliance | Status: mocked
  Future<ApiResponse> loadApiV1OfficeComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/office-compliance');
  }

  /// Load Office Workflow List Data
  /// Method: GET | Path: /v1/office-workflow | Status: mocked
  Future<ApiResponse> loadApiV1OfficeWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/office-workflow');
  }

  /// Load Patient Analytics List Data
  /// Method: GET | Path: /v1/patient-analytics | Status: mocked
  Future<ApiResponse> loadApiV1PatientAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/patient-analytics');
  }

  /// Load Patient Compliance List Data
  /// Method: GET | Path: /v1/patient-compliance | Status: mocked
  Future<ApiResponse> loadApiV1PatientComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/patient-compliance');
  }

  /// Load Patient Workflow List Data
  /// Method: GET | Path: /v1/patient-workflow | Status: mocked
  Future<ApiResponse> loadApiV1PatientWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/patient-workflow');
  }

  /// Load Physiotherapist Analytics List Data
  /// Method: GET | Path: /v1/physiotherapist-analytics | Status: mocked
  Future<ApiResponse> loadApiV1PhysiotherapistAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/physiotherapist-analytics');
  }

  /// Load Physiotherapist Compliance List Data
  /// Method: GET | Path: /v1/physiotherapist-compliance | Status: mocked
  Future<ApiResponse> loadApiV1PhysiotherapistComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/physiotherapist-compliance');
  }

  /// Load Physiotherapist Workflow List Data
  /// Method: GET | Path: /v1/physiotherapist-workflow | Status: mocked
  Future<ApiResponse> loadApiV1PhysiotherapistWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/physiotherapist-workflow');
  }

  /// Load Portal Analytics List Data
  /// Method: GET | Path: /v1/portal-analytics | Status: mocked
  Future<ApiResponse> loadApiV1PortalAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/portal-analytics');
  }

  /// Load Portal Compliance List Data
  /// Method: GET | Path: /v1/portal-compliance | Status: mocked
  Future<ApiResponse> loadApiV1PortalComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/portal-compliance');
  }

  /// Load Portal Workflow List Data
  /// Method: GET | Path: /v1/portal-workflow | Status: mocked
  Future<ApiResponse> loadApiV1PortalWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/portal-workflow');
  }

  /// Load Qa Analytics List Data
  /// Method: GET | Path: /v1/qa-analytics | Status: mocked
  Future<ApiResponse> loadApiV1QaAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/qa-analytics');
  }

  /// Load Qa Compliance List Data
  /// Method: GET | Path: /v1/qa-compliance | Status: mocked
  Future<ApiResponse> loadApiV1QaComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/qa-compliance');
  }

  /// Load Qa Workflow List Data
  /// Method: GET | Path: /v1/qa-workflow | Status: mocked
  Future<ApiResponse> loadApiV1QaWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/qa-workflow');
  }

  /// Load Shared Stubs List Data
  /// Method: GET | Path: /v1/shared-stubs | Status: mocked
  Future<ApiResponse> loadApiV1SharedStubsList() async {
    return ref.read(apiClientProvider).get('/v1/shared-stubs');
  }

  /// Load Social Worker Analytics List Data
  /// Method: GET | Path: /v1/social-worker-analytics | Status: mocked
  Future<ApiResponse> loadApiV1SocialWorkerAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/social-worker-analytics');
  }

  /// Load Social Worker Compliance List Data
  /// Method: GET | Path: /v1/social-worker-compliance | Status: mocked
  Future<ApiResponse> loadApiV1SocialWorkerComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/social-worker-compliance');
  }

  /// Load Social Worker Workflow List Data
  /// Method: GET | Path: /v1/social-worker-workflow | Status: mocked
  Future<ApiResponse> loadApiV1SocialWorkerWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/social-worker-workflow');
  }

  /// Load Support Analytics List Data
  /// Method: GET | Path: /v1/support-analytics | Status: mocked
  Future<ApiResponse> loadApiV1SupportAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/support-analytics');
  }

  /// Load Support Compliance List Data
  /// Method: GET | Path: /v1/support-compliance | Status: mocked
  Future<ApiResponse> loadApiV1SupportComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/support-compliance');
  }

  /// Load Support Workflow List Data
  /// Method: GET | Path: /v1/support-workflow | Status: mocked
  Future<ApiResponse> loadApiV1SupportWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/support-workflow');
  }

  /// Load System Analytics List Data
  /// Method: GET | Path: /v1/system-analytics | Status: mocked
  Future<ApiResponse> loadApiV1SystemAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/system-analytics');
  }

  /// Load System Compliance List Data
  /// Method: GET | Path: /v1/system-compliance | Status: mocked
  Future<ApiResponse> loadApiV1SystemComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/system-compliance');
  }

  /// Load System Verification Analytics List Data
  /// Method: GET | Path: /v1/system-verification-analytics | Status: mocked
  Future<ApiResponse> loadApiV1SystemVerificationAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/system-verification-analytics');
  }

  /// Load System Verification Compliance List Data
  /// Method: GET | Path: /v1/system-verification-compliance | Status: mocked
  Future<ApiResponse> loadApiV1SystemVerificationComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/system-verification-compliance');
  }

  /// Load System Verification Workflow List Data
  /// Method: GET | Path: /v1/system-verification-workflow | Status: mocked
  Future<ApiResponse> loadApiV1SystemVerificationWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/system-verification-workflow');
  }

  /// Load System Workflow List Data
  /// Method: GET | Path: /v1/system-workflow | Status: mocked
  Future<ApiResponse> loadApiV1SystemWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/system-workflow');
  }

  /// Load Training Hub Analytics List Data
  /// Method: GET | Path: /v1/training-hub-analytics | Status: mocked
  Future<ApiResponse> loadApiV1TrainingHubAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/training-hub-analytics');
  }

  /// Load Training Hub Compliance List Data
  /// Method: GET | Path: /v1/training-hub-compliance | Status: mocked
  Future<ApiResponse> loadApiV1TrainingHubComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/training-hub-compliance');
  }

  /// Load Training Hub Workflow List Data
  /// Method: GET | Path: /v1/training-hub-workflow | Status: mocked
  Future<ApiResponse> loadApiV1TrainingHubWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/training-hub-workflow');
  }

  /// Load Cfo Analytics List Data
  /// Method: GET | Path: /v1/cfo-analytics | Status: mocked
  Future<ApiResponse> loadApiV1CfoAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/cfo-analytics');
  }

  /// Load Cfo Compliance List Data
  /// Method: GET | Path: /v1/cfo-compliance | Status: mocked
  Future<ApiResponse> loadApiV1CfoComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/cfo-compliance');
  }

  /// Load Cfo Workflow List Data
  /// Method: GET | Path: /v1/cfo-workflow | Status: mocked
  Future<ApiResponse> loadApiV1CfoWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/cfo-workflow');
  }

  /// Load Ciso Analytics List Data
  /// Method: GET | Path: /v1/ciso-analytics | Status: mocked
  Future<ApiResponse> loadApiV1CisoAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/ciso-analytics');
  }

  /// Create New Ciso Analytics Record
  /// Method: POST | Path: /v1/ciso-analytics | Status: mocked
  Future<ApiResponse> createApiV1CisoAnalyticsCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/ciso-analytics', body: data);
  }

  /// Update Existing Ciso Analytics Record
  /// Method: PATCH | Path: /v1/ciso-analytics/:id | Status: mocked
  Future<ApiResponse> updateApiV1CisoAnalyticsUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/ciso-analytics/$id', body: data);
  }

  /// Load Ciso Compliance List Data
  /// Method: GET | Path: /v1/ciso-compliance | Status: mocked
  Future<ApiResponse> loadApiV1CisoComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/ciso-compliance');
  }

  /// Create New Ciso Compliance Record
  /// Method: POST | Path: /v1/ciso-compliance | Status: mocked
  Future<ApiResponse> createApiV1CisoComplianceCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/ciso-compliance', body: data);
  }

  /// Update Existing Ciso Compliance Record
  /// Method: PATCH | Path: /v1/ciso-compliance/:id | Status: mocked
  Future<ApiResponse> updateApiV1CisoComplianceUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/ciso-compliance/$id', body: data);
  }

  /// Load Ciso Workflow List Data
  /// Method: GET | Path: /v1/ciso-workflow | Status: mocked
  Future<ApiResponse> loadApiV1CisoWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/ciso-workflow');
  }

  /// Create New Ciso Workflow Record
  /// Method: POST | Path: /v1/ciso-workflow | Status: mocked
  Future<ApiResponse> createApiV1CisoWorkflowCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/ciso-workflow', body: data);
  }

  /// Update Existing Ciso Workflow Record
  /// Method: PATCH | Path: /v1/ciso-workflow/:id | Status: mocked
  Future<ApiResponse> updateApiV1CisoWorkflowUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/ciso-workflow/$id', body: data);
  }

  /// Load Coo Analytics List Data
  /// Method: GET | Path: /v1/coo-analytics | Status: mocked
  Future<ApiResponse> loadApiV1CooAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/coo-analytics');
  }

  /// Load Coo Compliance List Data
  /// Method: GET | Path: /v1/coo-compliance | Status: mocked
  Future<ApiResponse> loadApiV1CooComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/coo-compliance');
  }

  /// Load Coo Workflow List Data
  /// Method: GET | Path: /v1/coo-workflow | Status: mocked
  Future<ApiResponse> loadApiV1CooWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/coo-workflow');
  }

  /// Load Cto Analytics List Data
  /// Method: GET | Path: /v1/cto-analytics | Status: mocked
  Future<ApiResponse> loadApiV1CtoAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/cto-analytics');
  }

  /// Load Cto Compliance List Data
  /// Method: GET | Path: /v1/cto-compliance | Status: mocked
  Future<ApiResponse> loadApiV1CtoComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/cto-compliance');
  }

  /// Load Cto Workflow List Data
  /// Method: GET | Path: /v1/cto-workflow | Status: mocked
  Future<ApiResponse> loadApiV1CtoWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/cto-workflow');
  }

  /// Load Cx Director Analytics List Data
  /// Method: GET | Path: /v1/cx-director-analytics | Status: mocked
  Future<ApiResponse> loadApiV1CxDirectorAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/cx-director-analytics');
  }

  /// Load Cx Director Compliance List Data
  /// Method: GET | Path: /v1/cx-director-compliance | Status: mocked
  Future<ApiResponse> loadApiV1CxDirectorComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/cx-director-compliance');
  }

  /// Load Cx Director Workflow List Data
  /// Method: GET | Path: /v1/cx-director-workflow | Status: mocked
  Future<ApiResponse> loadApiV1CxDirectorWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/cx-director-workflow');
  }

  /// Load Finance Director Analytics List Data
  /// Method: GET | Path: /v1/finance-director-analytics | Status: mocked
  Future<ApiResponse> loadApiV1FinanceDirectorAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/finance-director-analytics');
  }

  /// Load Finance Director Compliance List Data
  /// Method: GET | Path: /v1/finance-director-compliance | Status: mocked
  Future<ApiResponse> loadApiV1FinanceDirectorComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/finance-director-compliance');
  }

  /// Load Finance Director Workflow List Data
  /// Method: GET | Path: /v1/finance-director-workflow | Status: mocked
  Future<ApiResponse> loadApiV1FinanceDirectorWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/finance-director-workflow');
  }

  /// Load Hr Director Analytics List Data
  /// Method: GET | Path: /v1/hr-director-analytics | Status: mocked
  Future<ApiResponse> loadApiV1HrDirectorAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/hr-director-analytics');
  }

  /// Load Hr Director Compliance List Data
  /// Method: GET | Path: /v1/hr-director-compliance | Status: mocked
  Future<ApiResponse> loadApiV1HrDirectorComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/hr-director-compliance');
  }

  /// Load Hr Director Workflow List Data
  /// Method: GET | Path: /v1/hr-director-workflow | Status: mocked
  Future<ApiResponse> loadApiV1HrDirectorWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/hr-director-workflow');
  }

  /// Load Legal Analytics List Data
  /// Method: GET | Path: /v1/legal-analytics | Status: mocked
  Future<ApiResponse> loadApiV1LegalAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/legal-analytics');
  }

  /// Load Legal Compliance List Data
  /// Method: GET | Path: /v1/legal-compliance | Status: mocked
  Future<ApiResponse> loadApiV1LegalComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/legal-compliance');
  }

  /// Load Legal Workflow List Data
  /// Method: GET | Path: /v1/legal-workflow | Status: mocked
  Future<ApiResponse> loadApiV1LegalWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/legal-workflow');
  }

  /// Load Owner Analytics List Data
  /// Method: GET | Path: /v1/owner-analytics | Status: mocked
  Future<ApiResponse> loadApiV1OwnerAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/owner-analytics');
  }

  /// Load Owner Compliance List Data
  /// Method: GET | Path: /v1/owner-compliance | Status: mocked
  Future<ApiResponse> loadApiV1OwnerComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/owner-compliance');
  }

  /// Load Owner Workflow List Data
  /// Method: GET | Path: /v1/owner-workflow | Status: mocked
  Future<ApiResponse> loadApiV1OwnerWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/owner-workflow');
  }

  /// Load Shareholder Analytics List Data
  /// Method: GET | Path: /v1/shareholder-analytics | Status: mocked
  Future<ApiResponse> loadApiV1ShareholderAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/shareholder-analytics');
  }

  /// Load Shareholder Compliance List Data
  /// Method: GET | Path: /v1/shareholder-compliance | Status: mocked
  Future<ApiResponse> loadApiV1ShareholderComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/shareholder-compliance');
  }

  /// Load Shareholder Workflow List Data
  /// Method: GET | Path: /v1/shareholder-workflow | Status: mocked
  Future<ApiResponse> loadApiV1ShareholderWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/shareholder-workflow');
  }

  /// Load Training Director Analytics List Data
  /// Method: GET | Path: /v1/training-director-analytics | Status: mocked
  Future<ApiResponse> loadApiV1TrainingDirectorAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/training-director-analytics');
  }

  /// Load Training Director Compliance List Data
  /// Method: GET | Path: /v1/training-director-compliance | Status: mocked
  Future<ApiResponse> loadApiV1TrainingDirectorComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/training-director-compliance');
  }

  /// Load Training Director Workflow List Data
  /// Method: GET | Path: /v1/training-director-workflow | Status: mocked
  Future<ApiResponse> loadApiV1TrainingDirectorWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/training-director-workflow');
  }

  /// Load Community Outreach Analytics List Data
  /// Method: GET | Path: /v1/community-outreach-analytics | Status: mocked
  Future<ApiResponse> loadApiV1CommunityOutreachAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/community-outreach-analytics');
  }

  /// Load Community Outreach Compliance List Data
  /// Method: GET | Path: /v1/community-outreach-compliance | Status: mocked
  Future<ApiResponse> loadApiV1CommunityOutreachComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/community-outreach-compliance');
  }

  /// Load Community Outreach Workflow List Data
  /// Method: GET | Path: /v1/community-outreach-workflow | Status: mocked
  Future<ApiResponse> loadApiV1CommunityOutreachWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/community-outreach-workflow');
  }

  /// Load Compliance Manager Analytics List Data
  /// Method: GET | Path: /v1/compliance-manager-analytics | Status: mocked
  Future<ApiResponse> loadApiV1ComplianceManagerAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/compliance-manager-analytics');
  }

  /// Load Compliance Manager Compliance List Data
  /// Method: GET | Path: /v1/compliance-manager-compliance | Status: mocked
  Future<ApiResponse> loadApiV1ComplianceManagerComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/compliance-manager-compliance');
  }

  /// Load Compliance Manager Workflow List Data
  /// Method: GET | Path: /v1/compliance-manager-workflow | Status: mocked
  Future<ApiResponse> loadApiV1ComplianceManagerWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/compliance-manager-workflow');
  }

  /// Load Franchise Sales Manager Analytics List Data
  /// Method: GET | Path: /v1/franchise-sales-manager-analytics | Status: mocked
  Future<ApiResponse> loadApiV1FranchiseSalesManagerAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/franchise-sales-manager-analytics');
  }

  /// Load Franchise Sales Manager Compliance List Data
  /// Method: GET | Path: /v1/franchise-sales-manager-compliance | Status: mocked
  Future<ApiResponse> loadApiV1FranchiseSalesManagerComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/franchise-sales-manager-compliance');
  }

  /// Load Franchise Sales Manager Workflow List Data
  /// Method: GET | Path: /v1/franchise-sales-manager-workflow | Status: mocked
  Future<ApiResponse> loadApiV1FranchiseSalesManagerWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/franchise-sales-manager-workflow');
  }

  /// Load General Manager Analytics List Data
  /// Method: GET | Path: /v1/general-manager-analytics | Status: mocked
  Future<ApiResponse> loadApiV1GeneralManagerAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/general-manager-analytics');
  }

  /// Load General Manager Compliance List Data
  /// Method: GET | Path: /v1/general-manager-compliance | Status: mocked
  Future<ApiResponse> loadApiV1GeneralManagerComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/general-manager-compliance');
  }

  /// Load General Manager Workflow List Data
  /// Method: GET | Path: /v1/general-manager-workflow | Status: mocked
  Future<ApiResponse> loadApiV1GeneralManagerWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/general-manager-workflow');
  }

  /// Load Governance Officer Analytics List Data
  /// Method: GET | Path: /v1/governance-officer-analytics | Status: mocked
  Future<ApiResponse> loadApiV1GovernanceOfficerAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/governance-officer-analytics');
  }

  /// Load Governance Officer Compliance List Data
  /// Method: GET | Path: /v1/governance-officer-compliance | Status: mocked
  Future<ApiResponse> loadApiV1GovernanceOfficerComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/governance-officer-compliance');
  }

  /// Load Governance Officer Workflow List Data
  /// Method: GET | Path: /v1/governance-officer-workflow | Status: mocked
  Future<ApiResponse> loadApiV1GovernanceOfficerWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/governance-officer-workflow');
  }

  /// Load Head Of Bus Dev Analytics List Data
  /// Method: GET | Path: /v1/head-of-bus-dev-analytics | Status: mocked
  Future<ApiResponse> loadApiV1HeadOfBusDevAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/head-of-bus-dev-analytics');
  }

  /// Load Head Of Bus Dev Compliance List Data
  /// Method: GET | Path: /v1/head-of-bus-dev-compliance | Status: mocked
  Future<ApiResponse> loadApiV1HeadOfBusDevComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/head-of-bus-dev-compliance');
  }

  /// Load Head Of Bus Dev Workflow List Data
  /// Method: GET | Path: /v1/head-of-bus-dev-workflow | Status: mocked
  Future<ApiResponse> loadApiV1HeadOfBusDevWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/head-of-bus-dev-workflow');
  }

  /// Load Head Of Marketing Analytics List Data
  /// Method: GET | Path: /v1/head-of-marketing-analytics | Status: mocked
  Future<ApiResponse> loadApiV1HeadOfMarketingAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/head-of-marketing-analytics');
  }

  /// Load Head Of Marketing Compliance List Data
  /// Method: GET | Path: /v1/head-of-marketing-compliance | Status: mocked
  Future<ApiResponse> loadApiV1HeadOfMarketingComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/head-of-marketing-compliance');
  }

  /// Load Head Of Marketing Workflow List Data
  /// Method: GET | Path: /v1/head-of-marketing-workflow | Status: mocked
  Future<ApiResponse> loadApiV1HeadOfMarketingWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/head-of-marketing-workflow');
  }

  /// Load Local Marketing Manager Analytics List Data
  /// Method: GET | Path: /v1/local-marketing-manager-analytics | Status: mocked
  Future<ApiResponse> loadApiV1LocalMarketingManagerAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/local-marketing-manager-analytics');
  }

  /// Load Local Marketing Manager Compliance List Data
  /// Method: GET | Path: /v1/local-marketing-manager-compliance | Status: mocked
  Future<ApiResponse> loadApiV1LocalMarketingManagerComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/local-marketing-manager-compliance');
  }

  /// Load Local Marketing Manager Workflow List Data
  /// Method: GET | Path: /v1/local-marketing-manager-workflow | Status: mocked
  Future<ApiResponse> loadApiV1LocalMarketingManagerWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/local-marketing-manager-workflow');
  }

  /// Load Operations Manager Analytics List Data
  /// Method: GET | Path: /v1/operations-manager-analytics | Status: mocked
  Future<ApiResponse> loadApiV1OperationsManagerAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/operations-manager-analytics');
  }

  /// Load Operations Manager Compliance List Data
  /// Method: GET | Path: /v1/operations-manager-compliance | Status: mocked
  Future<ApiResponse> loadApiV1OperationsManagerComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/operations-manager-compliance');
  }

  /// Load Operations Manager Workflow List Data
  /// Method: GET | Path: /v1/operations-manager-workflow | Status: mocked
  Future<ApiResponse> loadApiV1OperationsManagerWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/operations-manager-workflow');
  }

  /// Load Partnership Manager Analytics List Data
  /// Method: GET | Path: /v1/partnership-manager-analytics | Status: mocked
  Future<ApiResponse> loadApiV1PartnershipManagerAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/partnership-manager-analytics');
  }

  /// Load Partnership Manager Compliance List Data
  /// Method: GET | Path: /v1/partnership-manager-compliance | Status: mocked
  Future<ApiResponse> loadApiV1PartnershipManagerComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/partnership-manager-compliance');
  }

  /// Load Partnership Manager Workflow List Data
  /// Method: GET | Path: /v1/partnership-manager-workflow | Status: mocked
  Future<ApiResponse> loadApiV1PartnershipManagerWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/partnership-manager-workflow');
  }

  /// Load Regional Bdm Analytics List Data
  /// Method: GET | Path: /v1/regional-bdm-analytics | Status: mocked
  Future<ApiResponse> loadApiV1RegionalBdmAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/regional-bdm-analytics');
  }

  /// Load Regional Bdm Compliance List Data
  /// Method: GET | Path: /v1/regional-bdm-compliance | Status: mocked
  Future<ApiResponse> loadApiV1RegionalBdmComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/regional-bdm-compliance');
  }

  /// Load Regional Bdm Workflow List Data
  /// Method: GET | Path: /v1/regional-bdm-workflow | Status: mocked
  Future<ApiResponse> loadApiV1RegionalBdmWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/regional-bdm-workflow');
  }

  /// Load Regional Manager Usa Analytics List Data
  /// Method: GET | Path: /v1/regional-manager-usa-analytics | Status: mocked
  Future<ApiResponse> loadApiV1RegionalManagerUsaAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/regional-manager-usa-analytics');
  }

  /// Load Regional Manager Usa Compliance List Data
  /// Method: GET | Path: /v1/regional-manager-usa-compliance | Status: mocked
  Future<ApiResponse> loadApiV1RegionalManagerUsaComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/regional-manager-usa-compliance');
  }

  /// Load Regional Manager Usa Workflow List Data
  /// Method: GET | Path: /v1/regional-manager-usa-workflow | Status: mocked
  Future<ApiResponse> loadApiV1RegionalManagerUsaWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/regional-manager-usa-workflow');
  }

  /// Load Scrum Master Analytics List Data
  /// Method: GET | Path: /v1/scrum-master-analytics | Status: mocked
  Future<ApiResponse> loadApiV1ScrumMasterAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/scrum-master-analytics');
  }

  /// Load Scrum Master Compliance List Data
  /// Method: GET | Path: /v1/scrum-master-compliance | Status: mocked
  Future<ApiResponse> loadApiV1ScrumMasterComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/scrum-master-compliance');
  }

  /// Load Scrum Master Workflow List Data
  /// Method: GET | Path: /v1/scrum-master-workflow | Status: mocked
  Future<ApiResponse> loadApiV1ScrumMasterWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/scrum-master-workflow');
  }

  /// Load Territory Expansion Manager Analytics List Data
  /// Method: GET | Path: /v1/territory-expansion-manager-analytics | Status: mocked
  Future<ApiResponse> loadApiV1TerritoryExpansionManagerAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/territory-expansion-manager-analytics');
  }

  /// Load Territory Expansion Manager Compliance List Data
  /// Method: GET | Path: /v1/territory-expansion-manager-compliance | Status: mocked
  Future<ApiResponse> loadApiV1TerritoryExpansionManagerComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/territory-expansion-manager-compliance');
  }

  /// Load Territory Expansion Manager Workflow List Data
  /// Method: GET | Path: /v1/territory-expansion-manager-workflow | Status: mocked
  Future<ApiResponse> loadApiV1TerritoryExpansionManagerWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/territory-expansion-manager-workflow');
  }

  /// Load Territory Sales Manager Analytics List Data
  /// Method: GET | Path: /v1/territory-sales-manager-analytics | Status: mocked
  Future<ApiResponse> loadApiV1TerritorySalesManagerAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/territory-sales-manager-analytics');
  }

  /// Load Territory Sales Manager Compliance List Data
  /// Method: GET | Path: /v1/territory-sales-manager-compliance | Status: mocked
  Future<ApiResponse> loadApiV1TerritorySalesManagerComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/territory-sales-manager-compliance');
  }

  /// Load Territory Sales Manager Workflow List Data
  /// Method: GET | Path: /v1/territory-sales-manager-workflow | Status: mocked
  Future<ApiResponse> loadApiV1TerritorySalesManagerWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/territory-sales-manager-workflow');
  }

  /// Load Psw Analytics List Data
  /// Method: GET | Path: /v1/psw-analytics | Status: mocked
  Future<ApiResponse> loadApiV1PswAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/psw-analytics');
  }

  /// Create New Psw Analytics Record
  /// Method: POST | Path: /v1/psw-analytics | Status: mocked
  Future<ApiResponse> createApiV1PswAnalyticsCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/psw-analytics', body: data);
  }

  /// Update Existing Psw Analytics Record
  /// Method: PATCH | Path: /v1/psw-analytics/:id | Status: mocked
  Future<ApiResponse> updateApiV1PswAnalyticsUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/psw-analytics/$id', body: data);
  }

  /// Load Psw Clients List Data
  /// Method: GET | Path: /v1/psw-clients | Status: mocked
  Future<ApiResponse> loadApiV1PswClientsList() async {
    return ref.read(apiClientProvider).get('/v1/psw-clients');
  }

  /// Create New Psw Clients Record
  /// Method: POST | Path: /v1/psw-clients | Status: mocked
  Future<ApiResponse> createApiV1PswClientsCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/psw-clients', body: data);
  }

  /// Update Existing Psw Clients Record
  /// Method: PATCH | Path: /v1/psw-clients/:id | Status: mocked
  Future<ApiResponse> updateApiV1PswClientsUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/psw-clients/$id', body: data);
  }

  /// Load Psw Compliance List Data
  /// Method: GET | Path: /v1/psw-compliance | Status: mocked
  Future<ApiResponse> loadApiV1PswComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/psw-compliance');
  }

  /// Load Psw Messages List Data
  /// Method: GET | Path: /v1/psw-messages | Status: mocked
  Future<ApiResponse> loadApiV1PswMessagesList() async {
    return ref.read(apiClientProvider).get('/v1/psw-messages');
  }

  /// Load Psw Shift Tracker List Data
  /// Method: GET | Path: /v1/psw-shift-tracker | Status: mocked
  Future<ApiResponse> loadApiV1PswShiftTrackerList() async {
    return ref.read(apiClientProvider).get('/v1/psw-shift-tracker');
  }

  /// Load Psw Tasks List Data
  /// Method: GET | Path: /v1/psw-tasks | Status: mocked
  Future<ApiResponse> loadApiV1PswTasksList() async {
    return ref.read(apiClientProvider).get('/v1/psw-tasks');
  }

  /// Load Psw Visit Notes List Data
  /// Method: GET | Path: /v1/psw-visit-notes | Status: mocked
  Future<ApiResponse> loadApiV1PswVisitNotesList() async {
    return ref.read(apiClientProvider).get('/v1/psw-visit-notes');
  }

  /// Create New Psw Visit Notes Record
  /// Method: POST | Path: /v1/psw-visit-notes | Status: mocked
  Future<ApiResponse> createApiV1PswVisitNotesCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/psw-visit-notes', body: data);
  }

  /// Update Existing Psw Visit Notes Record
  /// Method: PATCH | Path: /v1/psw-visit-notes/:id | Status: mocked
  Future<ApiResponse> updateApiV1PswVisitNotesUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/psw-visit-notes/$id', body: data);
  }

  /// Load Psw Workflow List Data
  /// Method: GET | Path: /v1/psw-workflow | Status: mocked
  Future<ApiResponse> loadApiV1PswWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/psw-workflow');
  }

  /// Create New Psw Workflow Record
  /// Method: POST | Path: /v1/psw-workflow | Status: mocked
  Future<ApiResponse> createApiV1PswWorkflowCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/psw-workflow', body: data);
  }

  /// Update Existing Psw Workflow Record
  /// Method: PATCH | Path: /v1/psw-workflow/:id | Status: mocked
  Future<ApiResponse> updateApiV1PswWorkflowUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/psw-workflow/$id', body: data);
  }

  /// Load Rn Analytics List Data
  /// Method: GET | Path: /v1/rn-analytics | Status: mocked
  Future<ApiResponse> loadApiV1RnAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/rn-analytics');
  }

  /// Create New Rn Analytics Record
  /// Method: POST | Path: /v1/rn-analytics | Status: mocked
  Future<ApiResponse> createApiV1RnAnalyticsCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rn-analytics', body: data);
  }

  /// Update Existing Rn Analytics Record
  /// Method: PATCH | Path: /v1/rn-analytics/:id | Status: mocked
  Future<ApiResponse> updateApiV1RnAnalyticsUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rn-analytics/$id', body: data);
  }

  /// Load Rn Assessments List Data
  /// Method: GET | Path: /v1/rn-assessments | Status: mocked
  Future<ApiResponse> loadApiV1RnAssessmentsList() async {
    return ref.read(apiClientProvider).get('/v1/rn-assessments');
  }

  /// Create New Rn Assessments Record
  /// Method: POST | Path: /v1/rn-assessments | Status: mocked
  Future<ApiResponse> createApiV1RnAssessmentsCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rn-assessments', body: data);
  }

  /// Update Existing Rn Assessments Record
  /// Method: PATCH | Path: /v1/rn-assessments/:id | Status: mocked
  Future<ApiResponse> updateApiV1RnAssessmentsUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rn-assessments/$id', body: data);
  }

  /// Load Rn Care Plans List Data
  /// Method: GET | Path: /v1/rn-care-plans | Status: mocked
  Future<ApiResponse> loadApiV1RnCarePlansList() async {
    return ref.read(apiClientProvider).get('/v1/rn-care-plans');
  }

  /// Create New Rn Care Plans Record
  /// Method: POST | Path: /v1/rn-care-plans | Status: mocked
  Future<ApiResponse> createApiV1RnCarePlansCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rn-care-plans', body: data);
  }

  /// Update Existing Rn Care Plans Record
  /// Method: PATCH | Path: /v1/rn-care-plans/:id | Status: mocked
  Future<ApiResponse> updateApiV1RnCarePlansUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rn-care-plans/$id', body: data);
  }

  /// Load Rn Compliance List Data
  /// Method: GET | Path: /v1/rn-compliance | Status: mocked
  Future<ApiResponse> loadApiV1RnComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/rn-compliance');
  }

  /// Create New Rn Compliance Record
  /// Method: POST | Path: /v1/rn-compliance | Status: mocked
  Future<ApiResponse> createApiV1RnComplianceCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rn-compliance', body: data);
  }

  /// Update Existing Rn Compliance Record
  /// Method: PATCH | Path: /v1/rn-compliance/:id | Status: mocked
  Future<ApiResponse> updateApiV1RnComplianceUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rn-compliance/$id', body: data);
  }

  /// Load Rn Workflow List Data
  /// Method: GET | Path: /v1/rn-workflow | Status: mocked
  Future<ApiResponse> loadApiV1RnWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/rn-workflow');
  }

  /// Create New Rn Workflow Record
  /// Method: POST | Path: /v1/rn-workflow | Status: mocked
  Future<ApiResponse> createApiV1RnWorkflowCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rn-workflow', body: data);
  }

  /// Update Existing Rn Workflow Record
  /// Method: PATCH | Path: /v1/rn-workflow/:id | Status: mocked
  Future<ApiResponse> updateApiV1RnWorkflowUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rn-workflow/$id', body: data);
  }

  /// Load Rpn Analytics List Data
  /// Method: GET | Path: /v1/rpn-analytics | Status: mocked
  Future<ApiResponse> loadApiV1RpnAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/rpn-analytics');
  }

  /// Create New Rpn Analytics Record
  /// Method: POST | Path: /v1/rpn-analytics | Status: mocked
  Future<ApiResponse> createApiV1RpnAnalyticsCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rpn-analytics', body: data);
  }

  /// Update Existing Rpn Analytics Record
  /// Method: PATCH | Path: /v1/rpn-analytics/:id | Status: mocked
  Future<ApiResponse> updateApiV1RpnAnalyticsUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rpn-analytics/$id', body: data);
  }

  /// Load Rpn Compliance List Data
  /// Method: GET | Path: /v1/rpn-compliance | Status: mocked
  Future<ApiResponse> loadApiV1RpnComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/rpn-compliance');
  }

  /// Create New Rpn Compliance Record
  /// Method: POST | Path: /v1/rpn-compliance | Status: mocked
  Future<ApiResponse> createApiV1RpnComplianceCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rpn-compliance', body: data);
  }

  /// Update Existing Rpn Compliance Record
  /// Method: PATCH | Path: /v1/rpn-compliance/:id | Status: mocked
  Future<ApiResponse> updateApiV1RpnComplianceUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rpn-compliance/$id', body: data);
  }

  /// Load Rpn Workflow List Data
  /// Method: GET | Path: /v1/rpn-workflow | Status: mocked
  Future<ApiResponse> loadApiV1RpnWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/rpn-workflow');
  }

  /// Create New Rpn Workflow Record
  /// Method: POST | Path: /v1/rpn-workflow | Status: mocked
  Future<ApiResponse> createApiV1RpnWorkflowCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rpn-workflow', body: data);
  }

  /// Update Existing Rpn Workflow Record
  /// Method: PATCH | Path: /v1/rpn-workflow/:id | Status: mocked
  Future<ApiResponse> updateApiV1RpnWorkflowUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rpn-workflow/$id', body: data);
  }

  /// Load Billing Admin Analytics List Data
  /// Method: GET | Path: /v1/billing-admin-analytics | Status: mocked
  Future<ApiResponse> loadApiV1BillingAdminAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/billing-admin-analytics');
  }

  /// Load Billing Admin Compliance List Data
  /// Method: GET | Path: /v1/billing-admin-compliance | Status: mocked
  Future<ApiResponse> loadApiV1BillingAdminComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/billing-admin-compliance');
  }

  /// Load Billing Admin Workflow List Data
  /// Method: GET | Path: /v1/billing-admin-workflow | Status: mocked
  Future<ApiResponse> loadApiV1BillingAdminWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/billing-admin-workflow');
  }

  /// Load Coordinator Dispatch Map List Data
  /// Method: GET | Path: /v1/coordinator-dispatch-map | Status: mocked
  Future<ApiResponse> loadApiV1CoordinatorDispatchMapList() async {
    return ref.read(apiClientProvider).get('/v1/coordinator-dispatch-map');
  }

  /// Load Coordinator Hub List Data
  /// Method: GET | Path: /v1/coordinator-hub | Status: mocked
  Future<ApiResponse> loadApiV1CoordinatorHubList() async {
    return ref.read(apiClientProvider).get('/v1/coordinator-hub');
  }

  /// Load Coordinator Sos List Data
  /// Method: GET | Path: /v1/coordinator-sos | Status: mocked
  Future<ApiResponse> loadApiV1CoordinatorSosList() async {
    return ref.read(apiClientProvider).get('/v1/coordinator-sos');
  }

  /// Create New Coordinator Sos Record
  /// Method: POST | Path: /v1/coordinator-sos | Status: mocked
  Future<ApiResponse> createApiV1CoordinatorSosCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/coordinator-sos', body: data);
  }

  /// Update Existing Coordinator Sos Record
  /// Method: PATCH | Path: /v1/coordinator-sos/:id | Status: mocked
  Future<ApiResponse> updateApiV1CoordinatorSosUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/coordinator-sos/$id', body: data);
  }

  /// Load Coordinator Waitlist List Data
  /// Method: GET | Path: /v1/coordinator-waitlist | Status: mocked
  Future<ApiResponse> loadApiV1CoordinatorWaitlistList() async {
    return ref.read(apiClientProvider).get('/v1/coordinator-waitlist');
  }

  /// Load Hr Hiring Analytics List Data
  /// Method: GET | Path: /v1/hr-hiring-analytics | Status: mocked
  Future<ApiResponse> loadApiV1HrHiringAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/hr-hiring-analytics');
  }

  /// Load Hr Hiring Compliance List Data
  /// Method: GET | Path: /v1/hr-hiring-compliance | Status: mocked
  Future<ApiResponse> loadApiV1HrHiringComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/hr-hiring-compliance');
  }

  /// Load Hr Hiring Workflow List Data
  /// Method: GET | Path: /v1/hr-hiring-workflow | Status: mocked
  Future<ApiResponse> loadApiV1HrHiringWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/hr-hiring-workflow');
  }

  /// Load Hr Manager Analytics List Data
  /// Method: GET | Path: /v1/hr-manager-analytics | Status: mocked
  Future<ApiResponse> loadApiV1HrManagerAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/hr-manager-analytics');
  }

  /// Load Hr Manager Compliance List Data
  /// Method: GET | Path: /v1/hr-manager-compliance | Status: mocked
  Future<ApiResponse> loadApiV1HrManagerComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/hr-manager-compliance');
  }

  /// Load Hr Manager Workflow List Data
  /// Method: GET | Path: /v1/hr-manager-workflow | Status: mocked
  Future<ApiResponse> loadApiV1HrManagerWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/hr-manager-workflow');
  }

  /// Load Intake Coordinator Analytics List Data
  /// Method: GET | Path: /v1/intake-coordinator-analytics | Status: mocked
  Future<ApiResponse> loadApiV1IntakeCoordinatorAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/intake-coordinator-analytics');
  }

  /// Create New Intake Coordinator Analytics Record
  /// Method: POST | Path: /v1/intake-coordinator-analytics | Status: mocked
  Future<ApiResponse> createApiV1IntakeCoordinatorAnalyticsCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/intake-coordinator-analytics', body: data);
  }

  /// Update Existing Intake Coordinator Analytics Record
  /// Method: PATCH | Path: /v1/intake-coordinator-analytics/:id | Status: mocked
  Future<ApiResponse> updateApiV1IntakeCoordinatorAnalyticsUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/intake-coordinator-analytics/$id', body: data);
  }

  /// Load Intake Coordinator Compliance List Data
  /// Method: GET | Path: /v1/intake-coordinator-compliance | Status: mocked
  Future<ApiResponse> loadApiV1IntakeCoordinatorComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/intake-coordinator-compliance');
  }

  /// Create New Intake Coordinator Compliance Record
  /// Method: POST | Path: /v1/intake-coordinator-compliance | Status: mocked
  Future<ApiResponse> createApiV1IntakeCoordinatorComplianceCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/intake-coordinator-compliance', body: data);
  }

  /// Update Existing Intake Coordinator Compliance Record
  /// Method: PATCH | Path: /v1/intake-coordinator-compliance/:id | Status: mocked
  Future<ApiResponse> updateApiV1IntakeCoordinatorComplianceUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/intake-coordinator-compliance/$id', body: data);
  }

  /// Load Intake Coordinator Workflow List Data
  /// Method: GET | Path: /v1/intake-coordinator-workflow | Status: mocked
  Future<ApiResponse> loadApiV1IntakeCoordinatorWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/intake-coordinator-workflow');
  }

  /// Create New Intake Coordinator Workflow Record
  /// Method: POST | Path: /v1/intake-coordinator-workflow | Status: mocked
  Future<ApiResponse> createApiV1IntakeCoordinatorWorkflowCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/intake-coordinator-workflow', body: data);
  }

  /// Update Existing Intake Coordinator Workflow Record
  /// Method: PATCH | Path: /v1/intake-coordinator-workflow/:id | Status: mocked
  Future<ApiResponse> updateApiV1IntakeCoordinatorWorkflowUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/intake-coordinator-workflow/$id', body: data);
  }

  /// Load Quality Assurance Analytics List Data
  /// Method: GET | Path: /v1/quality-assurance-analytics | Status: mocked
  Future<ApiResponse> loadApiV1QualityAssuranceAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/quality-assurance-analytics');
  }

  /// Load Quality Assurance Compliance List Data
  /// Method: GET | Path: /v1/quality-assurance-compliance | Status: mocked
  Future<ApiResponse> loadApiV1QualityAssuranceComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/quality-assurance-compliance');
  }

  /// Load Quality Assurance Workflow List Data
  /// Method: GET | Path: /v1/quality-assurance-workflow | Status: mocked
  Future<ApiResponse> loadApiV1QualityAssuranceWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/quality-assurance-workflow');
  }

  /// Load Receptionist Analytics List Data
  /// Method: GET | Path: /v1/receptionist-analytics | Status: mocked
  Future<ApiResponse> loadApiV1ReceptionistAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/receptionist-analytics');
  }

  /// Load Receptionist Compliance List Data
  /// Method: GET | Path: /v1/receptionist-compliance | Status: mocked
  Future<ApiResponse> loadApiV1ReceptionistComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/receptionist-compliance');
  }

  /// Load Receptionist Workflow List Data
  /// Method: GET | Path: /v1/receptionist-workflow | Status: mocked
  Future<ApiResponse> loadApiV1ReceptionistWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/receptionist-workflow');
  }

  /// Load Scheduler Analytics List Data
  /// Method: GET | Path: /v1/scheduler-analytics | Status: mocked
  Future<ApiResponse> loadApiV1SchedulerAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/scheduler-analytics');
  }

  /// Load Scheduler Compliance List Data
  /// Method: GET | Path: /v1/scheduler-compliance | Status: mocked
  Future<ApiResponse> loadApiV1SchedulerComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/scheduler-compliance');
  }

  /// Load Scheduler Workflow List Data
  /// Method: GET | Path: /v1/scheduler-workflow | Status: mocked
  Future<ApiResponse> loadApiV1SchedulerWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/scheduler-workflow');
  }

  /// Load Training Coordinator Analytics List Data
  /// Method: GET | Path: /v1/training-coordinator-analytics | Status: mocked
  Future<ApiResponse> loadApiV1TrainingCoordinatorAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/training-coordinator-analytics');
  }

  /// Load Training Coordinator Compliance List Data
  /// Method: GET | Path: /v1/training-coordinator-compliance | Status: mocked
  Future<ApiResponse> loadApiV1TrainingCoordinatorComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/training-coordinator-compliance');
  }

  /// Load Training Coordinator Workflow List Data
  /// Method: GET | Path: /v1/training-coordinator-workflow | Status: mocked
  Future<ApiResponse> loadApiV1TrainingCoordinatorWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/training-coordinator-workflow');
  }

  /// Load Volunteer Coordinator Analytics List Data
  /// Method: GET | Path: /v1/volunteer-coordinator-analytics | Status: mocked
  Future<ApiResponse> loadApiV1VolunteerCoordinatorAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/volunteer-coordinator-analytics');
  }

  /// Load Volunteer Coordinator Compliance List Data
  /// Method: GET | Path: /v1/volunteer-coordinator-compliance | Status: mocked
  Future<ApiResponse> loadApiV1VolunteerCoordinatorComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/volunteer-coordinator-compliance');
  }

  /// Load Volunteer Coordinator Workflow List Data
  /// Method: GET | Path: /v1/volunteer-coordinator-workflow | Status: mocked
  Future<ApiResponse> loadApiV1VolunteerCoordinatorWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/volunteer-coordinator-workflow');
  }

  /// Load Caregiver Tasks List Data
  /// Method: GET | Path: /v1/caregiver-tasks | Status: mocked
  Future<ApiResponse> loadApiV1CaregiverTasksList() async {
    return ref.read(apiClientProvider).get('/v1/caregiver-tasks');
  }

  /// Load Caregiver Client Profile List Data
  /// Method: GET | Path: /v1/caregiver-client-profile | Status: mocked
  Future<ApiResponse> loadApiV1CaregiverClientProfileList() async {
    return ref.read(apiClientProvider).get('/v1/caregiver-client-profile');
  }

  /// Load Caregiver Visit Notes List Data
  /// Method: GET | Path: /v1/caregiver-visit-notes | Status: mocked
  Future<ApiResponse> loadApiV1CaregiverVisitNotesList() async {
    return ref.read(apiClientProvider).get('/v1/caregiver-visit-notes');
  }

  /// Create New Caregiver Visit Notes Record
  /// Method: POST | Path: /v1/caregiver-visit-notes | Status: mocked
  Future<ApiResponse> createApiV1CaregiverVisitNotesCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/caregiver-visit-notes', body: data);
  }

  /// Update Existing Caregiver Visit Notes Record
  /// Method: PATCH | Path: /v1/caregiver-visit-notes/:id | Status: mocked
  Future<ApiResponse> updateApiV1CaregiverVisitNotesUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/caregiver-visit-notes/$id', body: data);
  }

  /// Load Caregiver Schedule List Data
  /// Method: GET | Path: /v1/caregiver-schedule | Status: mocked
  Future<ApiResponse> loadApiV1CaregiverScheduleList() async {
    return ref.read(apiClientProvider).get('/v1/caregiver-schedule');
  }

  /// Load Caregiver Incident Report List Data
  /// Method: GET | Path: /v1/caregiver-incident-report | Status: mocked
  Future<ApiResponse> loadApiV1CaregiverIncidentReportList() async {
    return ref.read(apiClientProvider).get('/v1/caregiver-incident-report');
  }

  /// Load Cfo Revenue List Data
  /// Method: GET | Path: /v1/cfo-revenue | Status: mocked
  Future<ApiResponse> loadApiV1CfoRevenueList() async {
    return ref.read(apiClientProvider).get('/v1/cfo-revenue');
  }

  /// Load Cfo Expenses List Data
  /// Method: GET | Path: /v1/cfo-expenses | Status: mocked
  Future<ApiResponse> loadApiV1CfoExpensesList() async {
    return ref.read(apiClientProvider).get('/v1/cfo-expenses');
  }

  /// Load Cfo Payroll List Data
  /// Method: GET | Path: /v1/cfo-payroll | Status: mocked
  Future<ApiResponse> loadApiV1CfoPayrollList() async {
    return ref.read(apiClientProvider).get('/v1/cfo-payroll');
  }

  /// Load Cfo Invoices List Data
  /// Method: GET | Path: /v1/cfo-invoices | Status: mocked
  Future<ApiResponse> loadApiV1CfoInvoicesList() async {
    return ref.read(apiClientProvider).get('/v1/cfo-invoices');
  }

  /// Load Cfo Tax List Data
  /// Method: GET | Path: /v1/cfo-tax | Status: mocked
  Future<ApiResponse> loadApiV1CfoTaxList() async {
    return ref.read(apiClientProvider).get('/v1/cfo-tax');
  }

  /// Load Cfo Profitability List Data
  /// Method: GET | Path: /v1/cfo-profitability | Status: mocked
  Future<ApiResponse> loadApiV1CfoProfitabilityList() async {
    return ref.read(apiClientProvider).get('/v1/cfo-profitability');
  }

  /// Load Cfo Cashflow List Data
  /// Method: GET | Path: /v1/cfo-cashflow | Status: mocked
  Future<ApiResponse> loadApiV1CfoCashflowList() async {
    return ref.read(apiClientProvider).get('/v1/cfo-cashflow');
  }

  /// Load Chiropractor Command Center List Data
  /// Method: GET | Path: /v1/chiropractor-command-center | Status: mocked
  Future<ApiResponse> loadApiV1ChiropractorCommandCenterList() async {
    return ref.read(apiClientProvider).get('/v1/chiropractor-command-center');
  }

  /// Load Chiropractor Appointments List Data
  /// Method: GET | Path: /v1/chiropractor-appointments | Status: mocked
  Future<ApiResponse> loadApiV1ChiropractorAppointmentsList() async {
    return ref.read(apiClientProvider).get('/v1/chiropractor-appointments');
  }

  /// Load Chiropractor Client Intake List Data
  /// Method: GET | Path: /v1/chiropractor-client-intake | Status: mocked
  Future<ApiResponse> loadApiV1ChiropractorClientIntakeList() async {
    return ref.read(apiClientProvider).get('/v1/chiropractor-client-intake');
  }

  /// Create New Chiropractor Client Intake Record
  /// Method: POST | Path: /v1/chiropractor-client-intake | Status: mocked
  Future<ApiResponse> createApiV1ChiropractorClientIntakeCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/chiropractor-client-intake', body: data);
  }

  /// Update Existing Chiropractor Client Intake Record
  /// Method: PATCH | Path: /v1/chiropractor-client-intake/:id | Status: mocked
  Future<ApiResponse> updateApiV1ChiropractorClientIntakeUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/chiropractor-client-intake/$id', body: data);
  }

  /// Load Chiropractor Assessment List Data
  /// Method: GET | Path: /v1/chiropractor-assessment | Status: mocked
  Future<ApiResponse> loadApiV1ChiropractorAssessmentList() async {
    return ref.read(apiClientProvider).get('/v1/chiropractor-assessment');
  }

  /// Load Chiropractor Treatment Notes List Data
  /// Method: GET | Path: /v1/chiropractor-treatment-notes | Status: mocked
  Future<ApiResponse> loadApiV1ChiropractorTreatmentNotesList() async {
    return ref.read(apiClientProvider).get('/v1/chiropractor-treatment-notes');
  }

  /// Create New Chiropractor Treatment Notes Record
  /// Method: POST | Path: /v1/chiropractor-treatment-notes | Status: mocked
  Future<ApiResponse> createApiV1ChiropractorTreatmentNotesCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/chiropractor-treatment-notes', body: data);
  }

  /// Update Existing Chiropractor Treatment Notes Record
  /// Method: PATCH | Path: /v1/chiropractor-treatment-notes/:id | Status: mocked
  Future<ApiResponse> updateApiV1ChiropractorTreatmentNotesUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/chiropractor-treatment-notes/$id', body: data);
  }

  /// Load Chiropractor Exercise Plan List Data
  /// Method: GET | Path: /v1/chiropractor-exercise-plan | Status: mocked
  Future<ApiResponse> loadApiV1ChiropractorExercisePlanList() async {
    return ref.read(apiClientProvider).get('/v1/chiropractor-exercise-plan');
  }

  /// Load Chiropractor Billing Link List Data
  /// Method: GET | Path: /v1/chiropractor-billing-link | Status: mocked
  Future<ApiResponse> loadApiV1ChiropractorBillingLinkList() async {
    return ref.read(apiClientProvider).get('/v1/chiropractor-billing-link');
  }

  /// Load Chiropractor Reports List Data
  /// Method: GET | Path: /v1/chiropractor-reports | Status: mocked
  Future<ApiResponse> loadApiV1ChiropractorReportsList() async {
    return ref.read(apiClientProvider).get('/v1/chiropractor-reports');
  }

  /// Load Clinical Director Staff Quality List Data
  /// Method: GET | Path: /v1/clinical-director-staff-quality | Status: mocked
  Future<ApiResponse> loadApiV1ClinicalDirectorStaffQualityList() async {
    return ref.read(apiClientProvider).get('/v1/clinical-director-staff-quality');
  }

  /// Load Clinical Director Incident Review List Data
  /// Method: GET | Path: /v1/clinical-director-incident-review | Status: mocked
  Future<ApiResponse> loadApiV1ClinicalDirectorIncidentReviewList() async {
    return ref.read(apiClientProvider).get('/v1/clinical-director-incident-review');
  }

  /// Load Clinical Director Compliance List Data
  /// Method: GET | Path: /v1/clinical-director-compliance | Status: mocked
  Future<ApiResponse> loadApiV1ClinicalDirectorComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/clinical-director-compliance');
  }

  /// Load Clinical Director Reports List Data
  /// Method: GET | Path: /v1/clinical-director-reports | Status: mocked
  Future<ApiResponse> loadApiV1ClinicalDirectorReportsList() async {
    return ref.read(apiClientProvider).get('/v1/clinical-director-reports');
  }

  /// Load Clinical Director Approvals List Data
  /// Method: GET | Path: /v1/clinical-director-approvals | Status: mocked
  Future<ApiResponse> loadApiV1ClinicalDirectorApprovalsList() async {
    return ref.read(apiClientProvider).get('/v1/clinical-director-approvals');
  }

  /// Load Clinical Director Performance List Data
  /// Method: GET | Path: /v1/clinical-director-performance | Status: mocked
  Future<ApiResponse> loadApiV1ClinicalDirectorPerformanceList() async {
    return ref.read(apiClientProvider).get('/v1/clinical-director-performance');
  }

  /// Create New Clinical Director Performance Record
  /// Method: POST | Path: /v1/clinical-director-performance | Status: mocked
  Future<ApiResponse> createApiV1ClinicalDirectorPerformanceCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/clinical-director-performance', body: data);
  }

  /// Update Existing Clinical Director Performance Record
  /// Method: PATCH | Path: /v1/clinical-director-performance/:id | Status: mocked
  Future<ApiResponse> updateApiV1ClinicalDirectorPerformanceUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/clinical-director-performance/$id', body: data);
  }

  /// Load Coo Command Center List Data
  /// Method: GET | Path: /v1/coo-command-center | Status: mocked
  Future<ApiResponse> loadApiV1CooCommandCenterList() async {
    return ref.read(apiClientProvider).get('/v1/coo-command-center');
  }

  /// Load Coo Operations List Data
  /// Method: GET | Path: /v1/coo-operations | Status: mocked
  Future<ApiResponse> loadApiV1CooOperationsList() async {
    return ref.read(apiClientProvider).get('/v1/coo-operations');
  }

  /// Load Coo Staffing List Data
  /// Method: GET | Path: /v1/coo-staffing | Status: mocked
  Future<ApiResponse> loadApiV1CooStaffingList() async {
    return ref.read(apiClientProvider).get('/v1/coo-staffing');
  }

  /// Load Coo Scheduling Health List Data
  /// Method: GET | Path: /v1/coo-scheduling-health | Status: mocked
  Future<ApiResponse> loadApiV1CooSchedulingHealthList() async {
    return ref.read(apiClientProvider).get('/v1/coo-scheduling-health');
  }

  /// Load Coo Workflow Issues List Data
  /// Method: GET | Path: /v1/coo-workflow-issues | Status: mocked
  Future<ApiResponse> loadApiV1CooWorkflowIssuesList() async {
    return ref.read(apiClientProvider).get('/v1/coo-workflow-issues');
  }

  /// Load Coo Branch Comparison List Data
  /// Method: GET | Path: /v1/coo-branch-comparison | Status: mocked
  Future<ApiResponse> loadApiV1CooBranchComparisonList() async {
    return ref.read(apiClientProvider).get('/v1/coo-branch-comparison');
  }

  /// Load Hr Director Hiring Pipeline List Data
  /// Method: GET | Path: /v1/hr-director-hiring-pipeline | Status: mocked
  Future<ApiResponse> loadApiV1HrDirectorHiringPipelineList() async {
    return ref.read(apiClientProvider).get('/v1/hr-director-hiring-pipeline');
  }

  /// Load Hr Director Staff Files List Data
  /// Method: GET | Path: /v1/hr-director-staff-files | Status: mocked
  Future<ApiResponse> loadApiV1HrDirectorStaffFilesList() async {
    return ref.read(apiClientProvider).get('/v1/hr-director-staff-files');
  }

  /// Load Hr Director Training List Data
  /// Method: GET | Path: /v1/hr-director-training | Status: mocked
  Future<ApiResponse> loadApiV1HrDirectorTrainingList() async {
    return ref.read(apiClientProvider).get('/v1/hr-director-training');
  }

  /// Load Hr Director Credential Expiry List Data
  /// Method: GET | Path: /v1/hr-director-credential-expiry | Status: mocked
  Future<ApiResponse> loadApiV1HrDirectorCredentialExpiryList() async {
    return ref.read(apiClientProvider).get('/v1/hr-director-credential-expiry');
  }

  /// Load Hr Director Onboarding List Data
  /// Method: GET | Path: /v1/hr-director-onboarding | Status: mocked
  Future<ApiResponse> loadApiV1HrDirectorOnboardingList() async {
    return ref.read(apiClientProvider).get('/v1/hr-director-onboarding');
  }

  /// Load Hr Hiring Applicants List Data
  /// Method: GET | Path: /v1/hr-hiring-applicants | Status: mocked
  Future<ApiResponse> loadApiV1HrHiringApplicantsList() async {
    return ref.read(apiClientProvider).get('/v1/hr-hiring-applicants');
  }

  /// Load Hr Hiring Interviews List Data
  /// Method: GET | Path: /v1/hr-hiring-interviews | Status: mocked
  Future<ApiResponse> loadApiV1HrHiringInterviewsList() async {
    return ref.read(apiClientProvider).get('/v1/hr-hiring-interviews');
  }

  /// Load Hr Hiring Offers List Data
  /// Method: GET | Path: /v1/hr-hiring-offers | Status: mocked
  Future<ApiResponse> loadApiV1HrHiringOffersList() async {
    return ref.read(apiClientProvider).get('/v1/hr-hiring-offers');
  }

  /// Load Hr Hiring Onboarding List Data
  /// Method: GET | Path: /v1/hr-hiring-onboarding | Status: mocked
  Future<ApiResponse> loadApiV1HrHiringOnboardingList() async {
    return ref.read(apiClientProvider).get('/v1/hr-hiring-onboarding');
  }

  /// Load Hr Hiring Credentials List Data
  /// Method: GET | Path: /v1/hr-hiring-credentials | Status: mocked
  Future<ApiResponse> loadApiV1HrHiringCredentialsList() async {
    return ref.read(apiClientProvider).get('/v1/hr-hiring-credentials');
  }

  /// Load Franchise Owner Command Center List Data
  /// Method: GET | Path: /v1/franchise-owner-command-center | Status: mocked
  Future<ApiResponse> loadApiV1FranchiseOwnerCommandCenterList() async {
    return ref.read(apiClientProvider).get('/v1/franchise-owner-command-center');
  }

  /// Load Franchise Owner Branch List Data
  /// Method: GET | Path: /v1/franchise-owner-branch | Status: mocked
  Future<ApiResponse> loadApiV1FranchiseOwnerBranchList() async {
    return ref.read(apiClientProvider).get('/v1/franchise-owner-branch');
  }

  /// Load Franchise Owner Staff List Data
  /// Method: GET | Path: /v1/franchise-owner-staff | Status: mocked
  Future<ApiResponse> loadApiV1FranchiseOwnerStaffList() async {
    return ref.read(apiClientProvider).get('/v1/franchise-owner-staff');
  }

  /// Load Franchise Owner Clients List Data
  /// Method: GET | Path: /v1/franchise-owner-clients | Status: mocked
  Future<ApiResponse> loadApiV1FranchiseOwnerClientsList() async {
    return ref.read(apiClientProvider).get('/v1/franchise-owner-clients');
  }

  /// Load Franchise Owner Appointments List Data
  /// Method: GET | Path: /v1/franchise-owner-appointments | Status: mocked
  Future<ApiResponse> loadApiV1FranchiseOwnerAppointmentsList() async {
    return ref.read(apiClientProvider).get('/v1/franchise-owner-appointments');
  }

  /// Load Franchise Owner Finance Snapshot List Data
  /// Method: GET | Path: /v1/franchise-owner-finance-snapshot | Status: mocked
  Future<ApiResponse> loadApiV1FranchiseOwnerFinanceSnapshotList() async {
    return ref.read(apiClientProvider).get('/v1/franchise-owner-finance-snapshot');
  }

  /// Load Franchise Owner Compliance List Data
  /// Method: GET | Path: /v1/franchise-owner-compliance | Status: mocked
  Future<ApiResponse> loadApiV1FranchiseOwnerComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/franchise-owner-compliance');
  }

  /// Load Franchise Owner Reports List Data
  /// Method: GET | Path: /v1/franchise-owner-reports | Status: mocked
  Future<ApiResponse> loadApiV1FranchiseOwnerReportsList() async {
    return ref.read(apiClientProvider).get('/v1/franchise-owner-reports');
  }

  /// Load Patient Command Center List Data
  /// Method: GET | Path: /v1/patient-command-center | Status: mocked
  Future<ApiResponse> loadApiV1PatientCommandCenterList() async {
    return ref.read(apiClientProvider).get('/v1/patient-command-center');
  }

  /// Load Patient Appointments List Data
  /// Method: GET | Path: /v1/patient-appointments | Status: mocked
  Future<ApiResponse> loadApiV1PatientAppointmentsList() async {
    return ref.read(apiClientProvider).get('/v1/patient-appointments');
  }

  /// Load Patient Care Plan List Data
  /// Method: GET | Path: /v1/patient-care-plan | Status: mocked
  Future<ApiResponse> loadApiV1PatientCarePlanList() async {
    return ref.read(apiClientProvider).get('/v1/patient-care-plan');
  }

  /// Load Patient Messages List Data
  /// Method: GET | Path: /v1/patient-messages | Status: mocked
  Future<ApiResponse> loadApiV1PatientMessagesList() async {
    return ref.read(apiClientProvider).get('/v1/patient-messages');
  }

  /// Load Patient Documents List Data
  /// Method: GET | Path: /v1/patient-documents | Status: mocked
  Future<ApiResponse> loadApiV1PatientDocumentsList() async {
    return ref.read(apiClientProvider).get('/v1/patient-documents');
  }

  /// Load Patient Billing List Data
  /// Method: GET | Path: /v1/patient-billing | Status: mocked
  Future<ApiResponse> loadApiV1PatientBillingList() async {
    return ref.read(apiClientProvider).get('/v1/patient-billing');
  }

  /// Load Patient Profile List Data
  /// Method: GET | Path: /v1/patient-profile | Status: mocked
  Future<ApiResponse> loadApiV1PatientProfileList() async {
    return ref.read(apiClientProvider).get('/v1/patient-profile');
  }

  /// Load Physiotherapist Command Center List Data
  /// Method: GET | Path: /v1/physiotherapist-command-center | Status: mocked
  Future<ApiResponse> loadApiV1PhysiotherapistCommandCenterList() async {
    return ref.read(apiClientProvider).get('/v1/physiotherapist-command-center');
  }

  /// Load Physiotherapist Appointments List Data
  /// Method: GET | Path: /v1/physiotherapist-appointments | Status: mocked
  Future<ApiResponse> loadApiV1PhysiotherapistAppointmentsList() async {
    return ref.read(apiClientProvider).get('/v1/physiotherapist-appointments');
  }

  /// Load Physiotherapist Client Intake List Data
  /// Method: GET | Path: /v1/physiotherapist-client-intake | Status: mocked
  Future<ApiResponse> loadApiV1PhysiotherapistClientIntakeList() async {
    return ref.read(apiClientProvider).get('/v1/physiotherapist-client-intake');
  }

  /// Create New Physiotherapist Client Intake Record
  /// Method: POST | Path: /v1/physiotherapist-client-intake | Status: mocked
  Future<ApiResponse> createApiV1PhysiotherapistClientIntakeCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/physiotherapist-client-intake', body: data);
  }

  /// Update Existing Physiotherapist Client Intake Record
  /// Method: PATCH | Path: /v1/physiotherapist-client-intake/:id | Status: mocked
  Future<ApiResponse> updateApiV1PhysiotherapistClientIntakeUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/physiotherapist-client-intake/$id', body: data);
  }

  /// Load Physiotherapist Assessment List Data
  /// Method: GET | Path: /v1/physiotherapist-assessment | Status: mocked
  Future<ApiResponse> loadApiV1PhysiotherapistAssessmentList() async {
    return ref.read(apiClientProvider).get('/v1/physiotherapist-assessment');
  }

  /// Load Physiotherapist Treatment Notes List Data
  /// Method: GET | Path: /v1/physiotherapist-treatment-notes | Status: mocked
  Future<ApiResponse> loadApiV1PhysiotherapistTreatmentNotesList() async {
    return ref.read(apiClientProvider).get('/v1/physiotherapist-treatment-notes');
  }

  /// Create New Physiotherapist Treatment Notes Record
  /// Method: POST | Path: /v1/physiotherapist-treatment-notes | Status: mocked
  Future<ApiResponse> createApiV1PhysiotherapistTreatmentNotesCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/physiotherapist-treatment-notes', body: data);
  }

  /// Update Existing Physiotherapist Treatment Notes Record
  /// Method: PATCH | Path: /v1/physiotherapist-treatment-notes/:id | Status: mocked
  Future<ApiResponse> updateApiV1PhysiotherapistTreatmentNotesUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/physiotherapist-treatment-notes/$id', body: data);
  }

  /// Load Physiotherapist Exercise Plan List Data
  /// Method: GET | Path: /v1/physiotherapist-exercise-plan | Status: mocked
  Future<ApiResponse> loadApiV1PhysiotherapistExercisePlanList() async {
    return ref.read(apiClientProvider).get('/v1/physiotherapist-exercise-plan');
  }

  /// Load Physiotherapist Billing Link List Data
  /// Method: GET | Path: /v1/physiotherapist-billing-link | Status: mocked
  Future<ApiResponse> loadApiV1PhysiotherapistBillingLinkList() async {
    return ref.read(apiClientProvider).get('/v1/physiotherapist-billing-link');
  }

  /// Load Physiotherapist Reports List Data
  /// Method: GET | Path: /v1/physiotherapist-reports | Status: mocked
  Future<ApiResponse> loadApiV1PhysiotherapistReportsList() async {
    return ref.read(apiClientProvider).get('/v1/physiotherapist-reports');
  }

  /// Load Psw Command Center List Data
  /// Method: GET | Path: /v1/psw-command-center | Status: mocked
  Future<ApiResponse> loadApiV1PswCommandCenterList() async {
    return ref.read(apiClientProvider).get('/v1/psw-command-center');
  }

  /// Load Psw My Shifts List Data
  /// Method: GET | Path: /v1/psw-my-shifts | Status: mocked
  Future<ApiResponse> loadApiV1PswMyShiftsList() async {
    return ref.read(apiClientProvider).get('/v1/psw-my-shifts');
  }

  /// Load Psw Client Profile List Data
  /// Method: GET | Path: /v1/psw-client-profile | Status: mocked
  Future<ApiResponse> loadApiV1PswClientProfileList() async {
    return ref.read(apiClientProvider).get('/v1/psw-client-profile');
  }

  /// Load Psw Vitals Log List Data
  /// Method: GET | Path: /v1/psw-vitals-log | Status: mocked
  Future<ApiResponse> loadApiV1PswVitalsLogList() async {
    return ref.read(apiClientProvider).get('/v1/psw-vitals-log');
  }

  /// Load Psw Incident Report List Data
  /// Method: GET | Path: /v1/psw-incident-report | Status: mocked
  Future<ApiResponse> loadApiV1PswIncidentReportList() async {
    return ref.read(apiClientProvider).get('/v1/psw-incident-report');
  }

  /// Load Psw Care Plan List Data
  /// Method: GET | Path: /v1/psw-care-plan | Status: mocked
  Future<ApiResponse> loadApiV1PswCarePlanList() async {
    return ref.read(apiClientProvider).get('/v1/psw-care-plan');
  }

  /// Load Psw Documents List Data
  /// Method: GET | Path: /v1/psw-documents | Status: mocked
  Future<ApiResponse> loadApiV1PswDocumentsList() async {
    return ref.read(apiClientProvider).get('/v1/psw-documents');
  }

  /// Load Rmt Command Center List Data
  /// Method: GET | Path: /v1/rmt-command-center | Status: mocked
  Future<ApiResponse> loadApiV1RmtCommandCenterList() async {
    return ref.read(apiClientProvider).get('/v1/rmt-command-center');
  }

  /// Create New Rmt Command Center Record
  /// Method: POST | Path: /v1/rmt-command-center | Status: mocked
  Future<ApiResponse> createApiV1RmtCommandCenterCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rmt-command-center', body: data);
  }

  /// Update Existing Rmt Command Center Record
  /// Method: PATCH | Path: /v1/rmt-command-center/:id | Status: mocked
  Future<ApiResponse> updateApiV1RmtCommandCenterUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rmt-command-center/$id', body: data);
  }

  /// Load Rmt Appointments List Data
  /// Method: GET | Path: /v1/rmt-appointments | Status: mocked
  Future<ApiResponse> loadApiV1RmtAppointmentsList() async {
    return ref.read(apiClientProvider).get('/v1/rmt-appointments');
  }

  /// Create New Rmt Appointments Record
  /// Method: POST | Path: /v1/rmt-appointments | Status: mocked
  Future<ApiResponse> createApiV1RmtAppointmentsCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rmt-appointments', body: data);
  }

  /// Update Existing Rmt Appointments Record
  /// Method: PATCH | Path: /v1/rmt-appointments/:id | Status: mocked
  Future<ApiResponse> updateApiV1RmtAppointmentsUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rmt-appointments/$id', body: data);
  }

  /// Load Rmt Client Intake List Data
  /// Method: GET | Path: /v1/rmt-client-intake | Status: mocked
  Future<ApiResponse> loadApiV1RmtClientIntakeList() async {
    return ref.read(apiClientProvider).get('/v1/rmt-client-intake');
  }

  /// Create New Rmt Client Intake Record
  /// Method: POST | Path: /v1/rmt-client-intake | Status: mocked
  Future<ApiResponse> createApiV1RmtClientIntakeCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rmt-client-intake', body: data);
  }

  /// Update Existing Rmt Client Intake Record
  /// Method: PATCH | Path: /v1/rmt-client-intake/:id | Status: mocked
  Future<ApiResponse> updateApiV1RmtClientIntakeUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rmt-client-intake/$id', body: data);
  }

  /// Load Rmt Assessment List Data
  /// Method: GET | Path: /v1/rmt-assessment | Status: mocked
  Future<ApiResponse> loadApiV1RmtAssessmentList() async {
    return ref.read(apiClientProvider).get('/v1/rmt-assessment');
  }

  /// Create New Rmt Assessment Record
  /// Method: POST | Path: /v1/rmt-assessment | Status: mocked
  Future<ApiResponse> createApiV1RmtAssessmentCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rmt-assessment', body: data);
  }

  /// Update Existing Rmt Assessment Record
  /// Method: PATCH | Path: /v1/rmt-assessment/:id | Status: mocked
  Future<ApiResponse> updateApiV1RmtAssessmentUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rmt-assessment/$id', body: data);
  }

  /// Load Rmt Treatment Notes List Data
  /// Method: GET | Path: /v1/rmt-treatment-notes | Status: mocked
  Future<ApiResponse> loadApiV1RmtTreatmentNotesList() async {
    return ref.read(apiClientProvider).get('/v1/rmt-treatment-notes');
  }

  /// Create New Rmt Treatment Notes Record
  /// Method: POST | Path: /v1/rmt-treatment-notes | Status: mocked
  Future<ApiResponse> createApiV1RmtTreatmentNotesCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rmt-treatment-notes', body: data);
  }

  /// Update Existing Rmt Treatment Notes Record
  /// Method: PATCH | Path: /v1/rmt-treatment-notes/:id | Status: mocked
  Future<ApiResponse> updateApiV1RmtTreatmentNotesUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rmt-treatment-notes/$id', body: data);
  }

  /// Load Rmt Exercise Plan List Data
  /// Method: GET | Path: /v1/rmt-exercise-plan | Status: mocked
  Future<ApiResponse> loadApiV1RmtExercisePlanList() async {
    return ref.read(apiClientProvider).get('/v1/rmt-exercise-plan');
  }

  /// Create New Rmt Exercise Plan Record
  /// Method: POST | Path: /v1/rmt-exercise-plan | Status: mocked
  Future<ApiResponse> createApiV1RmtExercisePlanCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rmt-exercise-plan', body: data);
  }

  /// Update Existing Rmt Exercise Plan Record
  /// Method: PATCH | Path: /v1/rmt-exercise-plan/:id | Status: mocked
  Future<ApiResponse> updateApiV1RmtExercisePlanUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rmt-exercise-plan/$id', body: data);
  }

  /// Load Rmt Billing Link List Data
  /// Method: GET | Path: /v1/rmt-billing-link | Status: mocked
  Future<ApiResponse> loadApiV1RmtBillingLinkList() async {
    return ref.read(apiClientProvider).get('/v1/rmt-billing-link');
  }

  /// Create New Rmt Billing Link Record
  /// Method: POST | Path: /v1/rmt-billing-link | Status: mocked
  Future<ApiResponse> createApiV1RmtBillingLinkCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rmt-billing-link', body: data);
  }

  /// Update Existing Rmt Billing Link Record
  /// Method: PATCH | Path: /v1/rmt-billing-link/:id | Status: mocked
  Future<ApiResponse> updateApiV1RmtBillingLinkUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rmt-billing-link/$id', body: data);
  }

  /// Load Rmt Reports List Data
  /// Method: GET | Path: /v1/rmt-reports | Status: mocked
  Future<ApiResponse> loadApiV1RmtReportsList() async {
    return ref.read(apiClientProvider).get('/v1/rmt-reports');
  }

  /// Create New Rmt Reports Record
  /// Method: POST | Path: /v1/rmt-reports | Status: mocked
  Future<ApiResponse> createApiV1RmtReportsCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rmt-reports', body: data);
  }

  /// Update Existing Rmt Reports Record
  /// Method: PATCH | Path: /v1/rmt-reports/:id | Status: mocked
  Future<ApiResponse> updateApiV1RmtReportsUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rmt-reports/$id', body: data);
  }

  /// Load Rn Command Center List Data
  /// Method: GET | Path: /v1/rn-command-center | Status: mocked
  Future<ApiResponse> loadApiV1RnCommandCenterList() async {
    return ref.read(apiClientProvider).get('/v1/rn-command-center');
  }

  /// Create New Rn Command Center Record
  /// Method: POST | Path: /v1/rn-command-center | Status: mocked
  Future<ApiResponse> createApiV1RnCommandCenterCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rn-command-center', body: data);
  }

  /// Update Existing Rn Command Center Record
  /// Method: PATCH | Path: /v1/rn-command-center/:id | Status: mocked
  Future<ApiResponse> updateApiV1RnCommandCenterUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rn-command-center/$id', body: data);
  }

  /// Load Rn Patient Charting List Data
  /// Method: GET | Path: /v1/rn-patient-charting | Status: mocked
  Future<ApiResponse> loadApiV1RnPatientChartingList() async {
    return ref.read(apiClientProvider).get('/v1/rn-patient-charting');
  }

  /// Create New Rn Patient Charting Record
  /// Method: POST | Path: /v1/rn-patient-charting | Status: mocked
  Future<ApiResponse> createApiV1RnPatientChartingCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rn-patient-charting', body: data);
  }

  /// Update Existing Rn Patient Charting Record
  /// Method: PATCH | Path: /v1/rn-patient-charting/:id | Status: mocked
  Future<ApiResponse> updateApiV1RnPatientChartingUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rn-patient-charting/$id', body: data);
  }

  /// Load Rn Medications List Data
  /// Method: GET | Path: /v1/rn-medications | Status: mocked
  Future<ApiResponse> loadApiV1RnMedicationsList() async {
    return ref.read(apiClientProvider).get('/v1/rn-medications');
  }

  /// Create New Rn Medications Record
  /// Method: POST | Path: /v1/rn-medications | Status: mocked
  Future<ApiResponse> createApiV1RnMedicationsCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rn-medications', body: data);
  }

  /// Update Existing Rn Medications Record
  /// Method: PATCH | Path: /v1/rn-medications/:id | Status: mocked
  Future<ApiResponse> updateApiV1RnMedicationsUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rn-medications/$id', body: data);
  }

  /// Load Rn Vitals List Data
  /// Method: GET | Path: /v1/rn-vitals | Status: mocked
  Future<ApiResponse> loadApiV1RnVitalsList() async {
    return ref.read(apiClientProvider).get('/v1/rn-vitals');
  }

  /// Create New Rn Vitals Record
  /// Method: POST | Path: /v1/rn-vitals | Status: mocked
  Future<ApiResponse> createApiV1RnVitalsCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rn-vitals', body: data);
  }

  /// Update Existing Rn Vitals Record
  /// Method: PATCH | Path: /v1/rn-vitals/:id | Status: mocked
  Future<ApiResponse> updateApiV1RnVitalsUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rn-vitals/$id', body: data);
  }

  /// Load Rn Care Plan Review List Data
  /// Method: GET | Path: /v1/rn-care-plan-review | Status: mocked
  Future<ApiResponse> loadApiV1RnCarePlanReviewList() async {
    return ref.read(apiClientProvider).get('/v1/rn-care-plan-review');
  }

  /// Create New Rn Care Plan Review Record
  /// Method: POST | Path: /v1/rn-care-plan-review | Status: mocked
  Future<ApiResponse> createApiV1RnCarePlanReviewCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rn-care-plan-review', body: data);
  }

  /// Update Existing Rn Care Plan Review Record
  /// Method: PATCH | Path: /v1/rn-care-plan-review/:id | Status: mocked
  Future<ApiResponse> updateApiV1RnCarePlanReviewUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rn-care-plan-review/$id', body: data);
  }

  /// Load Rn Incident Review List Data
  /// Method: GET | Path: /v1/rn-incident-review | Status: mocked
  Future<ApiResponse> loadApiV1RnIncidentReviewList() async {
    return ref.read(apiClientProvider).get('/v1/rn-incident-review');
  }

  /// Create New Rn Incident Review Record
  /// Method: POST | Path: /v1/rn-incident-review | Status: mocked
  Future<ApiResponse> createApiV1RnIncidentReviewCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rn-incident-review', body: data);
  }

  /// Update Existing Rn Incident Review Record
  /// Method: PATCH | Path: /v1/rn-incident-review/:id | Status: mocked
  Future<ApiResponse> updateApiV1RnIncidentReviewUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rn-incident-review/$id', body: data);
  }

  /// Load Rn Tasks List Data
  /// Method: GET | Path: /v1/rn-tasks | Status: mocked
  Future<ApiResponse> loadApiV1RnTasksList() async {
    return ref.read(apiClientProvider).get('/v1/rn-tasks');
  }

  /// Create New Rn Tasks Record
  /// Method: POST | Path: /v1/rn-tasks | Status: mocked
  Future<ApiResponse> createApiV1RnTasksCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rn-tasks', body: data);
  }

  /// Update Existing Rn Tasks Record
  /// Method: PATCH | Path: /v1/rn-tasks/:id | Status: mocked
  Future<ApiResponse> updateApiV1RnTasksUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rn-tasks/$id', body: data);
  }

  /// Load Rn Reports List Data
  /// Method: GET | Path: /v1/rn-reports | Status: mocked
  Future<ApiResponse> loadApiV1RnReportsList() async {
    return ref.read(apiClientProvider).get('/v1/rn-reports');
  }

  /// Create New Rn Reports Record
  /// Method: POST | Path: /v1/rn-reports | Status: mocked
  Future<ApiResponse> createApiV1RnReportsCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rn-reports', body: data);
  }

  /// Update Existing Rn Reports Record
  /// Method: PATCH | Path: /v1/rn-reports/:id | Status: mocked
  Future<ApiResponse> updateApiV1RnReportsUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rn-reports/$id', body: data);
  }

  /// Load Rpn Command Center List Data
  /// Method: GET | Path: /v1/rpn-command-center | Status: mocked
  Future<ApiResponse> loadApiV1RpnCommandCenterList() async {
    return ref.read(apiClientProvider).get('/v1/rpn-command-center');
  }

  /// Create New Rpn Command Center Record
  /// Method: POST | Path: /v1/rpn-command-center | Status: mocked
  Future<ApiResponse> createApiV1RpnCommandCenterCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rpn-command-center', body: data);
  }

  /// Update Existing Rpn Command Center Record
  /// Method: PATCH | Path: /v1/rpn-command-center/:id | Status: mocked
  Future<ApiResponse> updateApiV1RpnCommandCenterUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rpn-command-center/$id', body: data);
  }

  /// Load Rpn Patient Charting List Data
  /// Method: GET | Path: /v1/rpn-patient-charting | Status: mocked
  Future<ApiResponse> loadApiV1RpnPatientChartingList() async {
    return ref.read(apiClientProvider).get('/v1/rpn-patient-charting');
  }

  /// Create New Rpn Patient Charting Record
  /// Method: POST | Path: /v1/rpn-patient-charting | Status: mocked
  Future<ApiResponse> createApiV1RpnPatientChartingCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rpn-patient-charting', body: data);
  }

  /// Update Existing Rpn Patient Charting Record
  /// Method: PATCH | Path: /v1/rpn-patient-charting/:id | Status: mocked
  Future<ApiResponse> updateApiV1RpnPatientChartingUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rpn-patient-charting/$id', body: data);
  }

  /// Load Rpn Medications List Data
  /// Method: GET | Path: /v1/rpn-medications | Status: mocked
  Future<ApiResponse> loadApiV1RpnMedicationsList() async {
    return ref.read(apiClientProvider).get('/v1/rpn-medications');
  }

  /// Create New Rpn Medications Record
  /// Method: POST | Path: /v1/rpn-medications | Status: mocked
  Future<ApiResponse> createApiV1RpnMedicationsCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rpn-medications', body: data);
  }

  /// Update Existing Rpn Medications Record
  /// Method: PATCH | Path: /v1/rpn-medications/:id | Status: mocked
  Future<ApiResponse> updateApiV1RpnMedicationsUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rpn-medications/$id', body: data);
  }

  /// Load Rpn Vitals List Data
  /// Method: GET | Path: /v1/rpn-vitals | Status: mocked
  Future<ApiResponse> loadApiV1RpnVitalsList() async {
    return ref.read(apiClientProvider).get('/v1/rpn-vitals');
  }

  /// Create New Rpn Vitals Record
  /// Method: POST | Path: /v1/rpn-vitals | Status: mocked
  Future<ApiResponse> createApiV1RpnVitalsCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rpn-vitals', body: data);
  }

  /// Update Existing Rpn Vitals Record
  /// Method: PATCH | Path: /v1/rpn-vitals/:id | Status: mocked
  Future<ApiResponse> updateApiV1RpnVitalsUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rpn-vitals/$id', body: data);
  }

  /// Load Rpn Care Plan Review List Data
  /// Method: GET | Path: /v1/rpn-care-plan-review | Status: mocked
  Future<ApiResponse> loadApiV1RpnCarePlanReviewList() async {
    return ref.read(apiClientProvider).get('/v1/rpn-care-plan-review');
  }

  /// Create New Rpn Care Plan Review Record
  /// Method: POST | Path: /v1/rpn-care-plan-review | Status: mocked
  Future<ApiResponse> createApiV1RpnCarePlanReviewCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rpn-care-plan-review', body: data);
  }

  /// Update Existing Rpn Care Plan Review Record
  /// Method: PATCH | Path: /v1/rpn-care-plan-review/:id | Status: mocked
  Future<ApiResponse> updateApiV1RpnCarePlanReviewUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rpn-care-plan-review/$id', body: data);
  }

  /// Load Rpn Incident Review List Data
  /// Method: GET | Path: /v1/rpn-incident-review | Status: mocked
  Future<ApiResponse> loadApiV1RpnIncidentReviewList() async {
    return ref.read(apiClientProvider).get('/v1/rpn-incident-review');
  }

  /// Create New Rpn Incident Review Record
  /// Method: POST | Path: /v1/rpn-incident-review | Status: mocked
  Future<ApiResponse> createApiV1RpnIncidentReviewCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rpn-incident-review', body: data);
  }

  /// Update Existing Rpn Incident Review Record
  /// Method: PATCH | Path: /v1/rpn-incident-review/:id | Status: mocked
  Future<ApiResponse> updateApiV1RpnIncidentReviewUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rpn-incident-review/$id', body: data);
  }

  /// Load Rpn Tasks List Data
  /// Method: GET | Path: /v1/rpn-tasks | Status: mocked
  Future<ApiResponse> loadApiV1RpnTasksList() async {
    return ref.read(apiClientProvider).get('/v1/rpn-tasks');
  }

  /// Create New Rpn Tasks Record
  /// Method: POST | Path: /v1/rpn-tasks | Status: mocked
  Future<ApiResponse> createApiV1RpnTasksCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rpn-tasks', body: data);
  }

  /// Update Existing Rpn Tasks Record
  /// Method: PATCH | Path: /v1/rpn-tasks/:id | Status: mocked
  Future<ApiResponse> updateApiV1RpnTasksUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rpn-tasks/$id', body: data);
  }

  /// Load Rpn Reports List Data
  /// Method: GET | Path: /v1/rpn-reports | Status: mocked
  Future<ApiResponse> loadApiV1RpnReportsList() async {
    return ref.read(apiClientProvider).get('/v1/rpn-reports');
  }

  /// Create New Rpn Reports Record
  /// Method: POST | Path: /v1/rpn-reports | Status: mocked
  Future<ApiResponse> createApiV1RpnReportsCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rpn-reports', body: data);
  }

  /// Update Existing Rpn Reports Record
  /// Method: PATCH | Path: /v1/rpn-reports/:id | Status: mocked
  Future<ApiResponse> updateApiV1RpnReportsUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rpn-reports/$id', body: data);
  }

  /// Load Scheduler Command Center List Data
  /// Method: GET | Path: /v1/scheduler-command-center | Status: mocked
  Future<ApiResponse> loadApiV1SchedulerCommandCenterList() async {
    return ref.read(apiClientProvider).get('/v1/scheduler-command-center');
  }

  /// Load Scheduler Calendar List Data
  /// Method: GET | Path: /v1/scheduler-calendar | Status: mocked
  Future<ApiResponse> loadApiV1SchedulerCalendarList() async {
    return ref.read(apiClientProvider).get('/v1/scheduler-calendar');
  }

  /// Load Scheduler Booking Requests List Data
  /// Method: GET | Path: /v1/scheduler-booking-requests | Status: mocked
  Future<ApiResponse> loadApiV1SchedulerBookingRequestsList() async {
    return ref.read(apiClientProvider).get('/v1/scheduler-booking-requests');
  }

  /// Create New Scheduler Booking Requests Record
  /// Method: POST | Path: /v1/scheduler-booking-requests | Status: mocked
  Future<ApiResponse> createApiV1SchedulerBookingRequestsCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/scheduler-booking-requests', body: data);
  }

  /// Update Existing Scheduler Booking Requests Record
  /// Method: PATCH | Path: /v1/scheduler-booking-requests/:id | Status: mocked
  Future<ApiResponse> updateApiV1SchedulerBookingRequestsUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/scheduler-booking-requests/$id', body: data);
  }

  /// Load Scheduler Conflicts List Data
  /// Method: GET | Path: /v1/scheduler-conflicts | Status: mocked
  Future<ApiResponse> loadApiV1SchedulerConflictsList() async {
    return ref.read(apiClientProvider).get('/v1/scheduler-conflicts');
  }

  /// Load Scheduler Open Shifts List Data
  /// Method: GET | Path: /v1/scheduler-open-shifts | Status: mocked
  Future<ApiResponse> loadApiV1SchedulerOpenShiftsList() async {
    return ref.read(apiClientProvider).get('/v1/scheduler-open-shifts');
  }

  /// Load Scheduler Provider Availability List Data
  /// Method: GET | Path: /v1/scheduler-provider-availability | Status: mocked
  Future<ApiResponse> loadApiV1SchedulerProviderAvailabilityList() async {
    return ref.read(apiClientProvider).get('/v1/scheduler-provider-availability');
  }

  /// Load Intake Coordinator Referrals List Data
  /// Method: GET | Path: /v1/intake-coordinator-referrals | Status: mocked
  Future<ApiResponse> loadApiV1IntakeCoordinatorReferralsList() async {
    return ref.read(apiClientProvider).get('/v1/intake-coordinator-referrals');
  }

  /// Create New Intake Coordinator Referrals Record
  /// Method: POST | Path: /v1/intake-coordinator-referrals | Status: mocked
  Future<ApiResponse> createApiV1IntakeCoordinatorReferralsCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/intake-coordinator-referrals', body: data);
  }

  /// Update Existing Intake Coordinator Referrals Record
  /// Method: PATCH | Path: /v1/intake-coordinator-referrals/:id | Status: mocked
  Future<ApiResponse> updateApiV1IntakeCoordinatorReferralsUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/intake-coordinator-referrals/$id', body: data);
  }

  /// Load Intake Coordinator Client Intake List Data
  /// Method: GET | Path: /v1/intake-coordinator-client-intake | Status: mocked
  Future<ApiResponse> loadApiV1IntakeCoordinatorClientIntakeList() async {
    return ref.read(apiClientProvider).get('/v1/intake-coordinator-client-intake');
  }

  /// Create New Intake Coordinator Client Intake Record
  /// Method: POST | Path: /v1/intake-coordinator-client-intake | Status: mocked
  Future<ApiResponse> createApiV1IntakeCoordinatorClientIntakeCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/intake-coordinator-client-intake', body: data);
  }

  /// Update Existing Intake Coordinator Client Intake Record
  /// Method: PATCH | Path: /v1/intake-coordinator-client-intake/:id | Status: mocked
  Future<ApiResponse> updateApiV1IntakeCoordinatorClientIntakeUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/intake-coordinator-client-intake/$id', body: data);
  }

  /// Load Intake Coordinator Assessment Queue List Data
  /// Method: GET | Path: /v1/intake-coordinator-assessment-queue | Status: mocked
  Future<ApiResponse> loadApiV1IntakeCoordinatorAssessmentQueueList() async {
    return ref.read(apiClientProvider).get('/v1/intake-coordinator-assessment-queue');
  }

  /// Create New Intake Coordinator Assessment Queue Record
  /// Method: POST | Path: /v1/intake-coordinator-assessment-queue | Status: mocked
  Future<ApiResponse> createApiV1IntakeCoordinatorAssessmentQueueCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/intake-coordinator-assessment-queue', body: data);
  }

  /// Update Existing Intake Coordinator Assessment Queue Record
  /// Method: PATCH | Path: /v1/intake-coordinator-assessment-queue/:id | Status: mocked
  Future<ApiResponse> updateApiV1IntakeCoordinatorAssessmentQueueUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/intake-coordinator-assessment-queue/$id', body: data);
  }

  /// Load Intake Coordinator Booking List Data
  /// Method: GET | Path: /v1/intake-coordinator-booking | Status: mocked
  Future<ApiResponse> loadApiV1IntakeCoordinatorBookingList() async {
    return ref.read(apiClientProvider).get('/v1/intake-coordinator-booking');
  }

  /// Create New Intake Coordinator Booking Record
  /// Method: POST | Path: /v1/intake-coordinator-booking | Status: mocked
  Future<ApiResponse> createApiV1IntakeCoordinatorBookingCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/intake-coordinator-booking', body: data);
  }

  /// Update Existing Intake Coordinator Booking Record
  /// Method: PATCH | Path: /v1/intake-coordinator-booking/:id | Status: mocked
  Future<ApiResponse> updateApiV1IntakeCoordinatorBookingUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/intake-coordinator-booking/$id', body: data);
  }

  /// Load Intake Coordinator Documents List Data
  /// Method: GET | Path: /v1/intake-coordinator-documents | Status: mocked
  Future<ApiResponse> loadApiV1IntakeCoordinatorDocumentsList() async {
    return ref.read(apiClientProvider).get('/v1/intake-coordinator-documents');
  }

  /// Create New Intake Coordinator Documents Record
  /// Method: POST | Path: /v1/intake-coordinator-documents | Status: mocked
  Future<ApiResponse> createApiV1IntakeCoordinatorDocumentsCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/intake-coordinator-documents', body: data);
  }

  /// Update Existing Intake Coordinator Documents Record
  /// Method: PATCH | Path: /v1/intake-coordinator-documents/:id | Status: mocked
  Future<ApiResponse> updateApiV1IntakeCoordinatorDocumentsUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/intake-coordinator-documents/$id', body: data);
  }

  /// Load Intake Coordinator Follow Up List Data
  /// Method: GET | Path: /v1/intake-coordinator-follow-up | Status: mocked
  Future<ApiResponse> loadApiV1IntakeCoordinatorFollowUpList() async {
    return ref.read(apiClientProvider).get('/v1/intake-coordinator-follow-up');
  }

  /// Create New Intake Coordinator Follow Up Record
  /// Method: POST | Path: /v1/intake-coordinator-follow-up | Status: mocked
  Future<ApiResponse> createApiV1IntakeCoordinatorFollowUpCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/intake-coordinator-follow-up', body: data);
  }

  /// Update Existing Intake Coordinator Follow Up Record
  /// Method: PATCH | Path: /v1/intake-coordinator-follow-up/:id | Status: mocked
  Future<ApiResponse> updateApiV1IntakeCoordinatorFollowUpUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/intake-coordinator-follow-up/$id', body: data);
  }

  /// Load Executive Command Center List Data
  /// Method: GET | Path: /v1/executive-command-center | Status: mocked
  Future<ApiResponse> loadApiV1ExecutiveCommandCenterList() async {
    return ref.read(apiClientProvider).get('/v1/executive-command-center');
  }

  /// Load Enterprise Health List Data
  /// Method: GET | Path: /v1/enterprise-health | Status: mocked
  Future<ApiResponse> loadApiV1EnterpriseHealthList() async {
    return ref.read(apiClientProvider).get('/v1/enterprise-health');
  }

  /// Load Revenue Analytics List Data
  /// Method: GET | Path: /v1/revenue-analytics | Status: mocked
  Future<ApiResponse> loadApiV1RevenueAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/revenue-analytics');
  }

  /// Load Risk Management List Data
  /// Method: GET | Path: /v1/risk-management | Status: mocked
  Future<ApiResponse> loadApiV1RiskManagementList() async {
    return ref.read(apiClientProvider).get('/v1/risk-management');
  }

  /// Load Operations Command Center List Data
  /// Method: GET | Path: /v1/operations-command-center | Status: mocked
  Future<ApiResponse> loadApiV1OperationsCommandCenterList() async {
    return ref.read(apiClientProvider).get('/v1/operations-command-center');
  }

  /// Load Staffing List Data
  /// Method: GET | Path: /v1/staffing | Status: mocked
  Future<ApiResponse> loadApiV1StaffingList() async {
    return ref.read(apiClientProvider).get('/v1/staffing');
  }

  /// Load Workflow Issue List Data
  /// Method: GET | Path: /v1/workflow-issue | Status: mocked
  Future<ApiResponse> loadApiV1WorkflowIssueList() async {
    return ref.read(apiClientProvider).get('/v1/workflow-issue');
  }

  /// Load Service Quality List Data
  /// Method: GET | Path: /v1/service-quality | Status: mocked
  Future<ApiResponse> loadApiV1ServiceQualityList() async {
    return ref.read(apiClientProvider).get('/v1/service-quality');
  }

  /// Load Branch Performance List Data
  /// Method: GET | Path: /v1/branch-performance | Status: mocked
  Future<ApiResponse> loadApiV1BranchPerformanceList() async {
    return ref.read(apiClientProvider).get('/v1/branch-performance');
  }

  /// Create New Branch Performance Record
  /// Method: POST | Path: /v1/branch-performance | Status: mocked
  Future<ApiResponse> createApiV1BranchPerformanceCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/branch-performance', body: data);
  }

  /// Update Existing Branch Performance Record
  /// Method: PATCH | Path: /v1/branch-performance/:id | Status: mocked
  Future<ApiResponse> updateApiV1BranchPerformanceUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/branch-performance/$id', body: data);
  }

  /// Load Financial List Data
  /// Method: GET | Path: /v1/financial | Status: mocked
  Future<ApiResponse> loadApiV1FinancialList() async {
    return ref.read(apiClientProvider).get('/v1/financial');
  }

  /// Load Revenue List Data
  /// Method: GET | Path: /v1/revenue | Status: mocked
  Future<ApiResponse> loadApiV1RevenueList() async {
    return ref.read(apiClientProvider).get('/v1/revenue');
  }

  /// Load Expense Management List Data
  /// Method: GET | Path: /v1/expense-management | Status: mocked
  Future<ApiResponse> loadApiV1ExpenseManagementList() async {
    return ref.read(apiClientProvider).get('/v1/expense-management');
  }

  /// Load Payroll List Data
  /// Method: GET | Path: /v1/payroll | Status: mocked
  Future<ApiResponse> loadApiV1PayrollList() async {
    return ref.read(apiClientProvider).get('/v1/payroll');
  }

  /// Load Tax Compliance List Data
  /// Method: GET | Path: /v1/tax-compliance | Status: mocked
  Future<ApiResponse> loadApiV1TaxComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/tax-compliance');
  }

  /// Load System Health List Data
  /// Method: GET | Path: /v1/system-health | Status: mocked
  Future<ApiResponse> loadApiV1SystemHealthList() async {
    return ref.read(apiClientProvider).get('/v1/system-health');
  }

  /// Load Api Monitoring List Data
  /// Method: GET | Path: /v1/api-monitoring | Status: mocked
  Future<ApiResponse> loadApiV1ApiMonitoringList() async {
    return ref.read(apiClientProvider).get('/v1/api-monitoring');
  }

  /// Load Deployment Center List Data
  /// Method: GET | Path: /v1/deployment-center | Status: mocked
  Future<ApiResponse> loadApiV1DeploymentCenterList() async {
    return ref.read(apiClientProvider).get('/v1/deployment-center');
  }

  /// Load Security Audit List Data
  /// Method: GET | Path: /v1/security-audit | Status: mocked
  Future<ApiResponse> loadApiV1SecurityAuditList() async {
    return ref.read(apiClientProvider).get('/v1/security-audit');
  }

  /// Load Release Management List Data
  /// Method: GET | Path: /v1/release-management | Status: mocked
  Future<ApiResponse> loadApiV1ReleaseManagementList() async {
    return ref.read(apiClientProvider).get('/v1/release-management');
  }

  /// Load Compliance List Data
  /// Method: GET | Path: /v1/compliance | Status: mocked
  Future<ApiResponse> loadApiV1ComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/compliance');
  }

  /// Load Audit Review List Data
  /// Method: GET | Path: /v1/audit-review | Status: mocked
  Future<ApiResponse> loadApiV1AuditReviewList() async {
    return ref.read(apiClientProvider).get('/v1/audit-review');
  }

  /// Load Incident Management List Data
  /// Method: GET | Path: /v1/incident-management | Status: mocked
  Future<ApiResponse> loadApiV1IncidentManagementList() async {
    return ref.read(apiClientProvider).get('/v1/incident-management');
  }

  /// Load Policy Management List Data
  /// Method: GET | Path: /v1/policy-management | Status: mocked
  Future<ApiResponse> loadApiV1PolicyManagementList() async {
    return ref.read(apiClientProvider).get('/v1/policy-management');
  }

  /// Load Corrective Action List Data
  /// Method: GET | Path: /v1/corrective-action | Status: mocked
  Future<ApiResponse> loadApiV1CorrectiveActionList() async {
    return ref.read(apiClientProvider).get('/v1/corrective-action');
  }

  /// Load Hiring Pipeline List Data
  /// Method: GET | Path: /v1/hiring-pipeline | Status: mocked
  Future<ApiResponse> loadApiV1HiringPipelineList() async {
    return ref.read(apiClientProvider).get('/v1/hiring-pipeline');
  }

  /// Load Employee Records List Data
  /// Method: GET | Path: /v1/employee-records | Status: mocked
  Future<ApiResponse> loadApiV1EmployeeRecordsList() async {
    return ref.read(apiClientProvider).get('/v1/employee-records');
  }

  /// Load Credential Expiry List Data
  /// Method: GET | Path: /v1/credential-expiry | Status: mocked
  Future<ApiResponse> loadApiV1CredentialExpiryList() async {
    return ref.read(apiClientProvider).get('/v1/credential-expiry');
  }

  /// Load Training Management List Data
  /// Method: GET | Path: /v1/training-management | Status: mocked
  Future<ApiResponse> loadApiV1TrainingManagementList() async {
    return ref.read(apiClientProvider).get('/v1/training-management');
  }

  /// Load Onboarding List Data
  /// Method: GET | Path: /v1/onboarding | Status: mocked
  Future<ApiResponse> loadApiV1OnboardingList() async {
    return ref.read(apiClientProvider).get('/v1/onboarding');
  }

  /// Load Franchise Lead List Data
  /// Method: GET | Path: /v1/franchise-lead | Status: mocked
  Future<ApiResponse> loadApiV1FranchiseLeadList() async {
    return ref.read(apiClientProvider).get('/v1/franchise-lead');
  }

  /// Load Partnership Management List Data
  /// Method: GET | Path: /v1/partnership-management | Status: mocked
  Future<ApiResponse> loadApiV1PartnershipManagementList() async {
    return ref.read(apiClientProvider).get('/v1/partnership-management');
  }

  /// Load Growth Analytics List Data
  /// Method: GET | Path: /v1/growth-analytics | Status: mocked
  Future<ApiResponse> loadApiV1GrowthAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/growth-analytics');
  }

  /// Load Outreach Campaign List Data
  /// Method: GET | Path: /v1/outreach-campaign | Status: mocked
  Future<ApiResponse> loadApiV1OutreachCampaignList() async {
    return ref.read(apiClientProvider).get('/v1/outreach-campaign');
  }

  /// Load Campaign List Data
  /// Method: GET | Path: /v1/campaign | Status: mocked
  Future<ApiResponse> loadApiV1CampaignList() async {
    return ref.read(apiClientProvider).get('/v1/campaign');
  }

  /// Load Lead Analytics List Data
  /// Method: GET | Path: /v1/lead-analytics | Status: mocked
  Future<ApiResponse> loadApiV1LeadAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/lead-analytics');
  }

  /// Load Social Media List Data
  /// Method: GET | Path: /v1/social-media | Status: mocked
  Future<ApiResponse> loadApiV1SocialMediaList() async {
    return ref.read(apiClientProvider).get('/v1/social-media');
  }

  /// Load Brand Management List Data
  /// Method: GET | Path: /v1/brand-management | Status: mocked
  Future<ApiResponse> loadApiV1BrandManagementList() async {
    return ref.read(apiClientProvider).get('/v1/brand-management');
  }

  /// Load Franchise Command Center List Data
  /// Method: GET | Path: /v1/franchise-command-center | Status: mocked
  Future<ApiResponse> loadApiV1FranchiseCommandCenterList() async {
    return ref.read(apiClientProvider).get('/v1/franchise-command-center');
  }

  /// Load Revenue Snapshot List Data
  /// Method: GET | Path: /v1/revenue-snapshot | Status: mocked
  Future<ApiResponse> loadApiV1RevenueSnapshotList() async {
    return ref.read(apiClientProvider).get('/v1/revenue-snapshot');
  }

  /// Load Staff Management List Data
  /// Method: GET | Path: /v1/staff-management | Status: mocked
  Future<ApiResponse> loadApiV1StaffManagementList() async {
    return ref.read(apiClientProvider).get('/v1/staff-management');
  }

  /// Load Appointment List Data
  /// Method: GET | Path: /v1/appointment | Status: mocked
  Future<ApiResponse> loadApiV1AppointmentList() async {
    return ref.read(apiClientProvider).get('/v1/appointment');
  }

  /// Load Daily Operations List Data
  /// Method: GET | Path: /v1/daily-operations | Status: mocked
  Future<ApiResponse> loadApiV1DailyOperationsList() async {
    return ref.read(apiClientProvider).get('/v1/daily-operations');
  }

  /// Load Attendance List Data
  /// Method: GET | Path: /v1/attendance | Status: mocked
  Future<ApiResponse> loadApiV1AttendanceList() async {
    return ref.read(apiClientProvider).get('/v1/attendance');
  }

  /// Load Scheduling Health List Data
  /// Method: GET | Path: /v1/scheduling-health | Status: mocked
  Future<ApiResponse> loadApiV1SchedulingHealthList() async {
    return ref.read(apiClientProvider).get('/v1/scheduling-health');
  }

  /// Load Service Issue List Data
  /// Method: GET | Path: /v1/service-issue | Status: mocked
  Future<ApiResponse> loadApiV1ServiceIssueList() async {
    return ref.read(apiClientProvider).get('/v1/service-issue');
  }

  /// Load Scheduling List Data
  /// Method: GET | Path: /v1/scheduling | Status: mocked
  Future<ApiResponse> loadApiV1SchedulingList() async {
    return ref.read(apiClientProvider).get('/v1/scheduling');
  }

  /// Load Calendar Management List Data
  /// Method: GET | Path: /v1/calendar-management | Status: mocked
  Future<ApiResponse> loadApiV1CalendarManagementList() async {
    return ref.read(apiClientProvider).get('/v1/calendar-management');
  }

  /// Load Conflict Resolution List Data
  /// Method: GET | Path: /v1/conflict-resolution | Status: mocked
  Future<ApiResponse> loadApiV1ConflictResolutionList() async {
    return ref.read(apiClientProvider).get('/v1/conflict-resolution');
  }

  /// Load Open Shift List Data
  /// Method: GET | Path: /v1/open-shift | Status: mocked
  Future<ApiResponse> loadApiV1OpenShiftList() async {
    return ref.read(apiClientProvider).get('/v1/open-shift');
  }

  /// Load Invoice Management List Data
  /// Method: GET | Path: /v1/invoice-management | Status: mocked
  Future<ApiResponse> loadApiV1InvoiceManagementList() async {
    return ref.read(apiClientProvider).get('/v1/invoice-management');
  }

  /// Load Claims Processing List Data
  /// Method: GET | Path: /v1/claims-processing | Status: mocked
  Future<ApiResponse> loadApiV1ClaimsProcessingList() async {
    return ref.read(apiClientProvider).get('/v1/claims-processing');
  }

  /// Load Payment Tracking List Data
  /// Method: GET | Path: /v1/payment-tracking | Status: mocked
  Future<ApiResponse> loadApiV1PaymentTrackingList() async {
    return ref.read(apiClientProvider).get('/v1/payment-tracking');
  }

  /// Load Refund Management List Data
  /// Method: GET | Path: /v1/refund-management | Status: mocked
  Future<ApiResponse> loadApiV1RefundManagementList() async {
    return ref.read(apiClientProvider).get('/v1/refund-management');
  }

  /// Load Applicant Tracking List Data
  /// Method: GET | Path: /v1/applicant-tracking | Status: mocked
  Future<ApiResponse> loadApiV1ApplicantTrackingList() async {
    return ref.read(apiClientProvider).get('/v1/applicant-tracking');
  }

  /// Load Interview Scheduling List Data
  /// Method: GET | Path: /v1/interview-scheduling | Status: mocked
  Future<ApiResponse> loadApiV1InterviewSchedulingList() async {
    return ref.read(apiClientProvider).get('/v1/interview-scheduling');
  }

  /// Load Offer Management List Data
  /// Method: GET | Path: /v1/offer-management | Status: mocked
  Future<ApiResponse> loadApiV1OfferManagementList() async {
    return ref.read(apiClientProvider).get('/v1/offer-management');
  }

  /// Load Onboarding Checklist List Data
  /// Method: GET | Path: /v1/onboarding-checklist | Status: mocked
  Future<ApiResponse> loadApiV1OnboardingChecklistList() async {
    return ref.read(apiClientProvider).get('/v1/onboarding-checklist');
  }

  /// Load Medication Administration List Data
  /// Method: GET | Path: /v1/medication-administration | Status: mocked
  Future<ApiResponse> loadApiV1MedicationAdministrationList() async {
    return ref.read(apiClientProvider).get('/v1/medication-administration');
  }

  /// Create New Medication Administration Record
  /// Method: POST | Path: /v1/medication-administration | Status: mocked
  Future<ApiResponse> createApiV1MedicationAdministrationCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/medication-administration', body: data);
  }

  /// Update Existing Medication Administration Record
  /// Method: PATCH | Path: /v1/medication-administration/:id | Status: mocked
  Future<ApiResponse> updateApiV1MedicationAdministrationUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/medication-administration/$id', body: data);
  }

  /// Load Care Plan Review List Data
  /// Method: GET | Path: /v1/care-plan-review | Status: mocked
  Future<ApiResponse> loadApiV1CarePlanReviewList() async {
    return ref.read(apiClientProvider).get('/v1/care-plan-review');
  }

  /// Create New Care Plan Review Record
  /// Method: POST | Path: /v1/care-plan-review | Status: mocked
  Future<ApiResponse> createApiV1CarePlanReviewCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/care-plan-review', body: data);
  }

  /// Update Existing Care Plan Review Record
  /// Method: PATCH | Path: /v1/care-plan-review/:id | Status: mocked
  Future<ApiResponse> updateApiV1CarePlanReviewUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/care-plan-review/$id', body: data);
  }

  /// Load Incident Review List Data
  /// Method: GET | Path: /v1/incident-review | Status: mocked
  Future<ApiResponse> loadApiV1IncidentReviewList() async {
    return ref.read(apiClientProvider).get('/v1/incident-review');
  }

  /// Create New Incident Review Record
  /// Method: POST | Path: /v1/incident-review | Status: mocked
  Future<ApiResponse> createApiV1IncidentReviewCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/incident-review', body: data);
  }

  /// Update Existing Incident Review Record
  /// Method: PATCH | Path: /v1/incident-review/:id | Status: mocked
  Future<ApiResponse> updateApiV1IncidentReviewUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/incident-review/$id', body: data);
  }

  /// Load Shift Report List Data
  /// Method: GET | Path: /v1/shift-report | Status: mocked
  Future<ApiResponse> loadApiV1ShiftReportList() async {
    return ref.read(apiClientProvider).get('/v1/shift-report');
  }

  /// Create New Shift Report Record
  /// Method: POST | Path: /v1/shift-report | Status: mocked
  Future<ApiResponse> createApiV1ShiftReportCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/shift-report', body: data);
  }

  /// Update Existing Shift Report Record
  /// Method: PATCH | Path: /v1/shift-report/:id | Status: mocked
  Future<ApiResponse> updateApiV1ShiftReportUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/shift-report/$id', body: data);
  }

  /// Load Nursing Task List Data
  /// Method: GET | Path: /v1/nursing-task | Status: mocked
  Future<ApiResponse> loadApiV1NursingTaskList() async {
    return ref.read(apiClientProvider).get('/v1/nursing-task');
  }

  /// Create New Nursing Task Record
  /// Method: POST | Path: /v1/nursing-task | Status: mocked
  Future<ApiResponse> createApiV1NursingTaskCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/nursing-task', body: data);
  }

  /// Update Existing Nursing Task Record
  /// Method: PATCH | Path: /v1/nursing-task/:id | Status: mocked
  Future<ApiResponse> updateApiV1NursingTaskUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/nursing-task/$id', body: data);
  }

  /// Load Vitals Tracking List Data
  /// Method: GET | Path: /v1/vitals-tracking | Status: mocked
  Future<ApiResponse> loadApiV1VitalsTrackingList() async {
    return ref.read(apiClientProvider).get('/v1/vitals-tracking');
  }

  /// Create New Vitals Tracking Record
  /// Method: POST | Path: /v1/vitals-tracking | Status: mocked
  Future<ApiResponse> createApiV1VitalsTrackingCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/vitals-tracking', body: data);
  }

  /// Update Existing Vitals Tracking Record
  /// Method: PATCH | Path: /v1/vitals-tracking/:id | Status: mocked
  Future<ApiResponse> updateApiV1VitalsTrackingUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/vitals-tracking/$id', body: data);
  }

  /// Load Medication List Data
  /// Method: GET | Path: /v1/medication | Status: mocked
  Future<ApiResponse> loadApiV1MedicationList() async {
    return ref.read(apiClientProvider).get('/v1/medication');
  }

  /// Create New Medication Record
  /// Method: POST | Path: /v1/medication | Status: mocked
  Future<ApiResponse> createApiV1MedicationCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/medication', body: data);
  }

  /// Update Existing Medication Record
  /// Method: PATCH | Path: /v1/medication/:id | Status: mocked
  Future<ApiResponse> updateApiV1MedicationUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/medication/$id', body: data);
  }

  /// Load Patient Observation List Data
  /// Method: GET | Path: /v1/patient-observation | Status: mocked
  Future<ApiResponse> loadApiV1PatientObservationList() async {
    return ref.read(apiClientProvider).get('/v1/patient-observation');
  }

  /// Create New Patient Observation Record
  /// Method: POST | Path: /v1/patient-observation | Status: mocked
  Future<ApiResponse> createApiV1PatientObservationCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/patient-observation', body: data);
  }

  /// Update Existing Patient Observation Record
  /// Method: PATCH | Path: /v1/patient-observation/:id | Status: mocked
  Future<ApiResponse> updateApiV1PatientObservationUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/patient-observation/$id', body: data);
  }

  /// Load Shift Tasks List Data
  /// Method: GET | Path: /v1/shift-tasks | Status: mocked
  Future<ApiResponse> loadApiV1ShiftTasksList() async {
    return ref.read(apiClientProvider).get('/v1/shift-tasks');
  }

  /// Load Vitals Entry List Data
  /// Method: GET | Path: /v1/vitals-entry | Status: mocked
  Future<ApiResponse> loadApiV1VitalsEntryList() async {
    return ref.read(apiClientProvider).get('/v1/vitals-entry');
  }

  /// Create New Vitals Entry Record
  /// Method: POST | Path: /v1/vitals-entry | Status: mocked
  Future<ApiResponse> createApiV1VitalsEntryCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/vitals-entry', body: data);
  }

  /// Update Existing Vitals Entry Record
  /// Method: PATCH | Path: /v1/vitals-entry/:id | Status: mocked
  Future<ApiResponse> updateApiV1VitalsEntryUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/vitals-entry/$id', body: data);
  }

  /// Load Treatment Plan List Data
  /// Method: GET | Path: /v1/treatment-plan | Status: mocked
  Future<ApiResponse> loadApiV1TreatmentPlanList() async {
    return ref.read(apiClientProvider).get('/v1/treatment-plan');
  }

  /// Load Exercise Prescription List Data
  /// Method: GET | Path: /v1/exercise-prescription | Status: mocked
  Future<ApiResponse> loadApiV1ExercisePrescriptionList() async {
    return ref.read(apiClientProvider).get('/v1/exercise-prescription');
  }

  /// Load Progress Tracking List Data
  /// Method: GET | Path: /v1/progress-tracking | Status: mocked
  Future<ApiResponse> loadApiV1ProgressTrackingList() async {
    return ref.read(apiClientProvider).get('/v1/progress-tracking');
  }

  /// Load Massage Assessment List Data
  /// Method: GET | Path: /v1/massage-assessment | Status: mocked
  Future<ApiResponse> loadApiV1MassageAssessmentList() async {
    return ref.read(apiClientProvider).get('/v1/massage-assessment');
  }

  /// Create New Massage Assessment Record
  /// Method: POST | Path: /v1/massage-assessment | Status: mocked
  Future<ApiResponse> createApiV1MassageAssessmentCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/massage-assessment', body: data);
  }

  /// Update Existing Massage Assessment Record
  /// Method: PATCH | Path: /v1/massage-assessment/:id | Status: mocked
  Future<ApiResponse> updateApiV1MassageAssessmentUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/massage-assessment/$id', body: data);
  }

  /// Load Home Care Plan List Data
  /// Method: GET | Path: /v1/home-care-plan | Status: mocked
  Future<ApiResponse> loadApiV1HomeCarePlanList() async {
    return ref.read(apiClientProvider).get('/v1/home-care-plan');
  }

  /// Create New Home Care Plan Record
  /// Method: POST | Path: /v1/home-care-plan | Status: mocked
  Future<ApiResponse> createApiV1HomeCarePlanCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/home-care-plan', body: data);
  }

  /// Update Existing Home Care Plan Record
  /// Method: PATCH | Path: /v1/home-care-plan/:id | Status: mocked
  Future<ApiResponse> updateApiV1HomeCarePlanUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/home-care-plan/$id', body: data);
  }

  /// Load Client Progress List Data
  /// Method: GET | Path: /v1/client-progress | Status: mocked
  Future<ApiResponse> loadApiV1ClientProgressList() async {
    return ref.read(apiClientProvider).get('/v1/client-progress');
  }

  /// Create New Client Progress Record
  /// Method: POST | Path: /v1/client-progress | Status: mocked
  Future<ApiResponse> createApiV1ClientProgressCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/client-progress', body: data);
  }

  /// Update Existing Client Progress Record
  /// Method: PATCH | Path: /v1/client-progress/:id | Status: mocked
  Future<ApiResponse> updateApiV1ClientProgressUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/client-progress/$id', body: data);
  }

  /// Load Chiropractic Assessment List Data
  /// Method: GET | Path: /v1/chiropractic-assessment | Status: mocked
  Future<ApiResponse> loadApiV1ChiropracticAssessmentList() async {
    return ref.read(apiClientProvider).get('/v1/chiropractic-assessment');
  }

  /// Load Adjustment Notes List Data
  /// Method: GET | Path: /v1/adjustment-notes | Status: mocked
  Future<ApiResponse> loadApiV1AdjustmentNotesList() async {
    return ref.read(apiClientProvider).get('/v1/adjustment-notes');
  }

  /// Create New Adjustment Notes Record
  /// Method: POST | Path: /v1/adjustment-notes | Status: mocked
  Future<ApiResponse> createApiV1AdjustmentNotesCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/adjustment-notes', body: data);
  }

  /// Update Existing Adjustment Notes Record
  /// Method: PATCH | Path: /v1/adjustment-notes/:id | Status: mocked
  Future<ApiResponse> updateApiV1AdjustmentNotesUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/adjustment-notes/$id', body: data);
  }

  /// Load Xray Review List Data
  /// Method: GET | Path: /v1/xray-review | Status: mocked
  Future<ApiResponse> loadApiV1XrayReviewList() async {
    return ref.read(apiClientProvider).get('/v1/xray-review');
  }

  /// Load Chiropractic Progress Tracking List Data
  /// Method: GET | Path: /v1/chiropractic-progress-tracking | Status: mocked
  Future<ApiResponse> loadApiV1ChiropracticProgressTrackingList() async {
    return ref.read(apiClientProvider).get('/v1/chiropractic-progress-tracking');
  }

  /// Load Referral Management List Data
  /// Method: GET | Path: /v1/referral-management | Status: mocked
  Future<ApiResponse> loadApiV1ReferralManagementList() async {
    return ref.read(apiClientProvider).get('/v1/referral-management');
  }

  /// Create New Referral Management Record
  /// Method: POST | Path: /v1/referral-management | Status: mocked
  Future<ApiResponse> createApiV1ReferralManagementCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/referral-management', body: data);
  }

  /// Update Existing Referral Management Record
  /// Method: PATCH | Path: /v1/referral-management/:id | Status: mocked
  Future<ApiResponse> updateApiV1ReferralManagementUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/referral-management/$id', body: data);
  }

  /// Load Client Intake List Data
  /// Method: GET | Path: /v1/client-intake | Status: mocked
  Future<ApiResponse> loadApiV1ClientIntakeList() async {
    return ref.read(apiClientProvider).get('/v1/client-intake');
  }

  /// Create New Client Intake Record
  /// Method: POST | Path: /v1/client-intake | Status: mocked
  Future<ApiResponse> createApiV1ClientIntakeCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/client-intake', body: data);
  }

  /// Update Existing Client Intake Record
  /// Method: PATCH | Path: /v1/client-intake/:id | Status: mocked
  Future<ApiResponse> updateApiV1ClientIntakeUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/client-intake/$id', body: data);
  }

  /// Load Booking List Data
  /// Method: GET | Path: /v1/booking | Status: mocked
  Future<ApiResponse> loadApiV1BookingList() async {
    return ref.read(apiClientProvider).get('/v1/booking');
  }

  /// Create New Booking Record
  /// Method: POST | Path: /v1/booking | Status: mocked
  Future<ApiResponse> createApiV1BookingCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/booking', body: data);
  }

  /// Update Existing Booking Record
  /// Method: PATCH | Path: /v1/booking/:id | Status: mocked
  Future<ApiResponse> updateApiV1BookingUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/booking/$id', body: data);
  }

  /// Load Followup List Data
  /// Method: GET | Path: /v1/followup | Status: mocked
  Future<ApiResponse> loadApiV1FollowupList() async {
    return ref.read(apiClientProvider).get('/v1/followup');
  }

  /// Create New Followup Record
  /// Method: POST | Path: /v1/followup | Status: mocked
  Future<ApiResponse> createApiV1FollowupCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/followup', body: data);
  }

  /// Update Existing Followup Record
  /// Method: PATCH | Path: /v1/followup/:id | Status: mocked
  Future<ApiResponse> updateApiV1FollowupUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/followup/$id', body: data);
  }

  /// Load Clinical Quality List Data
  /// Method: GET | Path: /v1/clinical-quality | Status: mocked
  Future<ApiResponse> loadApiV1ClinicalQualityList() async {
    return ref.read(apiClientProvider).get('/v1/clinical-quality');
  }

  /// Load Staff Performance List Data
  /// Method: GET | Path: /v1/staff-performance | Status: mocked
  Future<ApiResponse> loadApiV1StaffPerformanceList() async {
    return ref.read(apiClientProvider).get('/v1/staff-performance');
  }

  /// Create New Staff Performance Record
  /// Method: POST | Path: /v1/staff-performance | Status: mocked
  Future<ApiResponse> createApiV1StaffPerformanceCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/staff-performance', body: data);
  }

  /// Update Existing Staff Performance Record
  /// Method: PATCH | Path: /v1/staff-performance/:id | Status: mocked
  Future<ApiResponse> updateApiV1StaffPerformanceUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/staff-performance/$id', body: data);
  }

  /// Load Compliance Review List Data
  /// Method: GET | Path: /v1/compliance-review | Status: mocked
  Future<ApiResponse> loadApiV1ComplianceReviewList() async {
    return ref.read(apiClientProvider).get('/v1/compliance-review');
  }

  /// Load Incident Oversight List Data
  /// Method: GET | Path: /v1/incident-oversight | Status: mocked
  Future<ApiResponse> loadApiV1IncidentOversightList() async {
    return ref.read(apiClientProvider).get('/v1/incident-oversight');
  }

  /// Load Ticket Management List Data
  /// Method: GET | Path: /v1/ticket-management | Status: mocked
  Future<ApiResponse> loadApiV1TicketManagementList() async {
    return ref.read(apiClientProvider).get('/v1/ticket-management');
  }

  /// Load Client Issue List Data
  /// Method: GET | Path: /v1/client-issue | Status: mocked
  Future<ApiResponse> loadApiV1ClientIssueList() async {
    return ref.read(apiClientProvider).get('/v1/client-issue');
  }

  /// Load Communication List Data
  /// Method: GET | Path: /v1/communication | Status: mocked
  Future<ApiResponse> loadApiV1CommunicationList() async {
    return ref.read(apiClientProvider).get('/v1/communication');
  }

  /// Load Resolution Tracking List Data
  /// Method: GET | Path: /v1/resolution-tracking | Status: mocked
  Future<ApiResponse> loadApiV1ResolutionTrackingList() async {
    return ref.read(apiClientProvider).get('/v1/resolution-tracking');
  }

  /// Load Training List Data
  /// Method: GET | Path: /v1/training | Status: mocked
  Future<ApiResponse> loadApiV1TrainingList() async {
    return ref.read(apiClientProvider).get('/v1/training');
  }

  /// Load Course Assignment List Data
  /// Method: GET | Path: /v1/course-assignment | Status: mocked
  Future<ApiResponse> loadApiV1CourseAssignmentList() async {
    return ref.read(apiClientProvider).get('/v1/course-assignment');
  }

  /// Load Certification Tracking List Data
  /// Method: GET | Path: /v1/certification-tracking | Status: mocked
  Future<ApiResponse> loadApiV1CertificationTrackingList() async {
    return ref.read(apiClientProvider).get('/v1/certification-tracking');
  }

  /// Load Staff Progress List Data
  /// Method: GET | Path: /v1/staff-progress | Status: mocked
  Future<ApiResponse> loadApiV1StaffProgressList() async {
    return ref.read(apiClientProvider).get('/v1/staff-progress');
  }

  /// Load Quality Audit List Data
  /// Method: GET | Path: /v1/quality-audit | Status: mocked
  Future<ApiResponse> loadApiV1QualityAuditList() async {
    return ref.read(apiClientProvider).get('/v1/quality-audit');
  }

  /// Load Failed Workflow List Data
  /// Method: GET | Path: /v1/failed-workflow | Status: mocked
  Future<ApiResponse> loadApiV1FailedWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/failed-workflow');
  }

  /// Load Testing List Data
  /// Method: GET | Path: /v1/testing | Status: mocked
  Future<ApiResponse> loadApiV1TestingList() async {
    return ref.read(apiClientProvider).get('/v1/testing');
  }

  /// Load Defect Tracking List Data
  /// Method: GET | Path: /v1/defect-tracking | Status: mocked
  Future<ApiResponse> loadApiV1DefectTrackingList() async {
    return ref.read(apiClientProvider).get('/v1/defect-tracking');
  }

  /// Load Care Plan List Data
  /// Method: GET | Path: /v1/care-plan | Status: mocked
  Future<ApiResponse> loadApiV1CarePlanList() async {
    return ref.read(apiClientProvider).get('/v1/care-plan');
  }

  /// Load Billing List Data
  /// Method: GET | Path: /v1/billing | Status: mocked
  Future<ApiResponse> loadApiV1BillingList() async {
    return ref.read(apiClientProvider).get('/v1/billing');
  }

  /// Load Documents List Data
  /// Method: GET | Path: /v1/documents | Status: mocked
  Future<ApiResponse> loadApiV1DocumentsList() async {
    return ref.read(apiClientProvider).get('/v1/documents');
  }

  /// Load Family List Data
  /// Method: GET | Path: /v1/family | Status: mocked
  Future<ApiResponse> loadApiV1FamilyList() async {
    return ref.read(apiClientProvider).get('/v1/family');
  }

  /// Load Care Updates List Data
  /// Method: GET | Path: /v1/care-updates | Status: mocked
  Future<ApiResponse> loadApiV1CareUpdatesList() async {
    return ref.read(apiClientProvider).get('/v1/care-updates');
  }

  /// Create New Care Updates Record
  /// Method: POST | Path: /v1/care-updates | Status: mocked
  Future<ApiResponse> createApiV1CareUpdatesCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/care-updates', body: data);
  }

  /// Update Existing Care Updates Record
  /// Method: PATCH | Path: /v1/care-updates/:id | Status: mocked
  Future<ApiResponse> updateApiV1CareUpdatesUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/care-updates/$id', body: data);
  }

  /// Load Emergency Contacts List Data
  /// Method: GET | Path: /v1/emergency-contacts | Status: mocked
  Future<ApiResponse> loadApiV1EmergencyContactsList() async {
    return ref.read(apiClientProvider).get('/v1/emergency-contacts');
  }

  /// Load Schedule List Data
  /// Method: GET | Path: /v1/schedule | Status: mocked
  Future<ApiResponse> loadApiV1ScheduleList() async {
    return ref.read(apiClientProvider).get('/v1/schedule');
  }

  /// Load Messaging List Data
  /// Method: GET | Path: /v1/messaging | Status: mocked
  Future<ApiResponse> loadApiV1MessagingList() async {
    return ref.read(apiClientProvider).get('/v1/messaging');
  }

  /// Load Governance Control Room List Data
  /// Method: GET | Path: /v1/governance-control-room | Status: mocked
  Future<ApiResponse> loadApiV1GovernanceControlRoomList() async {
    return ref.read(apiClientProvider).get('/v1/governance-control-room');
  }

  /// Load Runtime Verification List Data
  /// Method: GET | Path: /v1/runtime-verification | Status: mocked
  Future<ApiResponse> loadApiV1RuntimeVerificationList() async {
    return ref.read(apiClientProvider).get('/v1/runtime-verification');
  }

  /// Load Drift Findings List Data
  /// Method: GET | Path: /v1/drift-findings | Status: mocked
  Future<ApiResponse> loadApiV1DriftFindingsList() async {
    return ref.read(apiClientProvider).get('/v1/drift-findings');
  }

  /// Load Pending Task Queue List Data
  /// Method: GET | Path: /v1/pending-task-queue | Status: mocked
  Future<ApiResponse> loadApiV1PendingTaskQueueList() async {
    return ref.read(apiClientProvider).get('/v1/pending-task-queue');
  }

  /// Load Agent Dispatch List Data
  /// Method: GET | Path: /v1/agent-dispatch | Status: mocked
  Future<ApiResponse> loadApiV1AgentDispatchList() async {
    return ref.read(apiClientProvider).get('/v1/agent-dispatch');
  }

  /// Load Audit List Data
  /// Method: GET | Path: /v1/audit | Status: mocked
  Future<ApiResponse> loadApiV1AuditList() async {
    return ref.read(apiClientProvider).get('/v1/audit');
  }

  /// Create New Audit Record
  /// Method: POST | Path: /v1/audit | Status: mocked
  Future<ApiResponse> createApiV1AuditCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/audit', body: data);
  }

  /// Update Existing Audit Record
  /// Method: PATCH | Path: /v1/audit/:id | Status: mocked
  Future<ApiResponse> updateApiV1AuditUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/audit/$id', body: data);
  }

  /// Load Api Health List Data
  /// Method: GET | Path: /v1/api-health | Status: mocked
  Future<ApiResponse> loadApiV1ApiHealthList() async {
    return ref.read(apiClientProvider).get('/v1/api-health');
  }

  /// Load Release Operations List Data
  /// Method: GET | Path: /v1/release-operations | Status: mocked
  Future<ApiResponse> loadApiV1ReleaseOperationsList() async {
    return ref.read(apiClientProvider).get('/v1/release-operations');
  }

  /// Load File Verification List Data
  /// Method: GET | Path: /v1/file-verification | Status: mocked
  Future<ApiResponse> loadApiV1FileVerificationList() async {
    return ref.read(apiClientProvider).get('/v1/file-verification');
  }

  /// Load Role Coverage List Data
  /// Method: GET | Path: /v1/role-coverage | Status: mocked
  Future<ApiResponse> loadApiV1RoleCoverageList() async {
    return ref.read(apiClientProvider).get('/v1/role-coverage');
  }

  /// Load Responsive Preview List Data
  /// Method: GET | Path: /v1/responsive-preview | Status: mocked
  Future<ApiResponse> loadApiV1ResponsivePreviewList() async {
    return ref.read(apiClientProvider).get('/v1/responsive-preview');
  }

  /// Load Workflow Execution List Data
  /// Method: GET | Path: /v1/workflow-execution | Status: mocked
  Future<ApiResponse> loadApiV1WorkflowExecutionList() async {
    return ref.read(apiClientProvider).get('/v1/workflow-execution');
  }

  /// Load Enterprise Command Center4 K List Data
  /// Method: GET | Path: /v1/enterprise-command-center4-k | Status: mocked
  Future<ApiResponse> loadApiV1EnterpriseCommandCenter4KList() async {
    return ref.read(apiClientProvider).get('/v1/enterprise-command-center4-k');
  }

  /// Load Franchise Command Center4 K List Data
  /// Method: GET | Path: /v1/franchise-command-center4-k | Status: mocked
  Future<ApiResponse> loadApiV1FranchiseCommandCenter4KList() async {
    return ref.read(apiClientProvider).get('/v1/franchise-command-center4-k');
  }

  /// Load Clinical Operations4 K List Data
  /// Method: GET | Path: /v1/clinical-operations4-k | Status: mocked
  Future<ApiResponse> loadApiV1ClinicalOperations4KList() async {
    return ref.read(apiClientProvider).get('/v1/clinical-operations4-k');
  }

  /// Load Governance Operations4 K List Data
  /// Method: GET | Path: /v1/governance-operations4-k | Status: mocked
  Future<ApiResponse> loadApiV1GovernanceOperations4KList() async {
    return ref.read(apiClientProvider).get('/v1/governance-operations4-k');
  }

  /// Load Scheduling Operations4 K List Data
  /// Method: GET | Path: /v1/scheduling-operations4-k | Status: mocked
  Future<ApiResponse> loadApiV1SchedulingOperations4KList() async {
    return ref.read(apiClientProvider).get('/v1/scheduling-operations4-k');
  }

  /// Load Financial Operations4 K List Data
  /// Method: GET | Path: /v1/financial-operations4-k | Status: mocked
  Future<ApiResponse> loadApiV1FinancialOperations4KList() async {
    return ref.read(apiClientProvider).get('/v1/financial-operations4-k');
  }

  /// Load Therapist Analytics List Data
  /// Method: GET | Path: /v1/therapist-analytics | Status: mocked
  Future<ApiResponse> loadApiV1TherapistAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/therapist-analytics');
  }

  /// Load Therapist Workflow List Data
  /// Method: GET | Path: /v1/therapist-workflow | Status: mocked
  Future<ApiResponse> loadApiV1TherapistWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/therapist-workflow');
  }

  /// Load Physician Analytics List Data
  /// Method: GET | Path: /v1/physician-analytics | Status: mocked
  Future<ApiResponse> loadApiV1PhysicianAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/physician-analytics');
  }

  /// Load Physician Workflow List Data
  /// Method: GET | Path: /v1/physician-workflow | Status: mocked
  Future<ApiResponse> loadApiV1PhysicianWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/physician-workflow');
  }

  /// Load Cns Analytics List Data
  /// Method: GET | Path: /v1/cns-analytics | Status: mocked
  Future<ApiResponse> loadApiV1CnsAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/cns-analytics');
  }

  /// Load Cns Workflow List Data
  /// Method: GET | Path: /v1/cns-workflow | Status: mocked
  Future<ApiResponse> loadApiV1CnsWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/cns-workflow');
  }

  /// Load Pediatric Analytics List Data
  /// Method: GET | Path: /v1/pediatric-analytics | Status: mocked
  Future<ApiResponse> loadApiV1PediatricAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/pediatric-analytics');
  }

  /// Load Pediatric Workflow List Data
  /// Method: GET | Path: /v1/pediatric-workflow | Status: mocked
  Future<ApiResponse> loadApiV1PediatricWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/pediatric-workflow');
  }

  /// Load Franchise Sales Analytics List Data
  /// Method: GET | Path: /v1/franchise-sales-analytics | Status: mocked
  Future<ApiResponse> loadApiV1FranchiseSalesAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/franchise-sales-analytics');
  }

  /// Load Franchise Sales Workflow List Data
  /// Method: GET | Path: /v1/franchise-sales-workflow | Status: mocked
  Future<ApiResponse> loadApiV1FranchiseSalesWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/franchise-sales-workflow');
  }

  /// Load Premium Concierge Analytics List Data
  /// Method: GET | Path: /v1/premium-concierge-analytics | Status: mocked
  Future<ApiResponse> loadApiV1PremiumConciergeAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/premium-concierge-analytics');
  }

  /// Load Premium Concierge Workflow List Data
  /// Method: GET | Path: /v1/premium-concierge-workflow | Status: mocked
  Future<ApiResponse> loadApiV1PremiumConciergeWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/premium-concierge-workflow');
  }

  /// Load Vip Manager Analytics List Data
  /// Method: GET | Path: /v1/vip-manager-analytics | Status: mocked
  Future<ApiResponse> loadApiV1VipManagerAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/vip-manager-analytics');
  }

  /// Load Vip Manager Workflow List Data
  /// Method: GET | Path: /v1/vip-manager-workflow | Status: mocked
  Future<ApiResponse> loadApiV1VipManagerWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/vip-manager-workflow');
  }

  /// Load Rn Field Supervisor Analytics List Data
  /// Method: GET | Path: /v1/rn-field-supervisor-analytics | Status: mocked
  Future<ApiResponse> loadApiV1RnFieldSupervisorAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/rn-field-supervisor-analytics');
  }

  /// Create New Rn Field Supervisor Analytics Record
  /// Method: POST | Path: /v1/rn-field-supervisor-analytics | Status: mocked
  Future<ApiResponse> createApiV1RnFieldSupervisorAnalyticsCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rn-field-supervisor-analytics', body: data);
  }

  /// Update Existing Rn Field Supervisor Analytics Record
  /// Method: PATCH | Path: /v1/rn-field-supervisor-analytics/:id | Status: mocked
  Future<ApiResponse> updateApiV1RnFieldSupervisorAnalyticsUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rn-field-supervisor-analytics/$id', body: data);
  }

  /// Load Rn Field Supervisor Workflow List Data
  /// Method: GET | Path: /v1/rn-field-supervisor-workflow | Status: mocked
  Future<ApiResponse> loadApiV1RnFieldSupervisorWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/rn-field-supervisor-workflow');
  }

  /// Create New Rn Field Supervisor Workflow Record
  /// Method: POST | Path: /v1/rn-field-supervisor-workflow | Status: mocked
  Future<ApiResponse> createApiV1RnFieldSupervisorWorkflowCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rn-field-supervisor-workflow', body: data);
  }

  /// Update Existing Rn Field Supervisor Workflow Record
  /// Method: PATCH | Path: /v1/rn-field-supervisor-workflow/:id | Status: mocked
  Future<ApiResponse> updateApiV1RnFieldSupervisorWorkflowUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rn-field-supervisor-workflow/$id', body: data);
  }

  /// Load Np Analytics List Data
  /// Method: GET | Path: /v1/np-analytics | Status: mocked
  Future<ApiResponse> loadApiV1NpAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/np-analytics');
  }

  /// Load Np Workflow List Data
  /// Method: GET | Path: /v1/np-workflow | Status: mocked
  Future<ApiResponse> loadApiV1NpWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/np-workflow');
  }

  /// Load Lpn Analytics List Data
  /// Method: GET | Path: /v1/lpn-analytics | Status: mocked
  Future<ApiResponse> loadApiV1LpnAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/lpn-analytics');
  }

  /// Load Lpn Workflow List Data
  /// Method: GET | Path: /v1/lpn-workflow | Status: mocked
  Future<ApiResponse> loadApiV1LpnWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/lpn-workflow');
  }

  /// Load Employee Analytics List Data
  /// Method: GET | Path: /v1/employee-analytics | Status: mocked
  Future<ApiResponse> loadApiV1EmployeeAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/employee-analytics');
  }

  /// Load Employee Workflow List Data
  /// Method: GET | Path: /v1/employee-workflow | Status: mocked
  Future<ApiResponse> loadApiV1EmployeeWorkflowList() async {
    return ref.read(apiClientProvider).get('/v1/employee-workflow');
  }

  /// Load Success Profile List Data
  /// Method: GET | Path: /v1/success-profile | Status: mocked
  Future<ApiResponse> loadApiV1SuccessProfileList() async {
    return ref.read(apiClientProvider).get('/v1/success-profile');
  }

  /// Load Consent List Data
  /// Method: GET | Path: /v1/consent | Status: mocked
  Future<ApiResponse> loadApiV1ConsentList() async {
    return ref.read(apiClientProvider).get('/v1/consent');
  }

  /// Create New Consent Record
  /// Method: POST | Path: /v1/consent | Status: mocked
  Future<ApiResponse> createApiV1ConsentCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/consent', body: data);
  }

  /// Update Existing Consent Record
  /// Method: PATCH | Path: /v1/consent/:id | Status: mocked
  Future<ApiResponse> updateApiV1ConsentUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/consent/$id', body: data);
  }

  /// Load Regional Bdm Competitor Notes List Data
  /// Method: GET | Path: /v1/regional-bdm-competitor-notes | Status: mocked
  Future<ApiResponse> loadApiV1RegionalBdmCompetitorNotesList() async {
    return ref.read(apiClientProvider).get('/v1/regional-bdm-competitor-notes');
  }

  /// Create New Regional Bdm Competitor Notes Record
  /// Method: POST | Path: /v1/regional-bdm-competitor-notes | Status: mocked
  Future<ApiResponse> createApiV1RegionalBdmCompetitorNotesCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/regional-bdm-competitor-notes', body: data);
  }

  /// Update Existing Regional Bdm Competitor Notes Record
  /// Method: PATCH | Path: /v1/regional-bdm-competitor-notes/:id | Status: mocked
  Future<ApiResponse> updateApiV1RegionalBdmCompetitorNotesUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/regional-bdm-competitor-notes/$id', body: data);
  }

  /// Load Regional Bdm Deal Tracker List Data
  /// Method: GET | Path: /v1/regional-bdm-deal-tracker | Status: mocked
  Future<ApiResponse> loadApiV1RegionalBdmDealTrackerList() async {
    return ref.read(apiClientProvider).get('/v1/regional-bdm-deal-tracker');
  }

  /// Load Regional Bdm Franchise Pipeline List Data
  /// Method: GET | Path: /v1/regional-bdm-franchise-pipeline | Status: mocked
  Future<ApiResponse> loadApiV1RegionalBdmFranchisePipelineList() async {
    return ref.read(apiClientProvider).get('/v1/regional-bdm-franchise-pipeline');
  }

  /// Load Regional Bdm Leads List Data
  /// Method: GET | Path: /v1/regional-bdm-leads | Status: mocked
  Future<ApiResponse> loadApiV1RegionalBdmLeadsList() async {
    return ref.read(apiClientProvider).get('/v1/regional-bdm-leads');
  }

  /// Load Regional Bdm Meetings List Data
  /// Method: GET | Path: /v1/regional-bdm-meetings | Status: mocked
  Future<ApiResponse> loadApiV1RegionalBdmMeetingsList() async {
    return ref.read(apiClientProvider).get('/v1/regional-bdm-meetings');
  }

  /// Load Regional Bdm Partners List Data
  /// Method: GET | Path: /v1/regional-bdm-partners | Status: mocked
  Future<ApiResponse> loadApiV1RegionalBdmPartnersList() async {
    return ref.read(apiClientProvider).get('/v1/regional-bdm-partners');
  }

  /// Load Regional Bdm Reports List Data
  /// Method: GET | Path: /v1/regional-bdm-reports | Status: mocked
  Future<ApiResponse> loadApiV1RegionalBdmReportsList() async {
    return ref.read(apiClientProvider).get('/v1/regional-bdm-reports');
  }

  /// Load Regional Bdm Tasks List Data
  /// Method: GET | Path: /v1/regional-bdm-tasks | Status: mocked
  Future<ApiResponse> loadApiV1RegionalBdmTasksList() async {
    return ref.read(apiClientProvider).get('/v1/regional-bdm-tasks');
  }

  /// Load Regional Bdm Territory Growth List Data
  /// Method: GET | Path: /v1/regional-bdm-territory-growth | Status: mocked
  Future<ApiResponse> loadApiV1RegionalBdmTerritoryGrowthList() async {
    return ref.read(apiClientProvider).get('/v1/regional-bdm-territory-growth');
  }

  /// Load Franchise Sales Manager Contracts List Data
  /// Method: GET | Path: /v1/franchise-sales-manager-contracts | Status: mocked
  Future<ApiResponse> loadApiV1FranchiseSalesManagerContractsList() async {
    return ref.read(apiClientProvider).get('/v1/franchise-sales-manager-contracts');
  }

  /// Load Franchise Sales Manager Discovery Calls List Data
  /// Method: GET | Path: /v1/franchise-sales-manager-discovery-calls | Status: mocked
  Future<ApiResponse> loadApiV1FranchiseSalesManagerDiscoveryCallsList() async {
    return ref.read(apiClientProvider).get('/v1/franchise-sales-manager-discovery-calls');
  }

  /// Load Franchise Sales Manager Follow Ups List Data
  /// Method: GET | Path: /v1/franchise-sales-manager-follow-ups | Status: mocked
  Future<ApiResponse> loadApiV1FranchiseSalesManagerFollowUpsList() async {
    return ref.read(apiClientProvider).get('/v1/franchise-sales-manager-follow-ups');
  }

  /// Load Franchise Sales Manager Leads List Data
  /// Method: GET | Path: /v1/franchise-sales-manager-leads | Status: mocked
  Future<ApiResponse> loadApiV1FranchiseSalesManagerLeadsList() async {
    return ref.read(apiClientProvider).get('/v1/franchise-sales-manager-leads');
  }

  /// Load Franchise Sales Manager Proposals List Data
  /// Method: GET | Path: /v1/franchise-sales-manager-proposals | Status: mocked
  Future<ApiResponse> loadApiV1FranchiseSalesManagerProposalsList() async {
    return ref.read(apiClientProvider).get('/v1/franchise-sales-manager-proposals');
  }

  /// Load Franchise Sales Manager Prospects List Data
  /// Method: GET | Path: /v1/franchise-sales-manager-prospects | Status: mocked
  Future<ApiResponse> loadApiV1FranchiseSalesManagerProspectsList() async {
    return ref.read(apiClientProvider).get('/v1/franchise-sales-manager-prospects');
  }

  /// Load Franchise Sales Manager Reports List Data
  /// Method: GET | Path: /v1/franchise-sales-manager-reports | Status: mocked
  Future<ApiResponse> loadApiV1FranchiseSalesManagerReportsList() async {
    return ref.read(apiClientProvider).get('/v1/franchise-sales-manager-reports');
  }

  /// Load Franchise Sales Manager Sales Pipeline List Data
  /// Method: GET | Path: /v1/franchise-sales-manager-sales-pipeline | Status: mocked
  Future<ApiResponse> loadApiV1FranchiseSalesManagerSalesPipelineList() async {
    return ref.read(apiClientProvider).get('/v1/franchise-sales-manager-sales-pipeline');
  }

  /// Load Partnership Manager Active Deals List Data
  /// Method: GET | Path: /v1/partnership-manager-active-deals | Status: mocked
  Future<ApiResponse> loadApiV1PartnershipManagerActiveDealsList() async {
    return ref.read(apiClientProvider).get('/v1/partnership-manager-active-deals');
  }

  /// Load Partnership Manager Outreach List Data
  /// Method: GET | Path: /v1/partnership-manager-outreach | Status: mocked
  Future<ApiResponse> loadApiV1PartnershipManagerOutreachList() async {
    return ref.read(apiClientProvider).get('/v1/partnership-manager-outreach');
  }

  /// Load Partnership Manager Partners List Data
  /// Method: GET | Path: /v1/partnership-manager-partners | Status: mocked
  Future<ApiResponse> loadApiV1PartnershipManagerPartnersList() async {
    return ref.read(apiClientProvider).get('/v1/partnership-manager-partners');
  }

  /// Load Partnership Manager Proposals List Data
  /// Method: GET | Path: /v1/partnership-manager-proposals | Status: mocked
  Future<ApiResponse> loadApiV1PartnershipManagerProposalsList() async {
    return ref.read(apiClientProvider).get('/v1/partnership-manager-proposals');
  }

  /// Load Partnership Manager Renewals List Data
  /// Method: GET | Path: /v1/partnership-manager-renewals | Status: mocked
  Future<ApiResponse> loadApiV1PartnershipManagerRenewalsList() async {
    return ref.read(apiClientProvider).get('/v1/partnership-manager-renewals');
  }

  /// Create New Partnership Manager Renewals Record
  /// Method: POST | Path: /v1/partnership-manager-renewals | Status: mocked
  Future<ApiResponse> createApiV1PartnershipManagerRenewalsCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/partnership-manager-renewals', body: data);
  }

  /// Update Existing Partnership Manager Renewals Record
  /// Method: PATCH | Path: /v1/partnership-manager-renewals/:id | Status: mocked
  Future<ApiResponse> updateApiV1PartnershipManagerRenewalsUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/partnership-manager-renewals/$id', body: data);
  }

  /// Load Partnership Manager Reports List Data
  /// Method: GET | Path: /v1/partnership-manager-reports | Status: mocked
  Future<ApiResponse> loadApiV1PartnershipManagerReportsList() async {
    return ref.read(apiClientProvider).get('/v1/partnership-manager-reports');
  }

  /// Load Regional Manager Ontario List Data
  /// Method: GET | Path: /v1/regional-manager-ontario | Status: mocked
  Future<ApiResponse> loadApiV1RegionalManagerOntarioList() async {
    return ref.read(apiClientProvider).get('/v1/regional-manager-ontario');
  }

  /// Load Territory Expansion Manager Demographics List Data
  /// Method: GET | Path: /v1/territory-expansion-manager-demographics | Status: mocked
  Future<ApiResponse> loadApiV1TerritoryExpansionManagerDemographicsList() async {
    return ref.read(apiClientProvider).get('/v1/territory-expansion-manager-demographics');
  }

  /// Load Territory Expansion Manager Expansion Plans List Data
  /// Method: GET | Path: /v1/territory-expansion-manager-expansion-plans | Status: mocked
  Future<ApiResponse> loadApiV1TerritoryExpansionManagerExpansionPlansList() async {
    return ref.read(apiClientProvider).get('/v1/territory-expansion-manager-expansion-plans');
  }

  /// Load Territory Expansion Manager Forecast List Data
  /// Method: GET | Path: /v1/territory-expansion-manager-forecast | Status: mocked
  Future<ApiResponse> loadApiV1TerritoryExpansionManagerForecastList() async {
    return ref.read(apiClientProvider).get('/v1/territory-expansion-manager-forecast');
  }

  /// Load Territory Expansion Manager Market Research List Data
  /// Method: GET | Path: /v1/territory-expansion-manager-market-research | Status: mocked
  Future<ApiResponse> loadApiV1TerritoryExpansionManagerMarketResearchList() async {
    return ref.read(apiClientProvider).get('/v1/territory-expansion-manager-market-research');
  }

  /// Load Territory Expansion Manager Open Territories List Data
  /// Method: GET | Path: /v1/territory-expansion-manager-open-territories | Status: mocked
  Future<ApiResponse> loadApiV1TerritoryExpansionManagerOpenTerritoriesList() async {
    return ref.read(apiClientProvider).get('/v1/territory-expansion-manager-open-territories');
  }

  /// Load Territory Expansion Manager Reports List Data
  /// Method: GET | Path: /v1/territory-expansion-manager-reports | Status: mocked
  Future<ApiResponse> loadApiV1TerritoryExpansionManagerReportsList() async {
    return ref.read(apiClientProvider).get('/v1/territory-expansion-manager-reports');
  }

  /// Load Territory Expansion Manager Site Selection List Data
  /// Method: GET | Path: /v1/territory-expansion-manager-site-selection | Status: mocked
  Future<ApiResponse> loadApiV1TerritoryExpansionManagerSiteSelectionList() async {
    return ref.read(apiClientProvider).get('/v1/territory-expansion-manager-site-selection');
  }

  /// Load Territory Expansion Manager Territory Map List Data
  /// Method: GET | Path: /v1/territory-expansion-manager-territory-map | Status: mocked
  Future<ApiResponse> loadApiV1TerritoryExpansionManagerTerritoryMapList() async {
    return ref.read(apiClientProvider).get('/v1/territory-expansion-manager-territory-map');
  }

  /// Load Ai Chatbot List Data
  /// Method: GET | Path: /v1/ai-chatbot | Status: mocked
  Future<ApiResponse> loadApiV1AiChatbotList() async {
    return ref.read(apiClientProvider).get('/v1/ai-chatbot');
  }

  /// Load Family Billing List Data
  /// Method: GET | Path: /v1/family-billing | Status: mocked
  Future<ApiResponse> loadApiV1FamilyBillingList() async {
    return ref.read(apiClientProvider).get('/v1/family-billing');
  }

  /// Load Family Care Updates List Data
  /// Method: GET | Path: /v1/family-care-updates | Status: mocked
  Future<ApiResponse> loadApiV1FamilyCareUpdatesList() async {
    return ref.read(apiClientProvider).get('/v1/family-care-updates');
  }

  /// Create New Family Care Updates Record
  /// Method: POST | Path: /v1/family-care-updates | Status: mocked
  Future<ApiResponse> createApiV1FamilyCareUpdatesCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/family-care-updates', body: data);
  }

  /// Update Existing Family Care Updates Record
  /// Method: PATCH | Path: /v1/family-care-updates/:id | Status: mocked
  Future<ApiResponse> updateApiV1FamilyCareUpdatesUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/family-care-updates/$id', body: data);
  }

  /// Load Family Emergency Contacts List Data
  /// Method: GET | Path: /v1/family-emergency-contacts | Status: mocked
  Future<ApiResponse> loadApiV1FamilyEmergencyContactsList() async {
    return ref.read(apiClientProvider).get('/v1/family-emergency-contacts');
  }

  /// Load Family Loved One Schedule List Data
  /// Method: GET | Path: /v1/family-loved-one-schedule | Status: mocked
  Future<ApiResponse> loadApiV1FamilyLovedOneScheduleList() async {
    return ref.read(apiClientProvider).get('/v1/family-loved-one-schedule');
  }

  /// Load Family Profile List Data
  /// Method: GET | Path: /v1/family-profile | Status: mocked
  Future<ApiResponse> loadApiV1FamilyProfileList() async {
    return ref.read(apiClientProvider).get('/v1/family-profile');
  }

  /// Load Client Book Appointment List Data
  /// Method: GET | Path: /v1/client-book-appointment | Status: mocked
  Future<ApiResponse> loadApiV1ClientBookAppointmentList() async {
    return ref.read(apiClientProvider).get('/v1/client-book-appointment');
  }

  /// Load Client Care Team List Data
  /// Method: GET | Path: /v1/client-care-team | Status: mocked
  Future<ApiResponse> loadApiV1ClientCareTeamList() async {
    return ref.read(apiClientProvider).get('/v1/client-care-team');
  }

  /// Load Clients List Data
  /// Method: GET | Path: /v1/clients | Status: mocked
  Future<ApiResponse> loadApiV1ClientsList() async {
    return ref.read(apiClientProvider).get('/v1/clients');
  }

  /// Load Client My Appointments List Data
  /// Method: GET | Path: /v1/client-my-appointments | Status: mocked
  Future<ApiResponse> loadApiV1ClientMyAppointmentsList() async {
    return ref.read(apiClientProvider).get('/v1/client-my-appointments');
  }

  /// Load Client Payments List Data
  /// Method: GET | Path: /v1/client-payments | Status: mocked
  Future<ApiResponse> loadApiV1ClientPaymentsList() async {
    return ref.read(apiClientProvider).get('/v1/client-payments');
  }

  /// Load Client Profile List Data
  /// Method: GET | Path: /v1/client-profile | Status: mocked
  Future<ApiResponse> loadApiV1ClientProfileList() async {
    return ref.read(apiClientProvider).get('/v1/client-profile');
  }

  /// Load Client Treatment History List Data
  /// Method: GET | Path: /v1/client-treatment-history | Status: mocked
  Future<ApiResponse> loadApiV1ClientTreatmentHistoryList() async {
    return ref.read(apiClientProvider).get('/v1/client-treatment-history');
  }

  /// Load Family Member Billing List Data
  /// Method: GET | Path: /v1/family-member-billing | Status: mocked
  Future<ApiResponse> loadApiV1FamilyMemberBillingList() async {
    return ref.read(apiClientProvider).get('/v1/family-member-billing');
  }

  /// Load Family Member Care Updates List Data
  /// Method: GET | Path: /v1/family-member-care-updates | Status: mocked
  Future<ApiResponse> loadApiV1FamilyMemberCareUpdatesList() async {
    return ref.read(apiClientProvider).get('/v1/family-member-care-updates');
  }

  /// Create New Family Member Care Updates Record
  /// Method: POST | Path: /v1/family-member-care-updates | Status: mocked
  Future<ApiResponse> createApiV1FamilyMemberCareUpdatesCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/family-member-care-updates', body: data);
  }

  /// Update Existing Family Member Care Updates Record
  /// Method: PATCH | Path: /v1/family-member-care-updates/:id | Status: mocked
  Future<ApiResponse> updateApiV1FamilyMemberCareUpdatesUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/family-member-care-updates/$id', body: data);
  }

  /// Load Family Member Emergency Contacts List Data
  /// Method: GET | Path: /v1/family-member-emergency-contacts | Status: mocked
  Future<ApiResponse> loadApiV1FamilyMemberEmergencyContactsList() async {
    return ref.read(apiClientProvider).get('/v1/family-member-emergency-contacts');
  }

  /// Load Family Member Loved One Schedule List Data
  /// Method: GET | Path: /v1/family-member-loved-one-schedule | Status: mocked
  Future<ApiResponse> loadApiV1FamilyMemberLovedOneScheduleList() async {
    return ref.read(apiClientProvider).get('/v1/family-member-loved-one-schedule');
  }

  /// Load Family Member Profile List Data
  /// Method: GET | Path: /v1/family-member-profile | Status: mocked
  Future<ApiResponse> loadApiV1FamilyMemberProfileList() async {
    return ref.read(apiClientProvider).get('/v1/family-member-profile');
  }

  /// Load Unknown List Data
  /// Method: GET | Path: /v1/unknown | Status: mocked
  Future<ApiResponse> loadApiV1UnknownList() async {
    return ref.read(apiClientProvider).get('/v1/unknown');
  }

  /// Load Patient Book Appointment List Data
  /// Method: GET | Path: /v1/patient-book-appointment | Status: mocked
  Future<ApiResponse> loadApiV1PatientBookAppointmentList() async {
    return ref.read(apiClientProvider).get('/v1/patient-book-appointment');
  }

  /// Load Patient Care Team List Data
  /// Method: GET | Path: /v1/patient-care-team | Status: mocked
  Future<ApiResponse> loadApiV1PatientCareTeamList() async {
    return ref.read(apiClientProvider).get('/v1/patient-care-team');
  }

  /// Load Patient My Appointments List Data
  /// Method: GET | Path: /v1/patient-my-appointments | Status: mocked
  Future<ApiResponse> loadApiV1PatientMyAppointmentsList() async {
    return ref.read(apiClientProvider).get('/v1/patient-my-appointments');
  }

  /// Load Patient Payments List Data
  /// Method: GET | Path: /v1/patient-payments | Status: mocked
  Future<ApiResponse> loadApiV1PatientPaymentsList() async {
    return ref.read(apiClientProvider).get('/v1/patient-payments');
  }

  /// Load Patient Treatment History List Data
  /// Method: GET | Path: /v1/patient-treatment-history | Status: mocked
  Future<ApiResponse> loadApiV1PatientTreatmentHistoryList() async {
    return ref.read(apiClientProvider).get('/v1/patient-treatment-history');
  }

  /// Load Clinical Director List Data
  /// Method: GET | Path: /v1/clinical-director | Status: mocked
  Future<ApiResponse> loadApiV1ClinicalDirectorList() async {
    return ref.read(apiClientProvider).get('/v1/clinical-director');
  }

  /// Load Clinical Director Quality Metrics List Data
  /// Method: GET | Path: /v1/clinical-director-quality-metrics | Status: mocked
  Future<ApiResponse> loadApiV1ClinicalDirectorQualityMetricsList() async {
    return ref.read(apiClientProvider).get('/v1/clinical-director-quality-metrics');
  }

  /// Load Clinical Director Staffing List Data
  /// Method: GET | Path: /v1/clinical-director-staffing | Status: mocked
  Future<ApiResponse> loadApiV1ClinicalDirectorStaffingList() async {
    return ref.read(apiClientProvider).get('/v1/clinical-director-staffing');
  }

  /// Load Infection Control List Data
  /// Method: GET | Path: /v1/infection-control | Status: mocked
  Future<ApiResponse> loadApiV1InfectionControlList() async {
    return ref.read(apiClientProvider).get('/v1/infection-control');
  }

  /// Load Intake Coordinator Assessments List Data
  /// Method: GET | Path: /v1/intake-coordinator-assessments | Status: mocked
  Future<ApiResponse> loadApiV1IntakeCoordinatorAssessmentsList() async {
    return ref.read(apiClientProvider).get('/v1/intake-coordinator-assessments');
  }

  /// Create New Intake Coordinator Assessments Record
  /// Method: POST | Path: /v1/intake-coordinator-assessments | Status: mocked
  Future<ApiResponse> createApiV1IntakeCoordinatorAssessmentsCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/intake-coordinator-assessments', body: data);
  }

  /// Update Existing Intake Coordinator Assessments Record
  /// Method: PATCH | Path: /v1/intake-coordinator-assessments/:id | Status: mocked
  Future<ApiResponse> updateApiV1IntakeCoordinatorAssessmentsUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/intake-coordinator-assessments/$id', body: data);
  }

  /// Load Nurse List Data
  /// Method: GET | Path: /v1/nurse | Status: mocked
  Future<ApiResponse> loadApiV1NurseList() async {
    return ref.read(apiClientProvider).get('/v1/nurse');
  }

  /// Load Psw Check In List Data
  /// Method: GET | Path: /v1/psw-check-in | Status: mocked
  Future<ApiResponse> loadApiV1PswCheckInList() async {
    return ref.read(apiClientProvider).get('/v1/psw-check-in');
  }

  /// Load Psw Help Support List Data
  /// Method: GET | Path: /v1/psw-help-support | Status: mocked
  Future<ApiResponse> loadApiV1PswHelpSupportList() async {
    return ref.read(apiClientProvider).get('/v1/psw-help-support');
  }

  /// Create New Psw Help Support Record
  /// Method: POST | Path: /v1/psw-help-support | Status: mocked
  Future<ApiResponse> createApiV1PswHelpSupportCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/psw-help-support', body: data);
  }

  /// Update Existing Psw Help Support Record
  /// Method: PATCH | Path: /v1/psw-help-support/:id | Status: mocked
  Future<ApiResponse> updateApiV1PswHelpSupportUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/psw-help-support/$id', body: data);
  }

  /// Load Psw Notifications List Data
  /// Method: GET | Path: /v1/psw-notifications | Status: mocked
  Future<ApiResponse> loadApiV1PswNotificationsList() async {
    return ref.read(apiClientProvider).get('/v1/psw-notifications');
  }

  /// Load Psw Observation Vitals Log List Data
  /// Method: GET | Path: /v1/psw-observation-vitals-log | Status: mocked
  Future<ApiResponse> loadApiV1PswObservationVitalsLogList() async {
    return ref.read(apiClientProvider).get('/v1/psw-observation-vitals-log');
  }

  /// Load Psw Patient Profile List Data
  /// Method: GET | Path: /v1/psw-patient-profile | Status: mocked
  Future<ApiResponse> loadApiV1PswPatientProfileList() async {
    return ref.read(apiClientProvider).get('/v1/psw-patient-profile');
  }

  /// Load Psw Profile List Data
  /// Method: GET | Path: /v1/psw-profile | Status: mocked
  Future<ApiResponse> loadApiV1PswProfileList() async {
    return ref.read(apiClientProvider).get('/v1/psw-profile');
  }

  /// Create New Psw Profile Record
  /// Method: POST | Path: /v1/psw-profile | Status: mocked
  Future<ApiResponse> createApiV1PswProfileCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/psw-profile', body: data);
  }

  /// Update Existing Psw Profile Record
  /// Method: PATCH | Path: /v1/psw-profile/:id | Status: mocked
  Future<ApiResponse> updateApiV1PswProfileUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/psw-profile/$id', body: data);
  }

  /// Load Psw Reports List Data
  /// Method: GET | Path: /v1/psw-reports | Status: mocked
  Future<ApiResponse> loadApiV1PswReportsList() async {
    return ref.read(apiClientProvider).get('/v1/psw-reports');
  }

  /// Load Psw Schedule List Data
  /// Method: GET | Path: /v1/psw-schedule | Status: mocked
  Future<ApiResponse> loadApiV1PswScheduleList() async {
    return ref.read(apiClientProvider).get('/v1/psw-schedule');
  }

  /// Load Psw System Logs List Data
  /// Method: GET | Path: /v1/psw-system-logs | Status: mocked
  Future<ApiResponse> loadApiV1PswSystemLogsList() async {
    return ref.read(apiClientProvider).get('/v1/psw-system-logs');
  }

  /// Load Psw Visit Checklist List Data
  /// Method: GET | Path: /v1/psw-visit-checklist | Status: mocked
  Future<ApiResponse> loadApiV1PswVisitChecklistList() async {
    return ref.read(apiClientProvider).get('/v1/psw-visit-checklist');
  }

  /// Load Psw Care List Data
  /// Method: GET | Path: /v1/psw-care | Status: mocked
  Future<ApiResponse> loadApiV1PswCareList() async {
    return ref.read(apiClientProvider).get('/v1/psw-care');
  }

  /// Create New Psw Care Record
  /// Method: POST | Path: /v1/psw-care | Status: mocked
  Future<ApiResponse> createApiV1PswCareCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/psw-care', body: data);
  }

  /// Update Existing Psw Care Record
  /// Method: PATCH | Path: /v1/psw-care/:id | Status: mocked
  Future<ApiResponse> updateApiV1PswCareUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/psw-care/$id', body: data);
  }

  /// Load Psw Daily Notes List Data
  /// Method: GET | Path: /v1/psw-daily-notes | Status: mocked
  Future<ApiResponse> loadApiV1PswDailyNotesList() async {
    return ref.read(apiClientProvider).get('/v1/psw-daily-notes');
  }

  /// Create New Psw Daily Notes Record
  /// Method: POST | Path: /v1/psw-daily-notes | Status: mocked
  Future<ApiResponse> createApiV1PswDailyNotesCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/psw-daily-notes', body: data);
  }

  /// Update Existing Psw Daily Notes Record
  /// Method: PATCH | Path: /v1/psw-daily-notes/:id | Status: mocked
  Future<ApiResponse> updateApiV1PswDailyNotesUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/psw-daily-notes/$id', body: data);
  }

  /// Load Psw Messaging List Data
  /// Method: GET | Path: /v1/psw-messaging | Status: mocked
  Future<ApiResponse> loadApiV1PswMessagingList() async {
    return ref.read(apiClientProvider).get('/v1/psw-messaging');
  }

  /// Load Psw My Clients List Data
  /// Method: GET | Path: /v1/psw-my-clients | Status: mocked
  Future<ApiResponse> loadApiV1PswMyClientsList() async {
    return ref.read(apiClientProvider).get('/v1/psw-my-clients');
  }

  /// Load Psw Task List Data
  /// Method: GET | Path: /v1/psw-task | Status: mocked
  Future<ApiResponse> loadApiV1PswTaskList() async {
    return ref.read(apiClientProvider).get('/v1/psw-task');
  }

  /// Create New Psw Task Record
  /// Method: POST | Path: /v1/psw-task | Status: mocked
  Future<ApiResponse> createApiV1PswTaskCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/psw-task', body: data);
  }

  /// Update Existing Psw Task Record
  /// Method: PATCH | Path: /v1/psw-task/:id | Status: mocked
  Future<ApiResponse> updateApiV1PswTaskUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/psw-task/$id', body: data);
  }

  /// Load Rn Charting List Data
  /// Method: GET | Path: /v1/rn-charting | Status: mocked
  Future<ApiResponse> loadApiV1RnChartingList() async {
    return ref.read(apiClientProvider).get('/v1/rn-charting');
  }

  /// Create New Rn Charting Record
  /// Method: POST | Path: /v1/rn-charting | Status: mocked
  Future<ApiResponse> createApiV1RnChartingCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/rn-charting', body: data);
  }

  /// Update Existing Rn Charting Record
  /// Method: PATCH | Path: /v1/rn-charting/:id | Status: mocked
  Future<ApiResponse> updateApiV1RnChartingUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/rn-charting/$id', body: data);
  }

  /// Load Rn Messaging List Data
  /// Method: GET | Path: /v1/rn-messaging | Status: mocked
  Future<ApiResponse> loadApiV1RnMessagingList() async {
    return ref.read(apiClientProvider).get('/v1/rn-messaging');
  }

  /// Load Clinic History Logs List Data
  /// Method: GET | Path: /v1/clinic-history-logs | Status: mocked
  Future<ApiResponse> loadApiV1ClinicHistoryLogsList() async {
    return ref.read(apiClientProvider).get('/v1/clinic-history-logs');
  }

  /// Load Clinic Incident Report List Data
  /// Method: GET | Path: /v1/clinic-incident-report | Status: mocked
  Future<ApiResponse> loadApiV1ClinicIncidentReportList() async {
    return ref.read(apiClientProvider).get('/v1/clinic-incident-report');
  }

  /// Load Ceo Alerts And Risks List Data
  /// Method: GET | Path: /v1/ceo-alerts-and-risks | Status: mocked
  Future<ApiResponse> loadApiV1CeoAlertsAndRisksList() async {
    return ref.read(apiClientProvider).get('/v1/ceo-alerts-and-risks');
  }

  /// Load Ceo Approvals List Data
  /// Method: GET | Path: /v1/ceo-approvals | Status: mocked
  Future<ApiResponse> loadApiV1CeoApprovalsList() async {
    return ref.read(apiClientProvider).get('/v1/ceo-approvals');
  }

  /// Load Ceo List Data
  /// Method: GET | Path: /v1/ceo | Status: mocked
  Future<ApiResponse> loadApiV1CeoList() async {
    return ref.read(apiClientProvider).get('/v1/ceo');
  }

  /// Load Ceo Enterprise List Data
  /// Method: GET | Path: /v1/ceo-enterprise | Status: mocked
  Future<ApiResponse> loadApiV1CeoEnterpriseList() async {
    return ref.read(apiClientProvider).get('/v1/ceo-enterprise');
  }

  /// Load Ceo Franchise List Data
  /// Method: GET | Path: /v1/ceo-franchise | Status: mocked
  Future<ApiResponse> loadApiV1CeoFranchiseList() async {
    return ref.read(apiClientProvider).get('/v1/ceo-franchise');
  }

  /// Load Ceo Growth Pipeline List Data
  /// Method: GET | Path: /v1/ceo-growth-pipeline | Status: mocked
  Future<ApiResponse> loadApiV1CeoGrowthPipelineList() async {
    return ref.read(apiClientProvider).get('/v1/ceo-growth-pipeline');
  }

  /// Load Ceo Leadership Reports List Data
  /// Method: GET | Path: /v1/ceo-leadership-reports | Status: mocked
  Future<ApiResponse> loadApiV1CeoLeadershipReportsList() async {
    return ref.read(apiClientProvider).get('/v1/ceo-leadership-reports');
  }

  /// Load Ceo Organization Map List Data
  /// Method: GET | Path: /v1/ceo-organization-map | Status: mocked
  Future<ApiResponse> loadApiV1CeoOrganizationMapList() async {
    return ref.read(apiClientProvider).get('/v1/ceo-organization-map');
  }

  /// Load Ceo Region Performance List Data
  /// Method: GET | Path: /v1/ceo-region-performance | Status: mocked
  Future<ApiResponse> loadApiV1CeoRegionPerformanceList() async {
    return ref.read(apiClientProvider).get('/v1/ceo-region-performance');
  }

  /// Create New Ceo Region Performance Record
  /// Method: POST | Path: /v1/ceo-region-performance | Status: mocked
  Future<ApiResponse> createApiV1CeoRegionPerformanceCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/ceo-region-performance', body: data);
  }

  /// Update Existing Ceo Region Performance Record
  /// Method: PATCH | Path: /v1/ceo-region-performance/:id | Status: mocked
  Future<ApiResponse> updateApiV1CeoRegionPerformanceUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/ceo-region-performance/$id', body: data);
  }

  /// Load Ceo Reports List Data
  /// Method: GET | Path: /v1/ceo-reports | Status: mocked
  Future<ApiResponse> loadApiV1CeoReportsList() async {
    return ref.read(apiClientProvider).get('/v1/ceo-reports');
  }

  /// Load Ceo Revenue Summary List Data
  /// Method: GET | Path: /v1/ceo-revenue-summary | Status: mocked
  Future<ApiResponse> loadApiV1CeoRevenueSummaryList() async {
    return ref.read(apiClientProvider).get('/v1/ceo-revenue-summary');
  }

  /// Load Ceo Strategic Kpis List Data
  /// Method: GET | Path: /v1/ceo-strategic-kpis | Status: mocked
  Future<ApiResponse> loadApiV1CeoStrategicKpisList() async {
    return ref.read(apiClientProvider).get('/v1/ceo-strategic-kpis');
  }

  /// Load Cfo Accounts Payable List Data
  /// Method: GET | Path: /v1/cfo-accounts-payable | Status: mocked
  Future<ApiResponse> loadApiV1CfoAccountsPayableList() async {
    return ref.read(apiClientProvider).get('/v1/cfo-accounts-payable');
  }

  /// Load Cfo Accounts Receivable List Data
  /// Method: GET | Path: /v1/cfo-accounts-receivable | Status: mocked
  Future<ApiResponse> loadApiV1CfoAccountsReceivableList() async {
    return ref.read(apiClientProvider).get('/v1/cfo-accounts-receivable');
  }

  /// Load Cfo Financial List Data
  /// Method: GET | Path: /v1/cfo-financial | Status: mocked
  Future<ApiResponse> loadApiV1CfoFinancialList() async {
    return ref.read(apiClientProvider).get('/v1/cfo-financial');
  }

  /// Load Cfo Franchise Financials List Data
  /// Method: GET | Path: /v1/cfo-franchise-financials | Status: mocked
  Future<ApiResponse> loadApiV1CfoFranchiseFinancialsList() async {
    return ref.read(apiClientProvider).get('/v1/cfo-franchise-financials');
  }

  /// Load Cfo Reports List Data
  /// Method: GET | Path: /v1/cfo-reports | Status: mocked
  Future<ApiResponse> loadApiV1CfoReportsList() async {
    return ref.read(apiClientProvider).get('/v1/cfo-reports');
  }

  /// Load Cfo Tax And Remittance List Data
  /// Method: GET | Path: /v1/cfo-tax-and-remittance | Status: mocked
  Future<ApiResponse> loadApiV1CfoTaxAndRemittanceList() async {
    return ref.read(apiClientProvider).get('/v1/cfo-tax-and-remittance');
  }

  /// Load Audits List Data
  /// Method: GET | Path: /v1/audits | Status: mocked
  Future<ApiResponse> loadApiV1AuditsList() async {
    return ref.read(apiClientProvider).get('/v1/audits');
  }

  /// Load Compliance Cases List Data
  /// Method: GET | Path: /v1/compliance-cases | Status: mocked
  Future<ApiResponse> loadApiV1ComplianceCasesList() async {
    return ref.read(apiClientProvider).get('/v1/compliance-cases');
  }

  /// Load Compliance Reports List Data
  /// Method: GET | Path: /v1/compliance-reports | Status: mocked
  Future<ApiResponse> loadApiV1ComplianceReportsList() async {
    return ref.read(apiClientProvider).get('/v1/compliance-reports');
  }

  /// Load Corrective Actions List Data
  /// Method: GET | Path: /v1/corrective-actions | Status: mocked
  Future<ApiResponse> loadApiV1CorrectiveActionsList() async {
    return ref.read(apiClientProvider).get('/v1/corrective-actions');
  }

  /// Load Credential Tracking List Data
  /// Method: GET | Path: /v1/credential-tracking | Status: mocked
  Future<ApiResponse> loadApiV1CredentialTrackingList() async {
    return ref.read(apiClientProvider).get('/v1/credential-tracking');
  }

  /// Load Document Expiry List Data
  /// Method: GET | Path: /v1/document-expiry | Status: mocked
  Future<ApiResponse> loadApiV1DocumentExpiryList() async {
    return ref.read(apiClientProvider).get('/v1/document-expiry');
  }

  /// Load Policies List Data
  /// Method: GET | Path: /v1/policies | Status: mocked
  Future<ApiResponse> loadApiV1PoliciesList() async {
    return ref.read(apiClientProvider).get('/v1/policies');
  }

  /// Load Risk Register List Data
  /// Method: GET | Path: /v1/risk-register | Status: mocked
  Future<ApiResponse> loadApiV1RiskRegisterList() async {
    return ref.read(apiClientProvider).get('/v1/risk-register');
  }

  /// Create New Risk Register Record
  /// Method: POST | Path: /v1/risk-register | Status: mocked
  Future<ApiResponse> register(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/risk-register', body: data);
  }

  /// Update Existing Risk Register Record
  /// Method: PATCH | Path: /v1/risk-register/:id | Status: mocked
  Future<ApiResponse> updateApiV1RiskRegisterUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/risk-register/$id', body: data);
  }

  /// Load Single Risk Register Details
  /// Method: GET | Path: /v1/risk-register/:id | Status: mocked
  Future<ApiResponse> loadApiV1RiskRegisterDetail(String id) async {
    return ref.read(apiClientProvider).get('/v1/risk-register/$id');
  }

  /// Delete Risk Register Record
  /// Method: DELETE | Path: /v1/risk-register/:id | Status: mocked
  Future<ApiResponse> deleteApiV1RiskRegisterDelete(String id) async {
    return ref.read(apiClientProvider).delete('/v1/risk-register/$id');
  }

  /// Load Training Compliance List Data
  /// Method: GET | Path: /v1/training-compliance | Status: mocked
  Future<ApiResponse> loadApiV1TrainingComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/training-compliance');
  }

  /// Load Coo Branch Operations List Data
  /// Method: GET | Path: /v1/coo-branch-operations | Status: mocked
  Future<ApiResponse> loadApiV1CooBranchOperationsList() async {
    return ref.read(apiClientProvider).get('/v1/coo-branch-operations');
  }

  /// Load Coo Issue Escalations List Data
  /// Method: GET | Path: /v1/coo-issue-escalations | Status: mocked
  Future<ApiResponse> loadApiV1CooIssueEscalationsList() async {
    return ref.read(apiClientProvider).get('/v1/coo-issue-escalations');
  }

  /// Load Coo Reports List Data
  /// Method: GET | Path: /v1/coo-reports | Status: mocked
  Future<ApiResponse> loadApiV1CooReportsList() async {
    return ref.read(apiClientProvider).get('/v1/coo-reports');
  }

  /// Load Coo Service Delivery List Data
  /// Method: GET | Path: /v1/coo-service-delivery | Status: mocked
  Future<ApiResponse> loadApiV1CooServiceDeliveryList() async {
    return ref.read(apiClientProvider).get('/v1/coo-service-delivery');
  }

  /// Load Coo Staffing Efficiency List Data
  /// Method: GET | Path: /v1/coo-staffing-efficiency | Status: mocked
  Future<ApiResponse> loadApiV1CooStaffingEfficiencyList() async {
    return ref.read(apiClientProvider).get('/v1/coo-staffing-efficiency');
  }

  /// Load Coo Workflow Performance List Data
  /// Method: GET | Path: /v1/coo-workflow-performance | Status: mocked
  Future<ApiResponse> loadApiV1CooWorkflowPerformanceList() async {
    return ref.read(apiClientProvider).get('/v1/coo-workflow-performance');
  }

  /// Create New Coo Workflow Performance Record
  /// Method: POST | Path: /v1/coo-workflow-performance | Status: mocked
  Future<ApiResponse> createApiV1CooWorkflowPerformanceCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/coo-workflow-performance', body: data);
  }

  /// Update Existing Coo Workflow Performance Record
  /// Method: PATCH | Path: /v1/coo-workflow-performance/:id | Status: mocked
  Future<ApiResponse> updateApiV1CooWorkflowPerformanceUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/coo-workflow-performance/$id', body: data);
  }

  /// Load Compliance Manager Audits List Data
  /// Method: GET | Path: /v1/compliance-manager-audits | Status: mocked
  Future<ApiResponse> loadApiV1ComplianceManagerAuditsList() async {
    return ref.read(apiClientProvider).get('/v1/compliance-manager-audits');
  }

  /// Load Compliance Manager Compliance Cases List Data
  /// Method: GET | Path: /v1/compliance-manager-compliance-cases | Status: mocked
  Future<ApiResponse> loadApiV1ComplianceManagerComplianceCasesList() async {
    return ref.read(apiClientProvider).get('/v1/compliance-manager-compliance-cases');
  }

  /// Load Compliance Manager Corrective Actions List Data
  /// Method: GET | Path: /v1/compliance-manager-corrective-actions | Status: mocked
  Future<ApiResponse> loadApiV1ComplianceManagerCorrectiveActionsList() async {
    return ref.read(apiClientProvider).get('/v1/compliance-manager-corrective-actions');
  }

  /// Load Compliance Manager Credential Tracking List Data
  /// Method: GET | Path: /v1/compliance-manager-credential-tracking | Status: mocked
  Future<ApiResponse> loadApiV1ComplianceManagerCredentialTrackingList() async {
    return ref.read(apiClientProvider).get('/v1/compliance-manager-credential-tracking');
  }

  /// Load Compliance Manager Document Expiry List Data
  /// Method: GET | Path: /v1/compliance-manager-document-expiry | Status: mocked
  Future<ApiResponse> loadApiV1ComplianceManagerDocumentExpiryList() async {
    return ref.read(apiClientProvider).get('/v1/compliance-manager-document-expiry');
  }

  /// Load Compliance Manager Incident Review List Data
  /// Method: GET | Path: /v1/compliance-manager-incident-review | Status: mocked
  Future<ApiResponse> loadApiV1ComplianceManagerIncidentReviewList() async {
    return ref.read(apiClientProvider).get('/v1/compliance-manager-incident-review');
  }

  /// Load Compliance Manager Policies List Data
  /// Method: GET | Path: /v1/compliance-manager-policies | Status: mocked
  Future<ApiResponse> loadApiV1ComplianceManagerPoliciesList() async {
    return ref.read(apiClientProvider).get('/v1/compliance-manager-policies');
  }

  /// Load Compliance Manager Reports List Data
  /// Method: GET | Path: /v1/compliance-manager-reports | Status: mocked
  Future<ApiResponse> loadApiV1ComplianceManagerReportsList() async {
    return ref.read(apiClientProvider).get('/v1/compliance-manager-reports');
  }

  /// Load Compliance Manager Risk Register List Data
  /// Method: GET | Path: /v1/compliance-manager-risk-register | Status: mocked
  Future<ApiResponse> loadApiV1ComplianceManagerRiskRegisterList() async {
    return ref.read(apiClientProvider).get('/v1/compliance-manager-risk-register');
  }

  /// Create New Compliance Manager Risk Register Record
  /// Method: POST | Path: /v1/compliance-manager-risk-register | Status: mocked
  Future<ApiResponse> register(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/compliance-manager-risk-register', body: data);
  }

  /// Update Existing Compliance Manager Risk Register Record
  /// Method: PATCH | Path: /v1/compliance-manager-risk-register/:id | Status: mocked
  Future<ApiResponse> updateApiV1ComplianceManagerRiskRegisterUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/compliance-manager-risk-register/$id', body: data);
  }

  /// Load Single Compliance Manager Risk Register Details
  /// Method: GET | Path: /v1/compliance-manager-risk-register/:id | Status: mocked
  Future<ApiResponse> loadApiV1ComplianceManagerRiskRegisterDetail(String id) async {
    return ref.read(apiClientProvider).get('/v1/compliance-manager-risk-register/$id');
  }

  /// Delete Compliance Manager Risk Register Record
  /// Method: DELETE | Path: /v1/compliance-manager-risk-register/:id | Status: mocked
  Future<ApiResponse> deleteApiV1ComplianceManagerRiskRegisterDelete(String id) async {
    return ref.read(apiClientProvider).delete('/v1/compliance-manager-risk-register/$id');
  }

  /// Load Compliance Manager Training Compliance List Data
  /// Method: GET | Path: /v1/compliance-manager-training-compliance | Status: mocked
  Future<ApiResponse> loadApiV1ComplianceManagerTrainingComplianceList() async {
    return ref.read(apiClientProvider).get('/v1/compliance-manager-training-compliance');
  }

  /// Load Cto Access Control List Data
  /// Method: GET | Path: /v1/cto-access-control | Status: mocked
  Future<ApiResponse> loadApiV1CtoAccessControlList() async {
    return ref.read(apiClientProvider).get('/v1/cto-access-control');
  }

  /// Load Cto Api Monitoring List Data
  /// Method: GET | Path: /v1/cto-api-monitoring | Status: mocked
  Future<ApiResponse> loadApiV1CtoApiMonitoringList() async {
    return ref.read(apiClientProvider).get('/v1/cto-api-monitoring');
  }

  /// Load Cto Audit Logs List Data
  /// Method: GET | Path: /v1/cto-audit-logs | Status: mocked
  Future<ApiResponse> loadApiV1CtoAuditLogsList() async {
    return ref.read(apiClientProvider).get('/v1/cto-audit-logs');
  }

  /// Load Cto Feature Adoption List Data
  /// Method: GET | Path: /v1/cto-feature-adoption | Status: mocked
  Future<ApiResponse> loadApiV1CtoFeatureAdoptionList() async {
    return ref.read(apiClientProvider).get('/v1/cto-feature-adoption');
  }

  /// Load Cto Infrastructure List Data
  /// Method: GET | Path: /v1/cto-infrastructure | Status: mocked
  Future<ApiResponse> loadApiV1CtoInfrastructureList() async {
    return ref.read(apiClientProvider).get('/v1/cto-infrastructure');
  }

  /// Load Cto Integrations List Data
  /// Method: GET | Path: /v1/cto-integrations | Status: mocked
  Future<ApiResponse> loadApiV1CtoIntegrationsList() async {
    return ref.read(apiClientProvider).get('/v1/cto-integrations');
  }

  /// Load Cto Issue Tracking List Data
  /// Method: GET | Path: /v1/cto-issue-tracking | Status: mocked
  Future<ApiResponse> loadApiV1CtoIssueTrackingList() async {
    return ref.read(apiClientProvider).get('/v1/cto-issue-tracking');
  }

  /// Load Cto Platform Usage List Data
  /// Method: GET | Path: /v1/cto-platform-usage | Status: mocked
  Future<ApiResponse> loadApiV1CtoPlatformUsageList() async {
    return ref.read(apiClientProvider).get('/v1/cto-platform-usage');
  }

  /// Create New Cto Platform Usage Record
  /// Method: POST | Path: /v1/cto-platform-usage | Status: mocked
  Future<ApiResponse> createApiV1CtoPlatformUsageCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/cto-platform-usage', body: data);
  }

  /// Update Existing Cto Platform Usage Record
  /// Method: PATCH | Path: /v1/cto-platform-usage/:id | Status: mocked
  Future<ApiResponse> updateApiV1CtoPlatformUsageUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/cto-platform-usage/$id', body: data);
  }

  /// Load Cto Release Management List Data
  /// Method: GET | Path: /v1/cto-release-management | Status: mocked
  Future<ApiResponse> loadApiV1CtoReleaseManagementList() async {
    return ref.read(apiClientProvider).get('/v1/cto-release-management');
  }

  /// Load Cto Reports List Data
  /// Method: GET | Path: /v1/cto-reports | Status: mocked
  Future<ApiResponse> loadApiV1CtoReportsList() async {
    return ref.read(apiClientProvider).get('/v1/cto-reports');
  }

  /// Load Cto System Health List Data
  /// Method: GET | Path: /v1/cto-system-health | Status: mocked
  Future<ApiResponse> loadApiV1CtoSystemHealthList() async {
    return ref.read(apiClientProvider).get('/v1/cto-system-health');
  }

  /// Load Cto System Verification List Data
  /// Method: GET | Path: /v1/cto-system-verification | Status: mocked
  Future<ApiResponse> loadApiV1CtoSystemVerificationList() async {
    return ref.read(apiClientProvider).get('/v1/cto-system-verification');
  }

  /// Load Cto Verification Hub List Data
  /// Method: GET | Path: /v1/cto-verification-hub | Status: mocked
  Future<ApiResponse> loadApiV1CtoVerificationHubList() async {
    return ref.read(apiClientProvider).get('/v1/cto-verification-hub');
  }

  /// Load Finance Director Cashflow List Data
  /// Method: GET | Path: /v1/finance-director-cashflow | Status: mocked
  Future<ApiResponse> loadApiV1FinanceDirectorCashflowList() async {
    return ref.read(apiClientProvider).get('/v1/finance-director-cashflow');
  }

  /// Load It Admin List Data
  /// Method: GET | Path: /v1/it-admin | Status: mocked
  Future<ApiResponse> loadApiV1ItAdminList() async {
    return ref.read(apiClientProvider).get('/v1/it-admin');
  }

  /// Load Training Director Assessments List Data
  /// Method: GET | Path: /v1/training-director-assessments | Status: mocked
  Future<ApiResponse> loadApiV1TrainingDirectorAssessmentsList() async {
    return ref.read(apiClientProvider).get('/v1/training-director-assessments');
  }

  /// Load Training Director Certificates List Data
  /// Method: GET | Path: /v1/training-director-certificates | Status: mocked
  Future<ApiResponse> loadApiV1TrainingDirectorCertificatesList() async {
    return ref.read(apiClientProvider).get('/v1/training-director-certificates');
  }

  /// Load Training Director Certifications List Data
  /// Method: GET | Path: /v1/training-director-certifications | Status: mocked
  Future<ApiResponse> loadApiV1TrainingDirectorCertificationsList() async {
    return ref.read(apiClientProvider).get('/v1/training-director-certifications');
  }

  /// Load Training Director Compliance Training List Data
  /// Method: GET | Path: /v1/training-director-compliance-training | Status: mocked
  Future<ApiResponse> loadApiV1TrainingDirectorComplianceTrainingList() async {
    return ref.read(apiClientProvider).get('/v1/training-director-compliance-training');
  }

  /// Load Training Director Course Architect List Data
  /// Method: GET | Path: /v1/training-director-course-architect | Status: mocked
  Future<ApiResponse> loadApiV1TrainingDirectorCourseArchitectList() async {
    return ref.read(apiClientProvider).get('/v1/training-director-course-architect');
  }

  /// Load Training Director Course Library List Data
  /// Method: GET | Path: /v1/training-director-course-library | Status: mocked
  Future<ApiResponse> loadApiV1TrainingDirectorCourseLibraryList() async {
    return ref.read(apiClientProvider).get('/v1/training-director-course-library');
  }

  /// Load Training Director Hub List Data
  /// Method: GET | Path: /v1/training-director-hub | Status: mocked
  Future<ApiResponse> loadApiV1TrainingDirectorHubList() async {
    return ref.read(apiClientProvider).get('/v1/training-director-hub');
  }

  /// Load Training Director Reports List Data
  /// Method: GET | Path: /v1/training-director-reports | Status: mocked
  Future<ApiResponse> loadApiV1TrainingDirectorReportsList() async {
    return ref.read(apiClientProvider).get('/v1/training-director-reports');
  }

  /// Load Training Director Staff Training Matrix List Data
  /// Method: GET | Path: /v1/training-director-staff-training-matrix | Status: mocked
  Future<ApiResponse> loadApiV1TrainingDirectorStaffTrainingMatrixList() async {
    return ref.read(apiClientProvider).get('/v1/training-director-staff-training-matrix');
  }

  /// Load Training Director Trainer Assignments List Data
  /// Method: GET | Path: /v1/training-director-trainer-assignments | Status: mocked
  Future<ApiResponse> loadApiV1TrainingDirectorTrainerAssignmentsList() async {
    return ref.read(apiClientProvider).get('/v1/training-director-trainer-assignments');
  }

  /// Load Training Director Training Programs List Data
  /// Method: GET | Path: /v1/training-director-training-programs | Status: mocked
  Future<ApiResponse> loadApiV1TrainingDirectorTrainingProgramsList() async {
    return ref.read(apiClientProvider).get('/v1/training-director-training-programs');
  }

  /// Load Assessments List Data
  /// Method: GET | Path: /v1/assessments | Status: mocked
  Future<ApiResponse> loadApiV1AssessmentsList() async {
    return ref.read(apiClientProvider).get('/v1/assessments');
  }

  /// Load Certificates List Data
  /// Method: GET | Path: /v1/certificates | Status: mocked
  Future<ApiResponse> loadApiV1CertificatesList() async {
    return ref.read(apiClientProvider).get('/v1/certificates');
  }

  /// Load Certifications List Data
  /// Method: GET | Path: /v1/certifications | Status: mocked
  Future<ApiResponse> loadApiV1CertificationsList() async {
    return ref.read(apiClientProvider).get('/v1/certifications');
  }

  /// Load Compliance Training List Data
  /// Method: GET | Path: /v1/compliance-training | Status: mocked
  Future<ApiResponse> loadApiV1ComplianceTrainingList() async {
    return ref.read(apiClientProvider).get('/v1/compliance-training');
  }

  /// Load Course Library List Data
  /// Method: GET | Path: /v1/course-library | Status: mocked
  Future<ApiResponse> loadApiV1CourseLibraryList() async {
    return ref.read(apiClientProvider).get('/v1/course-library');
  }

  /// Load Staff Training Matrix List Data
  /// Method: GET | Path: /v1/staff-training-matrix | Status: mocked
  Future<ApiResponse> loadApiV1StaffTrainingMatrixList() async {
    return ref.read(apiClientProvider).get('/v1/staff-training-matrix');
  }

  /// Load Trainer Assignments List Data
  /// Method: GET | Path: /v1/trainer-assignments | Status: mocked
  Future<ApiResponse> loadApiV1TrainerAssignmentsList() async {
    return ref.read(apiClientProvider).get('/v1/trainer-assignments');
  }

  /// Load Training Analytics List Data
  /// Method: GET | Path: /v1/training-analytics | Status: mocked
  Future<ApiResponse> loadApiV1TrainingAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/training-analytics');
  }

  /// Load Training Programs List Data
  /// Method: GET | Path: /v1/training-programs | Status: mocked
  Future<ApiResponse> loadApiV1TrainingProgramsList() async {
    return ref.read(apiClientProvider).get('/v1/training-programs');
  }

  /// Load Training Reports List Data
  /// Method: GET | Path: /v1/training-reports | Status: mocked
  Future<ApiResponse> loadApiV1TrainingReportsList() async {
    return ref.read(apiClientProvider).get('/v1/training-reports');
  }

  /// Load Admin Claims List Data
  /// Method: GET | Path: /v1/admin-claims | Status: mocked
  Future<ApiResponse> loadApiV1AdminClaimsList() async {
    return ref.read(apiClientProvider).get('/v1/admin-claims');
  }

  /// Load Admin List Data
  /// Method: GET | Path: /v1/admin | Status: mocked
  Future<ApiResponse> loadApiV1AdminList() async {
    return ref.read(apiClientProvider).get('/v1/admin');
  }

  /// Load Admin Invoices List Data
  /// Method: GET | Path: /v1/admin-invoices | Status: mocked
  Future<ApiResponse> loadApiV1AdminInvoicesList() async {
    return ref.read(apiClientProvider).get('/v1/admin-invoices');
  }

  /// Load Admin Outstanding Balances List Data
  /// Method: GET | Path: /v1/admin-outstanding-balances | Status: mocked
  Future<ApiResponse> loadApiV1AdminOutstandingBalancesList() async {
    return ref.read(apiClientProvider).get('/v1/admin-outstanding-balances');
  }

  /// Load Admin Payments List Data
  /// Method: GET | Path: /v1/admin-payments | Status: mocked
  Future<ApiResponse> loadApiV1AdminPaymentsList() async {
    return ref.read(apiClientProvider).get('/v1/admin-payments');
  }

  /// Load Admin Reconciliation List Data
  /// Method: GET | Path: /v1/admin-reconciliation | Status: mocked
  Future<ApiResponse> loadApiV1AdminReconciliationList() async {
    return ref.read(apiClientProvider).get('/v1/admin-reconciliation');
  }

  /// Load Admin Refunds List Data
  /// Method: GET | Path: /v1/admin-refunds | Status: mocked
  Future<ApiResponse> loadApiV1AdminRefundsList() async {
    return ref.read(apiClientProvider).get('/v1/admin-refunds');
  }

  /// Load Admin Reports List Data
  /// Method: GET | Path: /v1/admin-reports | Status: mocked
  Future<ApiResponse> loadApiV1AdminReportsList() async {
    return ref.read(apiClientProvider).get('/v1/admin-reports');
  }

  /// Load Billing Admin Invoices List Data
  /// Method: GET | Path: /v1/billing-admin-invoices | Status: mocked
  Future<ApiResponse> loadApiV1BillingAdminInvoicesList() async {
    return ref.read(apiClientProvider).get('/v1/billing-admin-invoices');
  }

  /// Load Franchise Owner List Data
  /// Method: GET | Path: /v1/franchise-owner | Status: mocked
  Future<ApiResponse> loadApiV1FranchiseOwnerList() async {
    return ref.read(apiClientProvider).get('/v1/franchise-owner');
  }

  /// Load Franchise Owner Financial Snapshot List Data
  /// Method: GET | Path: /v1/franchise-owner-financial-snapshot | Status: mocked
  Future<ApiResponse> loadApiV1FranchiseOwnerFinancialSnapshotList() async {
    return ref.read(apiClientProvider).get('/v1/franchise-owner-financial-snapshot');
  }

  /// Load Franchise Owner Hiring List Data
  /// Method: GET | Path: /v1/franchise-owner-hiring | Status: mocked
  Future<ApiResponse> loadApiV1FranchiseOwnerHiringList() async {
    return ref.read(apiClientProvider).get('/v1/franchise-owner-hiring');
  }

  /// Load Hr Hiring Reports List Data
  /// Method: GET | Path: /v1/hr-hiring-reports | Status: mocked
  Future<ApiResponse> loadApiV1HrHiringReportsList() async {
    return ref.read(apiClientProvider).get('/v1/hr-hiring-reports');
  }

  /// Load Hr Hiring Staff Documents List Data
  /// Method: GET | Path: /v1/hr-hiring-staff-documents | Status: mocked
  Future<ApiResponse> loadApiV1HrHiringStaffDocumentsList() async {
    return ref.read(apiClientProvider).get('/v1/hr-hiring-staff-documents');
  }

  /// Load Hr Hiring Training Status List Data
  /// Method: GET | Path: /v1/hr-hiring-training-status | Status: mocked
  Future<ApiResponse> loadApiV1HrHiringTrainingStatusList() async {
    return ref.read(apiClientProvider).get('/v1/hr-hiring-training-status');
  }

  /// Load Marketing Manager Campaigns List Data
  /// Method: GET | Path: /v1/marketing-manager-campaigns | Status: mocked
  Future<ApiResponse> loadApiV1MarketingManagerCampaignsList() async {
    return ref.read(apiClientProvider).get('/v1/marketing-manager-campaigns');
  }

  /// Load Marketing Manager List Data
  /// Method: GET | Path: /v1/marketing-manager | Status: mocked
  Future<ApiResponse> loadApiV1MarketingManagerList() async {
    return ref.read(apiClientProvider).get('/v1/marketing-manager');
  }

  /// Load Operations Manager Attendance List Data
  /// Method: GET | Path: /v1/operations-manager-attendance | Status: mocked
  Future<ApiResponse> loadApiV1OperationsManagerAttendanceList() async {
    return ref.read(apiClientProvider).get('/v1/operations-manager-attendance');
  }

  /// Load Operations Manager Daily Operations List Data
  /// Method: GET | Path: /v1/operations-manager-daily-operations | Status: mocked
  Future<ApiResponse> loadApiV1OperationsManagerDailyOperationsList() async {
    return ref.read(apiClientProvider).get('/v1/operations-manager-daily-operations');
  }

  /// Load Operations Manager Issues List Data
  /// Method: GET | Path: /v1/operations-manager-issues | Status: mocked
  Future<ApiResponse> loadApiV1OperationsManagerIssuesList() async {
    return ref.read(apiClientProvider).get('/v1/operations-manager-issues');
  }

  /// Load Operations Manager Reports List Data
  /// Method: GET | Path: /v1/operations-manager-reports | Status: mocked
  Future<ApiResponse> loadApiV1OperationsManagerReportsList() async {
    return ref.read(apiClientProvider).get('/v1/operations-manager-reports');
  }

  /// Load Operations Manager Schedule List Data
  /// Method: GET | Path: /v1/operations-manager-schedule | Status: mocked
  Future<ApiResponse> loadApiV1OperationsManagerScheduleList() async {
    return ref.read(apiClientProvider).get('/v1/operations-manager-schedule');
  }

  /// Load Operations Manager Service Quality List Data
  /// Method: GET | Path: /v1/operations-manager-service-quality | Status: mocked
  Future<ApiResponse> loadApiV1OperationsManagerServiceQualityList() async {
    return ref.read(apiClientProvider).get('/v1/operations-manager-service-quality');
  }

  /// Load Operations Manager Shifts List Data
  /// Method: GET | Path: /v1/operations-manager-shifts | Status: mocked
  Future<ApiResponse> loadApiV1OperationsManagerShiftsList() async {
    return ref.read(apiClientProvider).get('/v1/operations-manager-shifts');
  }

  /// Load Operations Manager Staff Coordination List Data
  /// Method: GET | Path: /v1/operations-manager-staff-coordination | Status: mocked
  Future<ApiResponse> loadApiV1OperationsManagerStaffCoordinationList() async {
    return ref.read(apiClientProvider).get('/v1/operations-manager-staff-coordination');
  }

  /// Load Regional Manager Branch Comparison List Data
  /// Method: GET | Path: /v1/regional-manager-branch-comparison | Status: mocked
  Future<ApiResponse> loadApiV1RegionalManagerBranchComparisonList() async {
    return ref.read(apiClientProvider).get('/v1/regional-manager-branch-comparison');
  }

  /// Load Regional Manager List Data
  /// Method: GET | Path: /v1/regional-manager | Status: mocked
  Future<ApiResponse> loadApiV1RegionalManagerList() async {
    return ref.read(apiClientProvider).get('/v1/regional-manager');
  }

  /// Load Scheduler Coordinator Appointment Calendar List Data
  /// Method: GET | Path: /v1/scheduler-coordinator-appointment-calendar | Status: mocked
  Future<ApiResponse> loadApiV1SchedulerCoordinatorAppointmentCalendarList() async {
    return ref.read(apiClientProvider).get('/v1/scheduler-coordinator-appointment-calendar');
  }

  /// Load Scheduler Coordinator Assignments List Data
  /// Method: GET | Path: /v1/scheduler-coordinator-assignments | Status: mocked
  Future<ApiResponse> loadApiV1SchedulerCoordinatorAssignmentsList() async {
    return ref.read(apiClientProvider).get('/v1/scheduler-coordinator-assignments');
  }

  /// Load Scheduler Coordinator Booking Requests List Data
  /// Method: GET | Path: /v1/scheduler-coordinator-booking-requests | Status: mocked
  Future<ApiResponse> loadApiV1SchedulerCoordinatorBookingRequestsList() async {
    return ref.read(apiClientProvider).get('/v1/scheduler-coordinator-booking-requests');
  }

  /// Create New Scheduler Coordinator Booking Requests Record
  /// Method: POST | Path: /v1/scheduler-coordinator-booking-requests | Status: mocked
  Future<ApiResponse> createApiV1SchedulerCoordinatorBookingRequestsCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/scheduler-coordinator-booking-requests', body: data);
  }

  /// Update Existing Scheduler Coordinator Booking Requests Record
  /// Method: PATCH | Path: /v1/scheduler-coordinator-booking-requests/:id | Status: mocked
  Future<ApiResponse> updateApiV1SchedulerCoordinatorBookingRequestsUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/scheduler-coordinator-booking-requests/$id', body: data);
  }

  /// Load Scheduler Coordinator Conflicts List Data
  /// Method: GET | Path: /v1/scheduler-coordinator-conflicts | Status: mocked
  Future<ApiResponse> loadApiV1SchedulerCoordinatorConflictsList() async {
    return ref.read(apiClientProvider).get('/v1/scheduler-coordinator-conflicts');
  }

  /// Load Scheduler Coordinator Open Shifts List Data
  /// Method: GET | Path: /v1/scheduler-coordinator-open-shifts | Status: mocked
  Future<ApiResponse> loadApiV1SchedulerCoordinatorOpenShiftsList() async {
    return ref.read(apiClientProvider).get('/v1/scheduler-coordinator-open-shifts');
  }

  /// Load Scheduler Coordinator Provider Availability List Data
  /// Method: GET | Path: /v1/scheduler-coordinator-provider-availability | Status: mocked
  Future<ApiResponse> loadApiV1SchedulerCoordinatorProviderAvailabilityList() async {
    return ref.read(apiClientProvider).get('/v1/scheduler-coordinator-provider-availability');
  }

  /// Load Scheduler Coordinator Reports List Data
  /// Method: GET | Path: /v1/scheduler-coordinator-reports | Status: mocked
  Future<ApiResponse> loadApiV1SchedulerCoordinatorReportsList() async {
    return ref.read(apiClientProvider).get('/v1/scheduler-coordinator-reports');
  }

  /// Load Scheduler Coordinator Shift Calendar List Data
  /// Method: GET | Path: /v1/scheduler-coordinator-shift-calendar | Status: mocked
  Future<ApiResponse> loadApiV1SchedulerCoordinatorShiftCalendarList() async {
    return ref.read(apiClientProvider).get('/v1/scheduler-coordinator-shift-calendar');
  }

  /// Load Blueprint Sandbox List Data
  /// Method: GET | Path: /v1/blueprint-sandbox | Status: mocked
  Future<ApiResponse> loadApiV1BlueprintSandboxList() async {
    return ref.read(apiClientProvider).get('/v1/blueprint-sandbox');
  }

  /// Create New Blueprint Sandbox Record
  /// Method: POST | Path: /v1/blueprint-sandbox | Status: mocked
  Future<ApiResponse> createApiV1BlueprintSandboxCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/blueprint-sandbox', body: data);
  }

  /// Update Existing Blueprint Sandbox Record
  /// Method: PATCH | Path: /v1/blueprint-sandbox/:id | Status: mocked
  Future<ApiResponse> updateApiV1BlueprintSandboxUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/blueprint-sandbox/$id', body: data);
  }

  /// Load Audit Sandbox List Data
  /// Method: GET | Path: /v1/audit-sandbox | Status: mocked
  Future<ApiResponse> loadApiV1AuditSandboxList() async {
    return ref.read(apiClientProvider).get('/v1/audit-sandbox');
  }

  /// Create New Audit Sandbox Record
  /// Method: POST | Path: /v1/audit-sandbox | Status: mocked
  Future<ApiResponse> createApiV1AuditSandboxCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/audit-sandbox', body: data);
  }

  /// Update Existing Audit Sandbox Record
  /// Method: PATCH | Path: /v1/audit-sandbox/:id | Status: mocked
  Future<ApiResponse> updateApiV1AuditSandboxUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/audit-sandbox/$id', body: data);
  }

  /// Load No Access List Data
  /// Method: GET | Path: /v1/no-access | Status: mocked
  Future<ApiResponse> loadApiV1NoAccessList() async {
    return ref.read(apiClientProvider).get('/v1/no-access');
  }

  /// Load Audit Log List Data
  /// Method: GET | Path: /v1/audit-log | Status: mocked
  Future<ApiResponse> loadApiV1AuditLogList() async {
    return ref.read(apiClientProvider).get('/v1/audit-log');
  }

  /// Load Monitoring List Data
  /// Method: GET | Path: /v1/monitoring | Status: mocked
  Future<ApiResponse> loadApiV1MonitoringList() async {
    return ref.read(apiClientProvider).get('/v1/monitoring');
  }

  /// Load Status List Data
  /// Method: GET | Path: /v1/status | Status: mocked
  Future<ApiResponse> loadApiV1StatusList() async {
    return ref.read(apiClientProvider).get('/v1/status');
  }

  /// Create New Status Record
  /// Method: POST | Path: /v1/status | Status: mocked
  Future<ApiResponse> createApiV1StatusCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/status', body: data);
  }

  /// Update Existing Status Record
  /// Method: PATCH | Path: /v1/status/:id | Status: mocked
  Future<ApiResponse> updateApiV1StatusUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/status/$id', body: data);
  }

  /// Load Ticket Center List Data
  /// Method: GET | Path: /v1/ticket-center | Status: mocked
  Future<ApiResponse> loadApiV1TicketCenterList() async {
    return ref.read(apiClientProvider).get('/v1/ticket-center');
  }

  /// Load Control Center List Data
  /// Method: GET | Path: /v1/control-center | Status: mocked
  Future<ApiResponse> loadApiV1ControlCenterList() async {
    return ref.read(apiClientProvider).get('/v1/control-center');
  }

  /// Create New Control Center Record
  /// Method: POST | Path: /v1/control-center | Status: mocked
  Future<ApiResponse> createApiV1ControlCenterCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/control-center', body: data);
  }

  /// Update Existing Control Center Record
  /// Method: PATCH | Path: /v1/control-center/:id | Status: mocked
  Future<ApiResponse> updateApiV1ControlCenterUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/control-center/$id', body: data);
  }

  /// Load Governance Hud List Data
  /// Method: GET | Path: /v1/governance-hud | Status: mocked
  Future<ApiResponse> loadApiV1GovernanceHudList() async {
    return ref.read(apiClientProvider).get('/v1/governance-hud');
  }

  /// Load Growth Pipeline List Data
  /// Method: GET | Path: /v1/growth-pipeline | Status: mocked
  Future<ApiResponse> loadApiV1GrowthPipelineList() async {
    return ref.read(apiClientProvider).get('/v1/growth-pipeline');
  }

  /// Load Leadership Reports List Data
  /// Method: GET | Path: /v1/leadership-reports | Status: mocked
  Future<ApiResponse> loadApiV1LeadershipReportsList() async {
    return ref.read(apiClientProvider).get('/v1/leadership-reports');
  }

  /// Load Proposals List Data
  /// Method: GET | Path: /v1/proposals | Status: mocked
  Future<ApiResponse> loadApiV1ProposalsList() async {
    return ref.read(apiClientProvider).get('/v1/proposals');
  }

  /// Load Regional Performance List Data
  /// Method: GET | Path: /v1/regional-performance | Status: mocked
  Future<ApiResponse> loadApiV1RegionalPerformanceList() async {
    return ref.read(apiClientProvider).get('/v1/regional-performance');
  }

  /// Create New Regional Performance Record
  /// Method: POST | Path: /v1/regional-performance | Status: mocked
  Future<ApiResponse> createApiV1RegionalPerformanceCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/regional-performance', body: data);
  }

  /// Update Existing Regional Performance Record
  /// Method: PATCH | Path: /v1/regional-performance/:id | Status: mocked
  Future<ApiResponse> updateApiV1RegionalPerformanceUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/regional-performance/$id', body: data);
  }

  /// Load Compliance Reviews List Data
  /// Method: GET | Path: /v1/compliance-reviews | Status: mocked
  Future<ApiResponse> loadApiV1ComplianceReviewsList() async {
    return ref.read(apiClientProvider).get('/v1/compliance-reviews');
  }

  /// Load Incident Reports List Data
  /// Method: GET | Path: /v1/incident-reports | Status: mocked
  Future<ApiResponse> loadApiV1IncidentReportsList() async {
    return ref.read(apiClientProvider).get('/v1/incident-reports');
  }

  /// Load Quality Metrics List Data
  /// Method: GET | Path: /v1/quality-metrics | Status: mocked
  Future<ApiResponse> loadApiV1QualityMetricsList() async {
    return ref.read(apiClientProvider).get('/v1/quality-metrics');
  }

  /// Load Clinical Reference List Data
  /// Method: GET | Path: /v1/clinical-reference | Status: mocked
  Future<ApiResponse> loadApiV1ClinicalReferenceList() async {
    return ref.read(apiClientProvider).get('/v1/clinical-reference');
  }

  /// Load Security Hub List Data
  /// Method: GET | Path: /v1/security-hub | Status: mocked
  Future<ApiResponse> loadApiV1SecurityHubList() async {
    return ref.read(apiClientProvider).get('/v1/security-hub');
  }

  /// Load Security Sentinel List Data
  /// Method: GET | Path: /v1/security-sentinel | Status: mocked
  Future<ApiResponse> loadApiV1SecuritySentinelList() async {
    return ref.read(apiClientProvider).get('/v1/security-sentinel');
  }

  /// Load Verification Center List Data
  /// Method: GET | Path: /v1/verification-center | Status: mocked
  Future<ApiResponse> loadApiV1VerificationCenterList() async {
    return ref.read(apiClientProvider).get('/v1/verification-center');
  }

  /// Load Community Outreach Contacts List Data
  /// Method: GET | Path: /v1/community-outreach-contacts | Status: mocked
  Future<ApiResponse> loadApiV1CommunityOutreachContactsList() async {
    return ref.read(apiClientProvider).get('/v1/community-outreach-contacts');
  }

  /// Load Community Outreach Events List Data
  /// Method: GET | Path: /v1/community-outreach-events | Status: mocked
  Future<ApiResponse> loadApiV1CommunityOutreachEventsList() async {
    return ref.read(apiClientProvider).get('/v1/community-outreach-events');
  }

  /// Load Community Outreach Follow Ups List Data
  /// Method: GET | Path: /v1/community-outreach-follow-ups | Status: mocked
  Future<ApiResponse> loadApiV1CommunityOutreachFollowUpsList() async {
    return ref.read(apiClientProvider).get('/v1/community-outreach-follow-ups');
  }

  /// Load Community Outreach Partnerships List Data
  /// Method: GET | Path: /v1/community-outreach-partnerships | Status: mocked
  Future<ApiResponse> loadApiV1CommunityOutreachPartnershipsList() async {
    return ref.read(apiClientProvider).get('/v1/community-outreach-partnerships');
  }

  /// Load Community Outreach Programs List Data
  /// Method: GET | Path: /v1/community-outreach-programs | Status: mocked
  Future<ApiResponse> loadApiV1CommunityOutreachProgramsList() async {
    return ref.read(apiClientProvider).get('/v1/community-outreach-programs');
  }

  /// Load Community Outreach Reports List Data
  /// Method: GET | Path: /v1/community-outreach-reports | Status: mocked
  Future<ApiResponse> loadApiV1CommunityOutreachReportsList() async {
    return ref.read(apiClientProvider).get('/v1/community-outreach-reports');
  }

  /// Load Community Outreach Volunteers List Data
  /// Method: GET | Path: /v1/community-outreach-volunteers | Status: mocked
  Future<ApiResponse> loadApiV1CommunityOutreachVolunteersList() async {
    return ref.read(apiClientProvider).get('/v1/community-outreach-volunteers');
  }

  /// Load Head Of Marketing Brand Assets List Data
  /// Method: GET | Path: /v1/head-of-marketing-brand-assets | Status: mocked
  Future<ApiResponse> loadApiV1HeadOfMarketingBrandAssetsList() async {
    return ref.read(apiClientProvider).get('/v1/head-of-marketing-brand-assets');
  }

  /// Load Head Of Marketing Campaigns List Data
  /// Method: GET | Path: /v1/head-of-marketing-campaigns | Status: mocked
  Future<ApiResponse> loadApiV1HeadOfMarketingCampaignsList() async {
    return ref.read(apiClientProvider).get('/v1/head-of-marketing-campaigns');
  }

  /// Load Head Of Marketing Content Approval List Data
  /// Method: GET | Path: /v1/head-of-marketing-content-approval | Status: mocked
  Future<ApiResponse> loadApiV1HeadOfMarketingContentApprovalList() async {
    return ref.read(apiClientProvider).get('/v1/head-of-marketing-content-approval');
  }

  /// Load Head Of Marketing Funnel Analytics List Data
  /// Method: GET | Path: /v1/head-of-marketing-funnel-analytics | Status: mocked
  Future<ApiResponse> loadApiV1HeadOfMarketingFunnelAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/head-of-marketing-funnel-analytics');
  }

  /// Load Head Of Marketing Leads List Data
  /// Method: GET | Path: /v1/head-of-marketing-leads | Status: mocked
  Future<ApiResponse> loadApiV1HeadOfMarketingLeadsList() async {
    return ref.read(apiClientProvider).get('/v1/head-of-marketing-leads');
  }

  /// Load Head Of Marketing Performance Reports List Data
  /// Method: GET | Path: /v1/head-of-marketing-performance-reports | Status: mocked
  Future<ApiResponse> loadApiV1HeadOfMarketingPerformanceReportsList() async {
    return ref.read(apiClientProvider).get('/v1/head-of-marketing-performance-reports');
  }

  /// Create New Head Of Marketing Performance Reports Record
  /// Method: POST | Path: /v1/head-of-marketing-performance-reports | Status: mocked
  Future<ApiResponse> createApiV1HeadOfMarketingPerformanceReportsCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/head-of-marketing-performance-reports', body: data);
  }

  /// Update Existing Head Of Marketing Performance Reports Record
  /// Method: PATCH | Path: /v1/head-of-marketing-performance-reports/:id | Status: mocked
  Future<ApiResponse> updateApiV1HeadOfMarketingPerformanceReportsUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/head-of-marketing-performance-reports/$id', body: data);
  }

  /// Load Head Of Marketing Regional Campaigns List Data
  /// Method: GET | Path: /v1/head-of-marketing-regional-campaigns | Status: mocked
  Future<ApiResponse> loadApiV1HeadOfMarketingRegionalCampaignsList() async {
    return ref.read(apiClientProvider).get('/v1/head-of-marketing-regional-campaigns');
  }

  /// Load Local Marketing Manager Assets List Data
  /// Method: GET | Path: /v1/local-marketing-manager-assets | Status: mocked
  Future<ApiResponse> loadApiV1LocalMarketingManagerAssetsList() async {
    return ref.read(apiClientProvider).get('/v1/local-marketing-manager-assets');
  }

  /// Load Local Marketing Manager Budget List Data
  /// Method: GET | Path: /v1/local-marketing-manager-budget | Status: mocked
  Future<ApiResponse> loadApiV1LocalMarketingManagerBudgetList() async {
    return ref.read(apiClientProvider).get('/v1/local-marketing-manager-budget');
  }

  /// Load Local Marketing Manager Campaigns List Data
  /// Method: GET | Path: /v1/local-marketing-manager-campaigns | Status: mocked
  Future<ApiResponse> loadApiV1LocalMarketingManagerCampaignsList() async {
    return ref.read(apiClientProvider).get('/v1/local-marketing-manager-campaigns');
  }

  /// Load Local Marketing Manager Content Calendar List Data
  /// Method: GET | Path: /v1/local-marketing-manager-content-calendar | Status: mocked
  Future<ApiResponse> loadApiV1LocalMarketingManagerContentCalendarList() async {
    return ref.read(apiClientProvider).get('/v1/local-marketing-manager-content-calendar');
  }

  /// Load Local Marketing Manager Events List Data
  /// Method: GET | Path: /v1/local-marketing-manager-events | Status: mocked
  Future<ApiResponse> loadApiV1LocalMarketingManagerEventsList() async {
    return ref.read(apiClientProvider).get('/v1/local-marketing-manager-events');
  }

  /// Load Local Marketing Manager Leads List Data
  /// Method: GET | Path: /v1/local-marketing-manager-leads | Status: mocked
  Future<ApiResponse> loadApiV1LocalMarketingManagerLeadsList() async {
    return ref.read(apiClientProvider).get('/v1/local-marketing-manager-leads');
  }

  /// Load Local Marketing Manager Reports List Data
  /// Method: GET | Path: /v1/local-marketing-manager-reports | Status: mocked
  Future<ApiResponse> loadApiV1LocalMarketingManagerReportsList() async {
    return ref.read(apiClientProvider).get('/v1/local-marketing-manager-reports');
  }

  /// Load Territory Sales Manager Area Performance List Data
  /// Method: GET | Path: /v1/territory-sales-manager-area-performance | Status: mocked
  Future<ApiResponse> loadApiV1TerritorySalesManagerAreaPerformanceList() async {
    return ref.read(apiClientProvider).get('/v1/territory-sales-manager-area-performance');
  }

  /// Create New Territory Sales Manager Area Performance Record
  /// Method: POST | Path: /v1/territory-sales-manager-area-performance | Status: mocked
  Future<ApiResponse> createApiV1TerritorySalesManagerAreaPerformanceCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/territory-sales-manager-area-performance', body: data);
  }

  /// Update Existing Territory Sales Manager Area Performance Record
  /// Method: PATCH | Path: /v1/territory-sales-manager-area-performance/:id | Status: mocked
  Future<ApiResponse> updateApiV1TerritorySalesManagerAreaPerformanceUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/territory-sales-manager-area-performance/$id', body: data);
  }

  /// Load Territory Sales Manager Competitors List Data
  /// Method: GET | Path: /v1/territory-sales-manager-competitors | Status: mocked
  Future<ApiResponse> loadApiV1TerritorySalesManagerCompetitorsList() async {
    return ref.read(apiClientProvider).get('/v1/territory-sales-manager-competitors');
  }

  /// Load Territory Sales Manager Conversions List Data
  /// Method: GET | Path: /v1/territory-sales-manager-conversions | Status: mocked
  Future<ApiResponse> loadApiV1TerritorySalesManagerConversionsList() async {
    return ref.read(apiClientProvider).get('/v1/territory-sales-manager-conversions');
  }

  /// Load Territory Sales Manager Field Activity List Data
  /// Method: GET | Path: /v1/territory-sales-manager-field-activity | Status: mocked
  Future<ApiResponse> loadApiV1TerritorySalesManagerFieldActivityList() async {
    return ref.read(apiClientProvider).get('/v1/territory-sales-manager-field-activity');
  }

  /// Load Territory Sales Manager Leads List Data
  /// Method: GET | Path: /v1/territory-sales-manager-leads | Status: mocked
  Future<ApiResponse> loadApiV1TerritorySalesManagerLeadsList() async {
    return ref.read(apiClientProvider).get('/v1/territory-sales-manager-leads');
  }

  /// Load Territory Sales Manager Pipeline List Data
  /// Method: GET | Path: /v1/territory-sales-manager-pipeline | Status: mocked
  Future<ApiResponse> loadApiV1TerritorySalesManagerPipelineList() async {
    return ref.read(apiClientProvider).get('/v1/territory-sales-manager-pipeline');
  }

  /// Load Territory Sales Manager Reports List Data
  /// Method: GET | Path: /v1/territory-sales-manager-reports | Status: mocked
  Future<ApiResponse> loadApiV1TerritorySalesManagerReportsList() async {
    return ref.read(apiClientProvider).get('/v1/territory-sales-manager-reports');
  }

  /// Load Customer Support Escalations List Data
  /// Method: GET | Path: /v1/customer-support-escalations | Status: mocked
  Future<ApiResponse> loadApiV1CustomerSupportEscalationsList() async {
    return ref.read(apiClientProvider).get('/v1/customer-support-escalations');
  }

  /// Load Customer Support Issue Categories List Data
  /// Method: GET | Path: /v1/customer-support-issue-categories | Status: mocked
  Future<ApiResponse> loadApiV1CustomerSupportIssueCategoriesList() async {
    return ref.read(apiClientProvider).get('/v1/customer-support-issue-categories');
  }

  /// Load Customer Support Reports List Data
  /// Method: GET | Path: /v1/customer-support-reports | Status: mocked
  Future<ApiResponse> loadApiV1CustomerSupportReportsList() async {
    return ref.read(apiClientProvider).get('/v1/customer-support-reports');
  }

  /// Load Customer Support Templates List Data
  /// Method: GET | Path: /v1/customer-support-templates | Status: mocked
  Future<ApiResponse> loadApiV1CustomerSupportTemplatesList() async {
    return ref.read(apiClientProvider).get('/v1/customer-support-templates');
  }

  /// Load Customer Support Tickets List Data
  /// Method: GET | Path: /v1/customer-support-tickets | Status: mocked
  Future<ApiResponse> loadApiV1CustomerSupportTicketsList() async {
    return ref.read(apiClientProvider).get('/v1/customer-support-tickets');
  }

  /// Load Intake Coordinator Client Assignment List Data
  /// Method: GET | Path: /v1/intake-coordinator-client-assignment | Status: mocked
  Future<ApiResponse> loadApiV1IntakeCoordinatorClientAssignmentList() async {
    return ref.read(apiClientProvider).get('/v1/intake-coordinator-client-assignment');
  }

  /// Create New Intake Coordinator Client Assignment Record
  /// Method: POST | Path: /v1/intake-coordinator-client-assignment | Status: mocked
  Future<ApiResponse> createApiV1IntakeCoordinatorClientAssignmentCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/intake-coordinator-client-assignment', body: data);
  }

  /// Update Existing Intake Coordinator Client Assignment Record
  /// Method: PATCH | Path: /v1/intake-coordinator-client-assignment/:id | Status: mocked
  Future<ApiResponse> updateApiV1IntakeCoordinatorClientAssignmentUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/intake-coordinator-client-assignment/$id', body: data);
  }

  /// Load Intake Coordinator Eligibility List Data
  /// Method: GET | Path: /v1/intake-coordinator-eligibility | Status: mocked
  Future<ApiResponse> loadApiV1IntakeCoordinatorEligibilityList() async {
    return ref.read(apiClientProvider).get('/v1/intake-coordinator-eligibility');
  }

  /// Create New Intake Coordinator Eligibility Record
  /// Method: POST | Path: /v1/intake-coordinator-eligibility | Status: mocked
  Future<ApiResponse> createApiV1IntakeCoordinatorEligibilityCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/intake-coordinator-eligibility', body: data);
  }

  /// Update Existing Intake Coordinator Eligibility Record
  /// Method: PATCH | Path: /v1/intake-coordinator-eligibility/:id | Status: mocked
  Future<ApiResponse> updateApiV1IntakeCoordinatorEligibilityUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/intake-coordinator-eligibility/$id', body: data);
  }

  /// Load Intake Coordinator Intake Forms List Data
  /// Method: GET | Path: /v1/intake-coordinator-intake-forms | Status: mocked
  Future<ApiResponse> loadApiV1IntakeCoordinatorIntakeFormsList() async {
    return ref.read(apiClientProvider).get('/v1/intake-coordinator-intake-forms');
  }

  /// Create New Intake Coordinator Intake Forms Record
  /// Method: POST | Path: /v1/intake-coordinator-intake-forms | Status: mocked
  Future<ApiResponse> createApiV1IntakeCoordinatorIntakeFormsCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/intake-coordinator-intake-forms', body: data);
  }

  /// Update Existing Intake Coordinator Intake Forms Record
  /// Method: PATCH | Path: /v1/intake-coordinator-intake-forms/:id | Status: mocked
  Future<ApiResponse> updateApiV1IntakeCoordinatorIntakeFormsUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/intake-coordinator-intake-forms/$id', body: data);
  }

  /// Load Intake Coordinator Intakes List Data
  /// Method: GET | Path: /v1/intake-coordinator-intakes | Status: mocked
  Future<ApiResponse> loadApiV1IntakeCoordinatorIntakesList() async {
    return ref.read(apiClientProvider).get('/v1/intake-coordinator-intakes');
  }

  /// Create New Intake Coordinator Intakes Record
  /// Method: POST | Path: /v1/intake-coordinator-intakes | Status: mocked
  Future<ApiResponse> createApiV1IntakeCoordinatorIntakesCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/intake-coordinator-intakes', body: data);
  }

  /// Update Existing Intake Coordinator Intakes Record
  /// Method: PATCH | Path: /v1/intake-coordinator-intakes/:id | Status: mocked
  Future<ApiResponse> updateApiV1IntakeCoordinatorIntakesUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/intake-coordinator-intakes/$id', body: data);
  }

  /// Load Intake Coordinator Reports List Data
  /// Method: GET | Path: /v1/intake-coordinator-reports | Status: mocked
  Future<ApiResponse> loadApiV1IntakeCoordinatorReportsList() async {
    return ref.read(apiClientProvider).get('/v1/intake-coordinator-reports');
  }

  /// Create New Intake Coordinator Reports Record
  /// Method: POST | Path: /v1/intake-coordinator-reports | Status: mocked
  Future<ApiResponse> createApiV1IntakeCoordinatorReportsCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/intake-coordinator-reports', body: data);
  }

  /// Update Existing Intake Coordinator Reports Record
  /// Method: PATCH | Path: /v1/intake-coordinator-reports/:id | Status: mocked
  Future<ApiResponse> updateApiV1IntakeCoordinatorReportsUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/intake-coordinator-reports/$id', body: data);
  }

  /// Load Intake Coordinator Scheduling List Data
  /// Method: GET | Path: /v1/intake-coordinator-scheduling | Status: mocked
  Future<ApiResponse> loadApiV1IntakeCoordinatorSchedulingList() async {
    return ref.read(apiClientProvider).get('/v1/intake-coordinator-scheduling');
  }

  /// Create New Intake Coordinator Scheduling Record
  /// Method: POST | Path: /v1/intake-coordinator-scheduling | Status: mocked
  Future<ApiResponse> createApiV1IntakeCoordinatorSchedulingCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/intake-coordinator-scheduling', body: data);
  }

  /// Update Existing Intake Coordinator Scheduling Record
  /// Method: PATCH | Path: /v1/intake-coordinator-scheduling/:id | Status: mocked
  Future<ApiResponse> updateApiV1IntakeCoordinatorSchedulingUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/intake-coordinator-scheduling/$id', body: data);
  }

  /// Load Quality Assurance Audits List Data
  /// Method: GET | Path: /v1/quality-assurance-audits | Status: mocked
  Future<ApiResponse> loadApiV1QualityAssuranceAuditsList() async {
    return ref.read(apiClientProvider).get('/v1/quality-assurance-audits');
  }

  /// Load Quality Assurance Complaints List Data
  /// Method: GET | Path: /v1/quality-assurance-complaints | Status: mocked
  Future<ApiResponse> loadApiV1QualityAssuranceComplaintsList() async {
    return ref.read(apiClientProvider).get('/v1/quality-assurance-complaints');
  }

  /// Load Quality Assurance Compliance Checks List Data
  /// Method: GET | Path: /v1/quality-assurance-compliance-checks | Status: mocked
  Future<ApiResponse> loadApiV1QualityAssuranceComplianceChecksList() async {
    return ref.read(apiClientProvider).get('/v1/quality-assurance-compliance-checks');
  }

  /// Load Quality Assurance Corrective Actions List Data
  /// Method: GET | Path: /v1/quality-assurance-corrective-actions | Status: mocked
  Future<ApiResponse> loadApiV1QualityAssuranceCorrectiveActionsList() async {
    return ref.read(apiClientProvider).get('/v1/quality-assurance-corrective-actions');
  }

  /// Load Quality Assurance Reports List Data
  /// Method: GET | Path: /v1/quality-assurance-reports | Status: mocked
  Future<ApiResponse> loadApiV1QualityAssuranceReportsList() async {
    return ref.read(apiClientProvider).get('/v1/quality-assurance-reports');
  }

  /// Load Quality Assurance Reviews List Data
  /// Method: GET | Path: /v1/quality-assurance-reviews | Status: mocked
  Future<ApiResponse> loadApiV1QualityAssuranceReviewsList() async {
    return ref.read(apiClientProvider).get('/v1/quality-assurance-reviews');
  }

  /// Load Quality Assurance Scorecards List Data
  /// Method: GET | Path: /v1/quality-assurance-scorecards | Status: mocked
  Future<ApiResponse> loadApiV1QualityAssuranceScorecardsList() async {
    return ref.read(apiClientProvider).get('/v1/quality-assurance-scorecards');
  }

  /// Load Training Coordinator Attendance List Data
  /// Method: GET | Path: /v1/training-coordinator-attendance | Status: mocked
  Future<ApiResponse> loadApiV1TrainingCoordinatorAttendanceList() async {
    return ref.read(apiClientProvider).get('/v1/training-coordinator-attendance');
  }

  /// Load Training Coordinator Certifications List Data
  /// Method: GET | Path: /v1/training-coordinator-certifications | Status: mocked
  Future<ApiResponse> loadApiV1TrainingCoordinatorCertificationsList() async {
    return ref.read(apiClientProvider).get('/v1/training-coordinator-certifications');
  }

  /// Load Training Coordinator Courses List Data
  /// Method: GET | Path: /v1/training-coordinator-courses | Status: mocked
  Future<ApiResponse> loadApiV1TrainingCoordinatorCoursesList() async {
    return ref.read(apiClientProvider).get('/v1/training-coordinator-courses');
  }

  /// Load Training Coordinator Materials List Data
  /// Method: GET | Path: /v1/training-coordinator-materials | Status: mocked
  Future<ApiResponse> loadApiV1TrainingCoordinatorMaterialsList() async {
    return ref.read(apiClientProvider).get('/v1/training-coordinator-materials');
  }

  /// Load Training Coordinator Progress List Data
  /// Method: GET | Path: /v1/training-coordinator-progress | Status: mocked
  Future<ApiResponse> loadApiV1TrainingCoordinatorProgressList() async {
    return ref.read(apiClientProvider).get('/v1/training-coordinator-progress');
  }

  /// Load Training Coordinator Reports List Data
  /// Method: GET | Path: /v1/training-coordinator-reports | Status: mocked
  Future<ApiResponse> loadApiV1TrainingCoordinatorReportsList() async {
    return ref.read(apiClientProvider).get('/v1/training-coordinator-reports');
  }

  /// Load Training Coordinator Training Schedule List Data
  /// Method: GET | Path: /v1/training-coordinator-training-schedule | Status: mocked
  Future<ApiResponse> loadApiV1TrainingCoordinatorTrainingScheduleList() async {
    return ref.read(apiClientProvider).get('/v1/training-coordinator-training-schedule');
  }

  /// Load Training Coordinator Workshops List Data
  /// Method: GET | Path: /v1/training-coordinator-workshops | Status: mocked
  Future<ApiResponse> loadApiV1TrainingCoordinatorWorkshopsList() async {
    return ref.read(apiClientProvider).get('/v1/training-coordinator-workshops');
  }

  /// Load Escalation List Data
  /// Method: GET | Path: /v1/escalation | Status: mocked
  Future<ApiResponse> loadApiV1EscalationList() async {
    return ref.read(apiClientProvider).get('/v1/escalation');
  }

  /// Load Help Desk List Data
  /// Method: GET | Path: /v1/help-desk | Status: mocked
  Future<ApiResponse> loadApiV1HelpDeskList() async {
    return ref.read(apiClientProvider).get('/v1/help-desk');
  }

  /// Load It Administrator List Data
  /// Method: GET | Path: /v1/it-administrator | Status: mocked
  Future<ApiResponse> loadApiV1ItAdministratorList() async {
    return ref.read(apiClientProvider).get('/v1/it-administrator');
  }

  /// Load Prime Care List Data
  /// Method: GET | Path: /v1/prime-care | Status: mocked
  Future<ApiResponse> loadApiV1PrimeCareList() async {
    return ref.read(apiClientProvider).get('/v1/prime-care');
  }

  /// Load Default Not Implemented List Data
  /// Method: GET | Path: /v1/default-not-implemented | Status: mocked
  Future<ApiResponse> loadApiV1DefaultNotImplementedList() async {
    return ref.read(apiClientProvider).get('/v1/default-not-implemented');
  }

  /// Load Sso Redirect List Data
  /// Method: GET | Path: /v1/sso-redirect | Status: mocked
  Future<ApiResponse> loadApiV1SsoRedirectList() async {
    return ref.read(apiClientProvider).get('/v1/sso-redirect');
  }

  /// Load Governed List Data
  /// Method: GET | Path: /v1/governed | Status: mocked
  Future<ApiResponse> loadApiV1GovernedList() async {
    return ref.read(apiClientProvider).get('/v1/governed');
  }

  /// Load Access Review Certifier List Data
  /// Method: GET | Path: /v1/access-review-certifier | Status: mocked
  Future<ApiResponse> loadApiV1AccessReviewCertifierList() async {
    return ref.read(apiClientProvider).get('/v1/access-review-certifier');
  }

  /// Load Admin User Management List Data
  /// Method: GET | Path: /v1/admin-user-management | Status: mocked
  Future<ApiResponse> loadApiV1AdminUserManagementList() async {
    return ref.read(apiClientProvider).get('/v1/admin-user-management');
  }

  /// Create New Admin User Management Record
  /// Method: POST | Path: /v1/admin-user-management | Status: mocked
  Future<ApiResponse> createApiV1AdminUserManagementCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/admin-user-management', body: data);
  }

  /// Update Existing Admin User Management Record
  /// Method: PATCH | Path: /v1/admin-user-management/:id | Status: mocked
  Future<ApiResponse> updateApiV1AdminUserManagementUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/admin-user-management/$id', body: data);
  }

  /// Load Single Admin User Management Details
  /// Method: GET | Path: /v1/admin-user-management/:id | Status: mocked
  Future<ApiResponse> loadApiV1AdminUserManagementDetail(String id) async {
    return ref.read(apiClientProvider).get('/v1/admin-user-management/$id');
  }

  /// Delete Admin User Management Record
  /// Method: DELETE | Path: /v1/admin-user-management/:id | Status: mocked
  Future<ApiResponse> deleteApiV1AdminUserManagementDelete(String id) async {
    return ref.read(apiClientProvider).delete('/v1/admin-user-management/$id');
  }

  /// Load Api Key Manager List Data
  /// Method: GET | Path: /v1/api-key-manager | Status: mocked
  Future<ApiResponse> loadApiV1ApiKeyManagerList() async {
    return ref.read(apiClientProvider).get('/v1/api-key-manager');
  }

  /// Load Compliance Training Tracker List Data
  /// Method: GET | Path: /v1/compliance-training-tracker | Status: mocked
  Future<ApiResponse> loadApiV1ComplianceTrainingTrackerList() async {
    return ref.read(apiClientProvider).get('/v1/compliance-training-tracker');
  }

  /// Load Configuration Version Control List Data
  /// Method: GET | Path: /v1/configuration-version-control | Status: mocked
  Future<ApiResponse> loadApiV1ConfigurationVersionControlList() async {
    return ref.read(apiClientProvider).get('/v1/configuration-version-control');
  }

  /// Load Consent Management Console List Data
  /// Method: GET | Path: /v1/consent-management-console | Status: mocked
  Future<ApiResponse> loadApiV1ConsentManagementConsoleList() async {
    return ref.read(apiClientProvider).get('/v1/consent-management-console');
  }

  /// Create New Consent Management Console Record
  /// Method: POST | Path: /v1/consent-management-console | Status: mocked
  Future<ApiResponse> createApiV1ConsentManagementConsoleCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/consent-management-console', body: data);
  }

  /// Update Existing Consent Management Console Record
  /// Method: PATCH | Path: /v1/consent-management-console/:id | Status: mocked
  Future<ApiResponse> updateApiV1ConsentManagementConsoleUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/consent-management-console/$id', body: data);
  }

  /// Load Crisis Protocol Trigger List Data
  /// Method: GET | Path: /v1/crisis-protocol-trigger | Status: mocked
  Future<ApiResponse> loadApiV1CrisisProtocolTriggerList() async {
    return ref.read(apiClientProvider).get('/v1/crisis-protocol-trigger');
  }

  /// Load Data Privacy Monitor List Data
  /// Method: GET | Path: /v1/data-privacy-monitor | Status: mocked
  Future<ApiResponse> loadApiV1DataPrivacyMonitorList() async {
    return ref.read(apiClientProvider).get('/v1/data-privacy-monitor');
  }

  /// Load Ecosystem State Board List Data
  /// Method: GET | Path: /v1/ecosystem-state-board | Status: mocked
  Future<ApiResponse> loadApiV1EcosystemStateBoardList() async {
    return ref.read(apiClientProvider).get('/v1/ecosystem-state-board');
  }

  /// Load F A Q Manager List Data
  /// Method: GET | Path: /v1/f-a-q-manager | Status: mocked
  Future<ApiResponse> loadApiV1FAQManagerList() async {
    return ref.read(apiClientProvider).get('/v1/f-a-q-manager');
  }

  /// Load Feature Flag Controller List Data
  /// Method: GET | Path: /v1/feature-flag-controller | Status: mocked
  Future<ApiResponse> loadApiV1FeatureFlagControllerList() async {
    return ref.read(apiClientProvider).get('/v1/feature-flag-controller');
  }

  /// Load Hipaa Audit List Data
  /// Method: GET | Path: /v1/hipaa-audit | Status: mocked
  Future<ApiResponse> loadApiV1HipaaAuditList() async {
    return ref.read(apiClientProvider).get('/v1/hipaa-audit');
  }

  /// Load Incident Response Hub List Data
  /// Method: GET | Path: /v1/incident-response-hub | Status: mocked
  Future<ApiResponse> loadApiV1IncidentResponseHubList() async {
    return ref.read(apiClientProvider).get('/v1/incident-response-hub');
  }

  /// Load Integration Health Monitor List Data
  /// Method: GET | Path: /v1/integration-health-monitor | Status: mocked
  Future<ApiResponse> loadApiV1IntegrationHealthMonitorList() async {
    return ref.read(apiClientProvider).get('/v1/integration-health-monitor');
  }

  /// Load Lead Pipeline List Data
  /// Method: GET | Path: /v1/lead-pipeline | Status: mocked
  Future<ApiResponse> loadApiV1LeadPipelineList() async {
    return ref.read(apiClientProvider).get('/v1/lead-pipeline');
  }

  /// Load Message Archiveer List Data
  /// Method: GET | Path: /v1/message-archiveer | Status: mocked
  Future<ApiResponse> loadApiV1MessageArchiveerList() async {
    return ref.read(apiClientProvider).get('/v1/message-archiveer');
  }

  /// Create New Message Archiveer Record
  /// Method: POST | Path: /v1/message-archiveer | Status: mocked
  Future<ApiResponse> createApiV1MessageArchiveerCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/message-archiveer', body: data);
  }

  /// Update Existing Message Archiveer Record
  /// Method: PATCH | Path: /v1/message-archiveer/:id | Status: mocked
  Future<ApiResponse> updateApiV1MessageArchiveerUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/message-archiveer/$id', body: data);
  }

  /// Load Osha Incident Reporter List Data
  /// Method: GET | Path: /v1/osha-incident-reporter | Status: mocked
  Future<ApiResponse> loadApiV1OshaIncidentReporterList() async {
    return ref.read(apiClientProvider).get('/v1/osha-incident-reporter');
  }

  /// Load Policy Exception Tracker List Data
  /// Method: GET | Path: /v1/policy-exception-tracker | Status: mocked
  Future<ApiResponse> loadApiV1PolicyExceptionTrackerList() async {
    return ref.read(apiClientProvider).get('/v1/policy-exception-tracker');
  }

  /// Load Protocol Resolution Log List Data
  /// Method: GET | Path: /v1/protocol-resolution-log | Status: mocked
  Future<ApiResponse> loadApiV1ProtocolResolutionLogList() async {
    return ref.read(apiClientProvider).get('/v1/protocol-resolution-log');
  }

  /// Load Provider Performance List Data
  /// Method: GET | Path: /v1/provider-performance | Status: mocked
  Future<ApiResponse> loadApiV1ProviderPerformanceList() async {
    return ref.read(apiClientProvider).get('/v1/provider-performance');
  }

  /// Create New Provider Performance Record
  /// Method: POST | Path: /v1/provider-performance | Status: mocked
  Future<ApiResponse> createApiV1ProviderPerformanceCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/provider-performance', body: data);
  }

  /// Update Existing Provider Performance Record
  /// Method: PATCH | Path: /v1/provider-performance/:id | Status: mocked
  Future<ApiResponse> updateApiV1ProviderPerformanceUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/provider-performance/$id', body: data);
  }

  /// Load Quality Assurance Metrics List Data
  /// Method: GET | Path: /v1/quality-assurance-metrics | Status: mocked
  Future<ApiResponse> loadApiV1QualityAssuranceMetricsList() async {
    return ref.read(apiClientProvider).get('/v1/quality-assurance-metrics');
  }

  /// Load Registry Entry Editor List Data
  /// Method: GET | Path: /v1/registry-entry-editor | Status: mocked
  Future<ApiResponse> loadApiV1RegistryEntryEditorList() async {
    return ref.read(apiClientProvider).get('/v1/registry-entry-editor');
  }

  /// Create New Registry Entry Editor Record
  /// Method: POST | Path: /v1/registry-entry-editor | Status: mocked
  Future<ApiResponse> createApiV1RegistryEntryEditorCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/registry-entry-editor', body: data);
  }

  /// Update Existing Registry Entry Editor Record
  /// Method: PATCH | Path: /v1/registry-entry-editor/:id | Status: mocked
  Future<ApiResponse> updateApiV1RegistryEntryEditorUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/registry-entry-editor/$id', body: data);
  }

  /// Load Regulatory Change Radar List Data
  /// Method: GET | Path: /v1/regulatory-change-radar | Status: mocked
  Future<ApiResponse> loadApiV1RegulatoryChangeRadarList() async {
    return ref.read(apiClientProvider).get('/v1/regulatory-change-radar');
  }

  /// Load Resource Allocation Map List Data
  /// Method: GET | Path: /v1/resource-allocation-map | Status: mocked
  Future<ApiResponse> loadApiV1ResourceAllocationMapList() async {
    return ref.read(apiClientProvider).get('/v1/resource-allocation-map');
  }

  /// Load Response Bot Audit List Data
  /// Method: GET | Path: /v1/response-bot-audit | Status: mocked
  Future<ApiResponse> loadApiV1ResponseBotAuditList() async {
    return ref.read(apiClientProvider).get('/v1/response-bot-audit');
  }

  /// Create New Response Bot Audit Record
  /// Method: POST | Path: /v1/response-bot-audit | Status: mocked
  Future<ApiResponse> createApiV1ResponseBotAuditCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/response-bot-audit', body: data);
  }

  /// Update Existing Response Bot Audit Record
  /// Method: PATCH | Path: /v1/response-bot-audit/:id | Status: mocked
  Future<ApiResponse> updateApiV1ResponseBotAuditUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/response-bot-audit/$id', body: data);
  }

  /// Load Role Access Matrix List Data
  /// Method: GET | Path: /v1/role-access-matrix | Status: mocked
  Future<ApiResponse> loadApiV1RoleAccessMatrixList() async {
    return ref.read(apiClientProvider).get('/v1/role-access-matrix');
  }

  /// Load Role Access List Data
  /// Method: GET | Path: /v1/role-access | Status: mocked
  Future<ApiResponse> loadApiV1RoleAccessList() async {
    return ref.read(apiClientProvider).get('/v1/role-access');
  }

  /// Create New Role Access Record
  /// Method: POST | Path: /v1/role-access | Status: mocked
  Future<ApiResponse> createApiV1RoleAccessCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/role-access', body: data);
  }

  /// Update Existing Role Access Record
  /// Method: PATCH | Path: /v1/role-access/:id | Status: mocked
  Future<ApiResponse> updateApiV1RoleAccessUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/role-access/$id', body: data);
  }

  /// Load Secure Message Center List Data
  /// Method: GET | Path: /v1/secure-message-center | Status: mocked
  Future<ApiResponse> loadApiV1SecureMessageCenterList() async {
    return ref.read(apiClientProvider).get('/v1/secure-message-center');
  }

  /// Create New Secure Message Center Record
  /// Method: POST | Path: /v1/secure-message-center | Status: mocked
  Future<ApiResponse> createApiV1SecureMessageCenterCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/secure-message-center', body: data);
  }

  /// Update Existing Secure Message Center Record
  /// Method: PATCH | Path: /v1/secure-message-center/:id | Status: mocked
  Future<ApiResponse> updateApiV1SecureMessageCenterUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/secure-message-center/$id', body: data);
  }

  /// Load Security Incident Logger List Data
  /// Method: GET | Path: /v1/security-incident-logger | Status: mocked
  Future<ApiResponse> loadApiV1SecurityIncidentLoggerList() async {
    return ref.read(apiClientProvider).get('/v1/security-incident-logger');
  }

  /// Load Service Mesh Topology List Data
  /// Method: GET | Path: /v1/service-mesh-topology | Status: mocked
  Future<ApiResponse> loadApiV1ServiceMeshTopologyList() async {
    return ref.read(apiClientProvider).get('/v1/service-mesh-topology');
  }

  /// Load System Capacity Planner List Data
  /// Method: GET | Path: /v1/system-capacity-planner | Status: mocked
  Future<ApiResponse> loadApiV1SystemCapacityPlannerList() async {
    return ref.read(apiClientProvider).get('/v1/system-capacity-planner');
  }

  /// Load Tenant Configuration List Data
  /// Method: GET | Path: /v1/tenant-configuration | Status: mocked
  Future<ApiResponse> loadApiV1TenantConfigurationList() async {
    return ref.read(apiClientProvider).get('/v1/tenant-configuration');
  }

  /// Load Touchpoint Analyzer List Data
  /// Method: GET | Path: /v1/touchpoint-analyzer | Status: mocked
  Future<ApiResponse> loadApiV1TouchpointAnalyzerList() async {
    return ref.read(apiClientProvider).get('/v1/touchpoint-analyzer');
  }

  /// Load User Management List Data
  /// Method: GET | Path: /v1/user-management | Status: mocked
  Future<ApiResponse> loadApiV1UserManagementList() async {
    return ref.read(apiClientProvider).get('/v1/user-management');
  }

  /// Create New User Management Record
  /// Method: POST | Path: /v1/user-management | Status: mocked
  Future<ApiResponse> createApiV1UserManagementCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/user-management', body: data);
  }

  /// Update Existing User Management Record
  /// Method: PATCH | Path: /v1/user-management/:id | Status: mocked
  Future<ApiResponse> updateApiV1UserManagementUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/user-management/$id', body: data);
  }

  /// Load Single User Management Details
  /// Method: GET | Path: /v1/user-management/:id | Status: mocked
  Future<ApiResponse> loadApiV1UserManagementDetail(String id) async {
    return ref.read(apiClientProvider).get('/v1/user-management/$id');
  }

  /// Delete User Management Record
  /// Method: DELETE | Path: /v1/user-management/:id | Status: mocked
  Future<ApiResponse> deleteApiV1UserManagementDelete(String id) async {
    return ref.read(apiClientProvider).delete('/v1/user-management/$id');
  }

  /// Load Vendor Risk Assessor List Data
  /// Method: GET | Path: /v1/vendor-risk-assessor | Status: mocked
  Future<ApiResponse> loadApiV1VendorRiskAssessorList() async {
    return ref.read(apiClientProvider).get('/v1/vendor-risk-assessor');
  }

  /// Load Board Of Directors Summary List Data
  /// Method: GET | Path: /v1/board-of-directors-summary | Status: mocked
  Future<ApiResponse> loadApiV1BoardOfDirectorsSummaryList() async {
    return ref.read(apiClientProvider).get('/v1/board-of-directors-summary');
  }

  /// Load Clinical Outcomes Report List Data
  /// Method: GET | Path: /v1/clinical-outcomes-report | Status: mocked
  Future<ApiResponse> loadApiV1ClinicalOutcomesReportList() async {
    return ref.read(apiClientProvider).get('/v1/clinical-outcomes-report');
  }

  /// Load Financial Forecasting Model List Data
  /// Method: GET | Path: /v1/financial-forecasting-model | Status: mocked
  Future<ApiResponse> loadApiV1FinancialForecastingModelList() async {
    return ref.read(apiClientProvider).get('/v1/financial-forecasting-model');
  }

  /// Load Marketing R O I Report List Data
  /// Method: GET | Path: /v1/marketing-r-o-i-report | Status: mocked
  Future<ApiResponse> loadApiV1MarketingROIReportList() async {
    return ref.read(apiClientProvider).get('/v1/marketing-r-o-i-report');
  }

  /// Load Operational Efficiency Metrics List Data
  /// Method: GET | Path: /v1/operational-efficiency-metrics | Status: mocked
  Future<ApiResponse> loadApiV1OperationalEfficiencyMetricsList() async {
    return ref.read(apiClientProvider).get('/v1/operational-efficiency-metrics');
  }

  /// Load Patient Retention Analytics List Data
  /// Method: GET | Path: /v1/patient-retention-analytics | Status: mocked
  Future<ApiResponse> loadApiV1PatientRetentionAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/patient-retention-analytics');
  }

  /// Load Population Health Analyzer List Data
  /// Method: GET | Path: /v1/population-health-analyzer | Status: mocked
  Future<ApiResponse> loadApiV1PopulationHealthAnalyzerList() async {
    return ref.read(apiClientProvider).get('/v1/population-health-analyzer');
  }

  /// Load Predictive Analytics List Data
  /// Method: GET | Path: /v1/predictive-analytics | Status: mocked
  Future<ApiResponse> loadApiV1PredictiveAnalyticsList() async {
    return ref.read(apiClientProvider).get('/v1/predictive-analytics');
  }

  /// Load Staff Utilization Heatmap List Data
  /// Method: GET | Path: /v1/staff-utilization-heatmap | Status: mocked
  Future<ApiResponse> loadApiV1StaffUtilizationHeatmapList() async {
    return ref.read(apiClientProvider).get('/v1/staff-utilization-heatmap');
  }

  /// Load Supply Chain Cost Analyzer List Data
  /// Method: GET | Path: /v1/supply-chain-cost-analyzer | Status: mocked
  Future<ApiResponse> loadApiV1SupplyChainCostAnalyzerList() async {
    return ref.read(apiClientProvider).get('/v1/supply-chain-cost-analyzer');
  }

  /// Load Forgot Password List Data
  /// Method: GET | Path: /v1/forgot-password | Status: mocked
  Future<ApiResponse> loadApiV1ForgotPasswordList() async {
    return ref.read(apiClientProvider).get('/v1/forgot-password');
  }

  /// Load Login List Data
  /// Method: GET | Path: /v1/login | Status: mocked
  Future<ApiResponse> loadApiV1LoginList() async {
    return ref.read(apiClientProvider).get('/v1/login');
  }

  /// Load Mfa List Data
  /// Method: GET | Path: /v1/mfa | Status: mocked
  Future<ApiResponse> loadApiV1MfaList() async {
    return ref.read(apiClientProvider).get('/v1/mfa');
  }

  /// Load Reset Password List Data
  /// Method: GET | Path: /v1/reset-password | Status: mocked
  Future<ApiResponse> loadApiV1ResetPasswordList() async {
    return ref.read(apiClientProvider).get('/v1/reset-password');
  }

  /// Load Certification Renewal Alerts List Data
  /// Method: GET | Path: /v1/certification-renewal-alerts | Status: mocked
  Future<ApiResponse> loadApiV1CertificationRenewalAlertsList() async {
    return ref.read(apiClientProvider).get('/v1/certification-renewal-alerts');
  }

  /// Create New Certification Renewal Alerts Record
  /// Method: POST | Path: /v1/certification-renewal-alerts | Status: mocked
  Future<ApiResponse> createApiV1CertificationRenewalAlertsCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/certification-renewal-alerts', body: data);
  }

  /// Update Existing Certification Renewal Alerts Record
  /// Method: PATCH | Path: /v1/certification-renewal-alerts/:id | Status: mocked
  Future<ApiResponse> updateApiV1CertificationRenewalAlertsUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/certification-renewal-alerts/$id', body: data);
  }

  /// Load Clinical Guideline Library List Data
  /// Method: GET | Path: /v1/clinical-guideline-library | Status: mocked
  Future<ApiResponse> loadApiV1ClinicalGuidelineLibraryList() async {
    return ref.read(apiClientProvider).get('/v1/clinical-guideline-library');
  }

  /// Load C M E Tracking List Data
  /// Method: GET | Path: /v1/c-m-e-tracking | Status: mocked
  Future<ApiResponse> loadApiV1CMETrackingList() async {
    return ref.read(apiClientProvider).get('/v1/c-m-e-tracking');
  }

  /// Load Journal Club Discussion Board List Data
  /// Method: GET | Path: /v1/journal-club-discussion-board | Status: mocked
  Future<ApiResponse> loadApiV1JournalClubDiscussionBoardList() async {
    return ref.read(apiClientProvider).get('/v1/journal-club-discussion-board');
  }

  /// Load Medical Library Access Portal List Data
  /// Method: GET | Path: /v1/medical-library-access-portal | Status: mocked
  Future<ApiResponse> loadApiV1MedicalLibraryAccessPortalList() async {
    return ref.read(apiClientProvider).get('/v1/medical-library-access-portal');
  }

  /// Load Patient Case Study Repository List Data
  /// Method: GET | Path: /v1/patient-case-study-repository | Status: mocked
  Future<ApiResponse> loadApiV1PatientCaseStudyRepositoryList() async {
    return ref.read(apiClientProvider).get('/v1/patient-case-study-repository');
  }

  /// Load Peer Review Conference Room List Data
  /// Method: GET | Path: /v1/peer-review-conference-room | Status: mocked
  Future<ApiResponse> loadApiV1PeerReviewConferenceRoomList() async {
    return ref.read(apiClientProvider).get('/v1/peer-review-conference-room');
  }

  /// Load Residency Program Tracker List Data
  /// Method: GET | Path: /v1/residency-program-tracker | Status: mocked
  Future<ApiResponse> loadApiV1ResidencyProgramTrackerList() async {
    return ref.read(apiClientProvider).get('/v1/residency-program-tracker');
  }

  /// Load Simulation Lab Scheduler List Data
  /// Method: GET | Path: /v1/simulation-lab-scheduler | Status: mocked
  Future<ApiResponse> loadApiV1SimulationLabSchedulerList() async {
    return ref.read(apiClientProvider).get('/v1/simulation-lab-scheduler');
  }

  /// Load Surgical Video Archive List Data
  /// Method: GET | Path: /v1/surgical-video-archive | Status: mocked
  Future<ApiResponse> loadApiV1SurgicalVideoArchiveList() async {
    return ref.read(apiClientProvider).get('/v1/surgical-video-archive');
  }

  /// Load Billing Claims List Data
  /// Method: GET | Path: /v1/billing-claims | Status: mocked
  Future<ApiResponse> loadApiV1BillingClaimsList() async {
    return ref.read(apiClientProvider).get('/v1/billing-claims');
  }

  /// Load Billing Invoices List Data
  /// Method: GET | Path: /v1/billing-invoices | Status: mocked
  Future<ApiResponse> loadApiV1BillingInvoicesList() async {
    return ref.read(apiClientProvider).get('/v1/billing-invoices');
  }

  /// Load Billing Payments List Data
  /// Method: GET | Path: /v1/billing-payments | Status: mocked
  Future<ApiResponse> loadApiV1BillingPaymentsList() async {
    return ref.read(apiClientProvider).get('/v1/billing-payments');
  }

  /// Load Hr Applicants List Data
  /// Method: GET | Path: /v1/hr-applicants | Status: mocked
  Future<ApiResponse> loadApiV1HrApplicantsList() async {
    return ref.read(apiClientProvider).get('/v1/hr-applicants');
  }

  /// Load Hr Onboarding List Data
  /// Method: GET | Path: /v1/hr-onboarding | Status: mocked
  Future<ApiResponse> loadApiV1HrOnboardingList() async {
    return ref.read(apiClientProvider).get('/v1/hr-onboarding');
  }

  /// Load Hr Staff Files List Data
  /// Method: GET | Path: /v1/hr-staff-files | Status: mocked
  Future<ApiResponse> loadApiV1HrStaffFilesList() async {
    return ref.read(apiClientProvider).get('/v1/hr-staff-files');
  }

  /// Load Receptionist Appointments List Data
  /// Method: GET | Path: /v1/receptionist-appointments | Status: mocked
  Future<ApiResponse> loadApiV1ReceptionistAppointmentsList() async {
    return ref.read(apiClientProvider).get('/v1/receptionist-appointments');
  }

  /// Load Receptionist Calls List Data
  /// Method: GET | Path: /v1/receptionist-calls | Status: mocked
  Future<ApiResponse> loadApiV1ReceptionistCallsList() async {
    return ref.read(apiClientProvider).get('/v1/receptionist-calls');
  }

  /// Load Receptionist Visitors List Data
  /// Method: GET | Path: /v1/receptionist-visitors | Status: mocked
  Future<ApiResponse> loadApiV1ReceptionistVisitorsList() async {
    return ref.read(apiClientProvider).get('/v1/receptionist-visitors');
  }

  /// Load Scheduler Availability List Data
  /// Method: GET | Path: /v1/scheduler-availability | Status: mocked
  Future<ApiResponse> loadApiV1SchedulerAvailabilityList() async {
    return ref.read(apiClientProvider).get('/v1/scheduler-availability');
  }

  /// Load Scheduler Shifts List Data
  /// Method: GET | Path: /v1/scheduler-shifts | Status: mocked
  Future<ApiResponse> loadApiV1SchedulerShiftsList() async {
    return ref.read(apiClientProvider).get('/v1/scheduler-shifts');
  }

  /// Load Brand Asset Library List Data
  /// Method: GET | Path: /v1/brand-asset-library | Status: mocked
  Future<ApiResponse> loadApiV1BrandAssetLibraryList() async {
    return ref.read(apiClientProvider).get('/v1/brand-asset-library');
  }

  /// Load Campaign Performance List Data
  /// Method: GET | Path: /v1/campaign-performance | Status: mocked
  Future<ApiResponse> loadApiV1CampaignPerformanceList() async {
    return ref.read(apiClientProvider).get('/v1/campaign-performance');
  }

  /// Create New Campaign Performance Record
  /// Method: POST | Path: /v1/campaign-performance | Status: mocked
  Future<ApiResponse> createApiV1CampaignPerformanceCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/campaign-performance', body: data);
  }

  /// Update Existing Campaign Performance Record
  /// Method: PATCH | Path: /v1/campaign-performance/:id | Status: mocked
  Future<ApiResponse> updateApiV1CampaignPerformanceUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/campaign-performance/$id', body: data);
  }

  /// Load Competitor Analysis Board List Data
  /// Method: GET | Path: /v1/competitor-analysis-board | Status: mocked
  Future<ApiResponse> loadApiV1CompetitorAnalysisBoardList() async {
    return ref.read(apiClientProvider).get('/v1/competitor-analysis-board');
  }

  /// Load Email Marketing Automator List Data
  /// Method: GET | Path: /v1/email-marketing-automator | Status: mocked
  Future<ApiResponse> loadApiV1EmailMarketingAutomatorList() async {
    return ref.read(apiClientProvider).get('/v1/email-marketing-automator');
  }

  /// Load Event And Webinar Manager List Data
  /// Method: GET | Path: /v1/event-and-webinar-manager | Status: mocked
  Future<ApiResponse> loadApiV1EventAndWebinarManagerList() async {
    return ref.read(apiClientProvider).get('/v1/event-and-webinar-manager');
  }

  /// Load Lead Conversion Funnel List Data
  /// Method: GET | Path: /v1/lead-conversion-funnel | Status: mocked
  Future<ApiResponse> loadApiV1LeadConversionFunnelList() async {
    return ref.read(apiClientProvider).get('/v1/lead-conversion-funnel');
  }

  /// Load Patient Acquisition Cost Tracker List Data
  /// Method: GET | Path: /v1/patient-acquisition-cost-tracker | Status: mocked
  Future<ApiResponse> loadApiV1PatientAcquisitionCostTrackerList() async {
    return ref.read(apiClientProvider).get('/v1/patient-acquisition-cost-tracker');
  }

  /// Load Referral Network Manager List Data
  /// Method: GET | Path: /v1/referral-network-manager | Status: mocked
  Future<ApiResponse> loadApiV1ReferralNetworkManagerList() async {
    return ref.read(apiClientProvider).get('/v1/referral-network-manager');
  }

  /// Load Social Media Sentiment Analyzer List Data
  /// Method: GET | Path: /v1/social-media-sentiment-analyzer | Status: mocked
  Future<ApiResponse> loadApiV1SocialMediaSentimentAnalyzerList() async {
    return ref.read(apiClientProvider).get('/v1/social-media-sentiment-analyzer');
  }

  /// Load Territory Sales Mapping List Data
  /// Method: GET | Path: /v1/territory-sales-mapping | Status: mocked
  Future<ApiResponse> loadApiV1TerritorySalesMappingList() async {
    return ref.read(apiClientProvider).get('/v1/territory-sales-mapping');
  }

  /// Load App Notification List Data
  /// Method: GET | Path: /v1/app-notification | Status: mocked
  Future<ApiResponse> loadApiV1AppNotificationList() async {
    return ref.read(apiClientProvider).get('/v1/app-notification');
  }

  /// Create New App Notification Record
  /// Method: POST | Path: /v1/app-notification | Status: mocked
  Future<ApiResponse> createApiV1AppNotificationCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/app-notification', body: data);
  }

  /// Update Existing App Notification Record
  /// Method: PATCH | Path: /v1/app-notification/:id | Status: mocked
  Future<ApiResponse> updateApiV1AppNotificationUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/app-notification/$id', body: data);
  }

  /// Load Gamification Profile List Data
  /// Method: GET | Path: /v1/gamification-profile | Status: mocked
  Future<ApiResponse> loadApiV1GamificationProfileList() async {
    return ref.read(apiClientProvider).get('/v1/gamification-profile');
  }

  /// Create New Gamification Profile Record
  /// Method: POST | Path: /v1/gamification-profile | Status: mocked
  Future<ApiResponse> createApiV1GamificationProfileCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/gamification-profile', body: data);
  }

  /// Update Existing Gamification Profile Record
  /// Method: PATCH | Path: /v1/gamification-profile/:id | Status: mocked
  Future<ApiResponse> updateApiV1GamificationProfileUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/gamification-profile/$id', body: data);
  }

  /// Load Security Incident List Data
  /// Method: GET | Path: /v1/security-incident | Status: mocked
  Future<ApiResponse> loadApiV1SecurityIncidentList() async {
    return ref.read(apiClientProvider).get('/v1/security-incident');
  }

  /// Create New Security Incident Record
  /// Method: POST | Path: /v1/security-incident | Status: mocked
  Future<ApiResponse> createApiV1SecurityIncidentCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/security-incident', body: data);
  }

  /// Update Existing Security Incident Record
  /// Method: PATCH | Path: /v1/security-incident/:id | Status: mocked
  Future<ApiResponse> updateApiV1SecurityIncidentUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/security-incident/$id', body: data);
  }

  /// Load Service Procurement List Data
  /// Method: GET | Path: /v1/service-procurement | Status: mocked
  Future<ApiResponse> loadApiV1ServiceProcurementList() async {
    return ref.read(apiClientProvider).get('/v1/service-procurement');
  }

  /// Create New Service Procurement Record
  /// Method: POST | Path: /v1/service-procurement | Status: mocked
  Future<ApiResponse> createApiV1ServiceProcurementCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/service-procurement', body: data);
  }

  /// Update Existing Service Procurement Record
  /// Method: PATCH | Path: /v1/service-procurement/:id | Status: mocked
  Future<ApiResponse> updateApiV1ServiceProcurementUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/service-procurement/$id', body: data);
  }

  /// Load Site Readiness List Data
  /// Method: GET | Path: /v1/site-readiness | Status: mocked
  Future<ApiResponse> loadApiV1SiteReadinessList() async {
    return ref.read(apiClientProvider).get('/v1/site-readiness');
  }

  /// Create New Site Readiness Record
  /// Method: POST | Path: /v1/site-readiness | Status: mocked
  Future<ApiResponse> createApiV1SiteReadinessCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/site-readiness', body: data);
  }

  /// Update Existing Site Readiness Record
  /// Method: PATCH | Path: /v1/site-readiness/:id | Status: mocked
  Future<ApiResponse> updateApiV1SiteReadinessUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/site-readiness/$id', body: data);
  }

  /// Load Virtual Consult List Data
  /// Method: GET | Path: /v1/virtual-consult | Status: mocked
  Future<ApiResponse> loadApiV1VirtualConsultList() async {
    return ref.read(apiClientProvider).get('/v1/virtual-consult');
  }

  /// Create New Virtual Consult Record
  /// Method: POST | Path: /v1/virtual-consult | Status: mocked
  Future<ApiResponse> createApiV1VirtualConsultCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/virtual-consult', body: data);
  }

  /// Update Existing Virtual Consult Record
  /// Method: PATCH | Path: /v1/virtual-consult/:id | Status: mocked
  Future<ApiResponse> updateApiV1VirtualConsultUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/virtual-consult/$id', body: data);
  }

  /// Load Chemotherapy Protocol Builder List Data
  /// Method: GET | Path: /v1/chemotherapy-protocol-builder | Status: mocked
  Future<ApiResponse> loadApiV1ChemotherapyProtocolBuilderList() async {
    return ref.read(apiClientProvider).get('/v1/chemotherapy-protocol-builder');
  }

  /// Create New Chemotherapy Protocol Builder Record
  /// Method: POST | Path: /v1/chemotherapy-protocol-builder | Status: mocked
  Future<ApiResponse> createApiV1ChemotherapyProtocolBuilderCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/chemotherapy-protocol-builder', body: data);
  }

  /// Update Existing Chemotherapy Protocol Builder Record
  /// Method: PATCH | Path: /v1/chemotherapy-protocol-builder/:id | Status: mocked
  Future<ApiResponse> updateApiV1ChemotherapyProtocolBuilderUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/chemotherapy-protocol-builder/$id', body: data);
  }

  /// Load Controlled Substance Log List Data
  /// Method: GET | Path: /v1/controlled-substance-log | Status: mocked
  Future<ApiResponse> loadApiV1ControlledSubstanceLogList() async {
    return ref.read(apiClientProvider).get('/v1/controlled-substance-log');
  }

  /// Create New Controlled Substance Log Record
  /// Method: POST | Path: /v1/controlled-substance-log | Status: mocked
  Future<ApiResponse> createApiV1ControlledSubstanceLogCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/controlled-substance-log', body: data);
  }

  /// Update Existing Controlled Substance Log Record
  /// Method: PATCH | Path: /v1/controlled-substance-log/:id | Status: mocked
  Future<ApiResponse> updateApiV1ControlledSubstanceLogUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/controlled-substance-log/$id', body: data);
  }

  /// Load Drug Interaction Alert Center List Data
  /// Method: GET | Path: /v1/drug-interaction-alert-center | Status: mocked
  Future<ApiResponse> loadApiV1DrugInteractionAlertCenterList() async {
    return ref.read(apiClientProvider).get('/v1/drug-interaction-alert-center');
  }

  /// Load Formulary Compliance Manager List Data
  /// Method: GET | Path: /v1/formulary-compliance-manager | Status: mocked
  Future<ApiResponse> loadApiV1FormularyComplianceManagerList() async {
    return ref.read(apiClientProvider).get('/v1/formulary-compliance-manager');
  }

  /// Create New Formulary Compliance Manager Record
  /// Method: POST | Path: /v1/formulary-compliance-manager | Status: mocked
  Future<ApiResponse> createApiV1FormularyComplianceManagerCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/formulary-compliance-manager', body: data);
  }

  /// Update Existing Formulary Compliance Manager Record
  /// Method: PATCH | Path: /v1/formulary-compliance-manager/:id | Status: mocked
  Future<ApiResponse> updateApiV1FormularyComplianceManagerUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/formulary-compliance-manager/$id', body: data);
  }

  /// Load Inpatient Pharmacy Queue List Data
  /// Method: GET | Path: /v1/inpatient-pharmacy-queue | Status: mocked
  Future<ApiResponse> loadApiV1InpatientPharmacyQueueList() async {
    return ref.read(apiClientProvider).get('/v1/inpatient-pharmacy-queue');
  }

  /// Load Medication Reconciliation Tool List Data
  /// Method: GET | Path: /v1/medication-reconciliation-tool | Status: mocked
  Future<ApiResponse> loadApiV1MedicationReconciliationToolList() async {
    return ref.read(apiClientProvider).get('/v1/medication-reconciliation-tool');
  }

  /// Load Outpatient Prescription Tracker List Data
  /// Method: GET | Path: /v1/outpatient-prescription-tracker | Status: mocked
  Future<ApiResponse> loadApiV1OutpatientPrescriptionTrackerList() async {
    return ref.read(apiClientProvider).get('/v1/outpatient-prescription-tracker');
  }

  /// Load Patient Medication Adherence List Data
  /// Method: GET | Path: /v1/patient-medication-adherence | Status: mocked
  Future<ApiResponse> loadApiV1PatientMedicationAdherenceList() async {
    return ref.read(apiClientProvider).get('/v1/patient-medication-adherence');
  }

  /// Load Pharmacy Dispensing List Data
  /// Method: GET | Path: /v1/pharmacy-dispensing | Status: mocked
  Future<ApiResponse> loadApiV1PharmacyDispensingList() async {
    return ref.read(apiClientProvider).get('/v1/pharmacy-dispensing');
  }

  /// Load Pharmacy Inventory Management List Data
  /// Method: GET | Path: /v1/pharmacy-inventory-management | Status: mocked
  Future<ApiResponse> loadApiV1PharmacyInventoryManagementList() async {
    return ref.read(apiClientProvider).get('/v1/pharmacy-inventory-management');
  }

  /// Create New Pharmacy Inventory Management Record
  /// Method: POST | Path: /v1/pharmacy-inventory-management | Status: mocked
  Future<ApiResponse> createApiV1PharmacyInventoryManagementCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/pharmacy-inventory-management', body: data);
  }

  /// Update Existing Pharmacy Inventory Management Record
  /// Method: PATCH | Path: /v1/pharmacy-inventory-management/:id | Status: mocked
  Future<ApiResponse> updateApiV1PharmacyInventoryManagementUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/pharmacy-inventory-management/$id', body: data);
  }

  /// Load Single Pharmacy Inventory Management Details
  /// Method: GET | Path: /v1/pharmacy-inventory-management/:id | Status: mocked
  Future<ApiResponse> loadApiV1PharmacyInventoryManagementDetail(String id) async {
    return ref.read(apiClientProvider).get('/v1/pharmacy-inventory-management/$id');
  }

  /// Delete Pharmacy Inventory Management Record
  /// Method: DELETE | Path: /v1/pharmacy-inventory-management/:id | Status: mocked
  Future<ApiResponse> deleteApiV1PharmacyInventoryManagementDelete(String id) async {
    return ref.read(apiClientProvider).delete('/v1/pharmacy-inventory-management/$id');
  }

  /// Load Community Health Needs Assessment List Data
  /// Method: GET | Path: /v1/community-health-needs-assessment | Status: mocked
  Future<ApiResponse> loadApiV1CommunityHealthNeedsAssessmentList() async {
    return ref.read(apiClientProvider).get('/v1/community-health-needs-assessment');
  }

  /// Load Environmental Health Hazards List Data
  /// Method: GET | Path: /v1/environmental-health-hazards | Status: mocked
  Future<ApiResponse> loadApiV1EnvironmentalHealthHazardsList() async {
    return ref.read(apiClientProvider).get('/v1/environmental-health-hazards');
  }

  /// Load Epidemiological Surveillance List Data
  /// Method: GET | Path: /v1/epidemiological-surveillance | Status: mocked
  Future<ApiResponse> loadApiV1EpidemiologicalSurveillanceList() async {
    return ref.read(apiClientProvider).get('/v1/epidemiological-surveillance');
  }

  /// Load Mobile Clinic Dispatch List Data
  /// Method: GET | Path: /v1/mobile-clinic-dispatch | Status: mocked
  Future<ApiResponse> loadApiV1MobileClinicDispatchList() async {
    return ref.read(apiClientProvider).get('/v1/mobile-clinic-dispatch');
  }

  /// Load Public Health Alert Broadcaster List Data
  /// Method: GET | Path: /v1/public-health-alert-broadcaster | Status: mocked
  Future<ApiResponse> loadApiV1PublicHealthAlertBroadcasterList() async {
    return ref.read(apiClientProvider).get('/v1/public-health-alert-broadcaster');
  }

  /// Load School Health Program List Data
  /// Method: GET | Path: /v1/school-health-program | Status: mocked
  Future<ApiResponse> loadApiV1SchoolHealthProgramList() async {
    return ref.read(apiClientProvider).get('/v1/school-health-program');
  }

  /// Load Social Determinants Of Health Tracker List Data
  /// Method: GET | Path: /v1/social-determinants-of-health-tracker | Status: mocked
  Future<ApiResponse> loadApiV1SocialDeterminantsOfHealthTrackerList() async {
    return ref.read(apiClientProvider).get('/v1/social-determinants-of-health-tracker');
  }

  /// Load Substance Abuse Prevention Tracker List Data
  /// Method: GET | Path: /v1/substance-abuse-prevention-tracker | Status: mocked
  Future<ApiResponse> loadApiV1SubstanceAbusePreventionTrackerList() async {
    return ref.read(apiClientProvider).get('/v1/substance-abuse-prevention-tracker');
  }

  /// Load Vaccination Campaign Manager List Data
  /// Method: GET | Path: /v1/vaccination-campaign-manager | Status: mocked
  Future<ApiResponse> loadApiV1VaccinationCampaignManagerList() async {
    return ref.read(apiClientProvider).get('/v1/vaccination-campaign-manager');
  }

  /// Load Vulnerable Population Registry List Data
  /// Method: GET | Path: /v1/vulnerable-population-registry | Status: mocked
  Future<ApiResponse> loadApiV1VulnerablePopulationRegistryList() async {
    return ref.read(apiClientProvider).get('/v1/vulnerable-population-registry');
  }

  /// Create New Vulnerable Population Registry Record
  /// Method: POST | Path: /v1/vulnerable-population-registry | Status: mocked
  Future<ApiResponse> createApiV1VulnerablePopulationRegistryCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/vulnerable-population-registry', body: data);
  }

  /// Update Existing Vulnerable Population Registry Record
  /// Method: PATCH | Path: /v1/vulnerable-population-registry/:id | Status: mocked
  Future<ApiResponse> updateApiV1VulnerablePopulationRegistryUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/vulnerable-population-registry/$id', body: data);
  }

  /// Load Adverse Event Reporting Portal List Data
  /// Method: GET | Path: /v1/adverse-event-reporting-portal | Status: mocked
  Future<ApiResponse> loadApiV1AdverseEventReportingPortalList() async {
    return ref.read(apiClientProvider).get('/v1/adverse-event-reporting-portal');
  }

  /// Load Biospecimen Inventory Tracker List Data
  /// Method: GET | Path: /v1/biospecimen-inventory-tracker | Status: mocked
  Future<ApiResponse> loadApiV1BiospecimenInventoryTrackerList() async {
    return ref.read(apiClientProvider).get('/v1/biospecimen-inventory-tracker');
  }

  /// Load Clinical Trial Recruitment List Data
  /// Method: GET | Path: /v1/clinical-trial-recruitment | Status: mocked
  Future<ApiResponse> loadApiV1ClinicalTrialRecruitmentList() async {
    return ref.read(apiClientProvider).get('/v1/clinical-trial-recruitment');
  }

  /// Load Grant Funding Allocation List Data
  /// Method: GET | Path: /v1/grant-funding-allocation | Status: mocked
  Future<ApiResponse> loadApiV1GrantFundingAllocationList() async {
    return ref.read(apiClientProvider).get('/v1/grant-funding-allocation');
  }

  /// Load Informed Consent Tracker List Data
  /// Method: GET | Path: /v1/informed-consent-tracker | Status: mocked
  Future<ApiResponse> loadApiV1InformedConsentTrackerList() async {
    return ref.read(apiClientProvider).get('/v1/informed-consent-tracker');
  }

  /// Create New Informed Consent Tracker Record
  /// Method: POST | Path: /v1/informed-consent-tracker | Status: mocked
  Future<ApiResponse> createApiV1InformedConsentTrackerCreate(dynamic data) async {
    return ref.read(apiClientProvider).post('/v1/informed-consent-tracker', body: data);
  }

  /// Update Existing Informed Consent Tracker Record
  /// Method: PATCH | Path: /v1/informed-consent-tracker/:id | Status: mocked
  Future<ApiResponse> updateApiV1InformedConsentTrackerUpdate(String id, dynamic data) async {
    return ref.read(apiClientProvider).patch('/v1/informed-consent-tracker/$id', body: data);
  }

  /// Load Multi Center Trial Collaboration List Data
  /// Method: GET | Path: /v1/multi-center-trial-collaboration | Status: mocked
  Future<ApiResponse> loadApiV1MultiCenterTrialCollaborationList() async {
    return ref.read(apiClientProvider).get('/v1/multi-center-trial-collaboration');
  }

  /// Load Patient Trial Outcomeser List Data
  /// Method: GET | Path: /v1/patient-trial-outcomeser | Status: mocked
  Future<ApiResponse> loadApiV1PatientTrialOutcomeserList() async {
    return ref.read(apiClientProvider).get('/v1/patient-trial-outcomeser');
  }

  /// Load Research Protocol Manager List Data
  /// Method: GET | Path: /v1/research-protocol-manager | Status: mocked
  Future<ApiResponse> loadApiV1ResearchProtocolManagerList() async {
    return ref.read(apiClientProvider).get('/v1/research-protocol-manager');
  }

  /// Load Research Publication Drafting List Data
  /// Method: GET | Path: /v1/research-publication-drafting | Status: mocked
  Future<ApiResponse> loadApiV1ResearchPublicationDraftingList() async {
    return ref.read(apiClientProvider).get('/v1/research-publication-drafting');
  }

  /// Load Trial Data Collection C R F List Data
  /// Method: GET | Path: /v1/trial-data-collection-c-r-f | Status: mocked
  Future<ApiResponse> loadApiV1TrialDataCollectionCRFList() async {
    return ref.read(apiClientProvider).get('/v1/trial-data-collection-c-r-f');
  }

  /// Load Asynchronous Consultation Inbox List Data
  /// Method: GET | Path: /v1/asynchronous-consultation-inbox | Status: mocked
  Future<ApiResponse> loadApiV1AsynchronousConsultationInboxList() async {
    return ref.read(apiClientProvider).get('/v1/asynchronous-consultation-inbox');
  }

  /// Load Chronic Care Management Tracker List Data
  /// Method: GET | Path: /v1/chronic-care-management-tracker | Status: mocked
  Future<ApiResponse> loadApiV1ChronicCareManagementTrackerList() async {
    return ref.read(apiClientProvider).get('/v1/chronic-care-management-tracker');
  }

  /// Load Device Integration Hub List Data
  /// Method: GET | Path: /v1/device-integration-hub | Status: mocked
  Future<ApiResponse> loadApiV1DeviceIntegrationHubList() async {
    return ref.read(apiClientProvider).get('/v1/device-integration-hub');
  }

  /// Load Digital Symptom Checker List Data
  /// Method: GET | Path: /v1/digital-symptom-checker | Status: mocked
  Future<ApiResponse> loadApiV1DigitalSymptomCheckerList() async {
    return ref.read(apiClientProvider).get('/v1/digital-symptom-checker');
  }

  /// Load Remote Diagnosticser List Data
  /// Method: GET | Path: /v1/remote-diagnosticser | Status: mocked
  Future<ApiResponse> loadApiV1RemoteDiagnosticserList() async {
    return ref.read(apiClientProvider).get('/v1/remote-diagnosticser');
  }

  /// Load Remote Patient Monitoring List Data
  /// Method: GET | Path: /v1/remote-patient-monitoring | Status: mocked
  Future<ApiResponse> loadApiV1RemotePatientMonitoringList() async {
    return ref.read(apiClientProvider).get('/v1/remote-patient-monitoring');
  }

  /// Load Telehealth Consultation Room List Data
  /// Method: GET | Path: /v1/telehealth-consultation-room | Status: mocked
  Future<ApiResponse> loadApiV1TelehealthConsultationRoomList() async {
    return ref.read(apiClientProvider).get('/v1/telehealth-consultation-room');
  }

  /// Load Telehealth Quality Metrics List Data
  /// Method: GET | Path: /v1/telehealth-quality-metrics | Status: mocked
  Future<ApiResponse> loadApiV1TelehealthQualityMetricsList() async {
    return ref.read(apiClientProvider).get('/v1/telehealth-quality-metrics');
  }

  /// Load Telemedicine Prescription Pad List Data
  /// Method: GET | Path: /v1/telemedicine-prescription-pad | Status: mocked
  Future<ApiResponse> loadApiV1TelemedicinePrescriptionPadList() async {
    return ref.read(apiClientProvider).get('/v1/telemedicine-prescription-pad');
  }

  /// Load Virtual Waiting Room List Data
  /// Method: GET | Path: /v1/virtual-waiting-room | Status: mocked
  Future<ApiResponse> loadApiV1VirtualWaitingRoomList() async {
    return ref.read(apiClientProvider).get('/v1/virtual-waiting-room');
  }

  /// Load Not Implemented List Data
  /// Method: GET | Path: /v1/not-implemented | Status: mocked
  Future<ApiResponse> loadApiV1NotImplementedList() async {
    return ref.read(apiClientProvider).get('/v1/not-implemented');
  }

  /// Load Progress List Data
  /// Method: GET | Path: /v1/progress | Status: mocked
  Future<ApiResponse> loadApiV1ProgressList() async {
    return ref.read(apiClientProvider).get('/v1/progress');
  }

  /// Load Admin Health List Data
  /// Method: GET | Path: /v1/admin-health | Status: mocked
  Future<ApiResponse> loadApiV1AdminHealthList() async {
    return ref.read(apiClientProvider).get('/v1/admin-health');
  }
}

/// Provider to access the GeneratedApiClient instance
final generatedApiClientProvider = Provider<GeneratedApiClient>((ref) {
  return GeneratedApiClient(ref);
});
