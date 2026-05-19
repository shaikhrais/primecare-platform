// Layer: 01_INFRASTRUCTURE
import 'platform_role.dart';

/// Represents high-fidelity metadata for a specific platform role.
/// Centralizes access level controls, target dashboards, portals, and compliance routing.
class RoleMetadata {
  final PlatformRole role;
  
  /// The functional classification of the role
  /// E.g. 'Corporate', 'Business Development', 'Franchise', 'Clinical', 'Training/Architecture', 'Client Side', 'Infrastructure'
  final String category;
  
  /// Access control level: 'read', 'write', 'admin', 'compliance'
  final String accessLevel;
  
  /// Canonical identifier for the dashboard screen
  final String defaultDashboardId;
  
  /// Canonical identifier for the compliance/governance screen
  final String defaultComplianceId;
  
  /// Canonical identifier for the application/portal hosting the role
  final String defaultPortal;
  
  /// Set of dashboards this role is authorized to view
  final List<String> allowedDashboardIds;
  
  /// Set of compliance screens this role is authorized to view
  final List<String> allowedComplianceIds;

  const RoleMetadata({
    required this.role,
    required this.category,
    required this.accessLevel,
    required this.defaultDashboardId,
    required this.defaultComplianceId,
    required this.defaultPortal,
    this.allowedDashboardIds = const [],
    this.allowedComplianceIds = const [],
  });

  /// True if the role possesses administrative permissions.
  bool get isAdmin => accessLevel == 'admin';

  /// True if the role possesses compliance-level auditing permissions.
  bool get isCompliance => accessLevel == 'compliance' || accessLevel == 'admin';

  /// Returns the human-readable description of this role's purpose.
  String get description => 
      '${role.displayName} is a $category role with $accessLevel access inside $defaultPortal.';
}

/// Authoritative single source of truth for all Platform Roles and their capabilities.
/// Reconciles platform role taxonomy with routing infrastructure to eliminate drift.
class RoleRegistry {
  static final Map<PlatformRole, RoleMetadata> _registry = {
    // === Corporate Leadership (17 Roles) ===
    PlatformRole.ceo: const RoleMetadata(
      role: PlatformRole.ceo,
      category: 'Corporate',
      accessLevel: 'admin',
      defaultDashboardId: 'CEO_DASHBOARD',
      defaultComplianceId: 'CEO_COMPLIANCE',
      defaultPortal: 'prime_corporate',
      allowedDashboardIds: ['CEO_DASHBOARD', 'COO_DASHBOARD', 'CFO_DASHBOARD'],
    ),
    PlatformRole.coo: const RoleMetadata(
      role: PlatformRole.coo,
      category: 'Corporate',
      accessLevel: 'admin',
      defaultDashboardId: 'COO_DASHBOARD',
      defaultComplianceId: 'COO_COMPLIANCE',
      defaultPortal: 'prime_corporate',
    ),
    PlatformRole.cfo: const RoleMetadata(
      role: PlatformRole.cfo,
      category: 'Corporate',
      accessLevel: 'admin',
      defaultDashboardId: 'CFO_DASHBOARD',
      defaultComplianceId: 'CFO_COMPLIANCE',
      defaultPortal: 'prime_corporate',
    ),
    PlatformRole.cto: const RoleMetadata(
      role: PlatformRole.cto,
      category: 'Corporate',
      accessLevel: 'admin',
      defaultDashboardId: 'CTO_DASHBOARD',
      defaultComplianceId: 'CTO_COMPLIANCE',
      defaultPortal: 'prime_corporate',
    ),
    PlatformRole.complianceManager: const RoleMetadata(
      role: PlatformRole.complianceManager,
      category: 'Corporate',
      accessLevel: 'compliance',
      defaultDashboardId: 'COMPLIANCEMANAGER_DASHBOARD',
      defaultComplianceId: 'COMPLIANCEMANAGER_COMPLIANCE',
      defaultPortal: 'primecare_governance',
    ),
    PlatformRole.governanceOfficer: const RoleMetadata(
      role: PlatformRole.governanceOfficer,
      category: 'Corporate',
      accessLevel: 'compliance',
      defaultDashboardId: 'GOVERNANCEOFFICER_DASHBOARD',
      defaultComplianceId: 'GOVERNANCEOFFICER_COMPLIANCE',
      defaultPortal: 'primecare_governance',
    ),
    PlatformRole.headOfBusDev: const RoleMetadata(
      role: PlatformRole.headOfBusDev,
      category: 'Corporate',
      accessLevel: 'write',
      defaultDashboardId: 'HEADOFBUSDEV_DASHBOARD',
      defaultComplianceId: 'HEADOFBUSDEV_COMPLIANCE',
      defaultPortal: 'prime_business_development',
    ),
    PlatformRole.headOfMarketing: const RoleMetadata(
      role: PlatformRole.headOfMarketing,
      category: 'Corporate',
      accessLevel: 'write',
      defaultDashboardId: 'HEADOFMARKETING_DASHBOARD',
      defaultComplianceId: 'HEADOFMARKETING_COMPLIANCE',
      defaultPortal: 'prime_marketing',
    ),
    PlatformRole.trainingDirector: const RoleMetadata(
      role: PlatformRole.trainingDirector,
      category: 'Corporate',
      accessLevel: 'write',
      defaultDashboardId: 'TRAININGDIRECTOR_DASHBOARD',
      defaultComplianceId: 'TRAININGDIRECTOR_COMPLIANCE',
      defaultPortal: 'prime_workflows_forms',
    ),
    PlatformRole.financeDirector: const RoleMetadata(
      role: PlatformRole.financeDirector,
      category: 'Corporate',
      accessLevel: 'admin',
      defaultDashboardId: 'FINANCEDIRECTOR_DASHBOARD',
      defaultComplianceId: 'FINANCEDIRECTOR_COMPLIANCE',
      defaultPortal: 'prime_finance',
    ),
    PlatformRole.scrumMaster: const RoleMetadata(
      role: PlatformRole.scrumMaster,
      category: 'Corporate',
      accessLevel: 'write',
      defaultDashboardId: 'SCRUMMASTER_DASHBOARD',
      defaultComplianceId: 'SCRUMMASTER_COMPLIANCE',
      defaultPortal: 'prime_corporate',
    ),
    PlatformRole.hrDirector: const RoleMetadata(
      role: PlatformRole.hrDirector,
      category: 'Corporate',
      accessLevel: 'write',
      defaultDashboardId: 'HRDIRECTOR_DASHBOARD',
      defaultComplianceId: 'HRDIRECTOR_COMPLIANCE',
      defaultPortal: 'prime_corporate',
    ),
    PlatformRole.cxDirector: const RoleMetadata(
      role: PlatformRole.cxDirector,
      category: 'Corporate',
      accessLevel: 'write',
      defaultDashboardId: 'CXDIRECTOR_DASHBOARD',
      defaultComplianceId: 'CXDIRECTOR_COMPLIANCE',
      defaultPortal: 'prime_corporate',
    ),
    PlatformRole.shareholder: const RoleMetadata(
      role: PlatformRole.shareholder,
      category: 'Corporate',
      accessLevel: 'read',
      defaultDashboardId: 'SHAREHOLDER_DASHBOARD',
      defaultComplianceId: 'SHAREHOLDER_COMPLIANCE',
      defaultPortal: 'prime_corporate',
    ),
    PlatformRole.legal: const RoleMetadata(
      role: PlatformRole.legal,
      category: 'Corporate',
      accessLevel: 'compliance',
      defaultDashboardId: 'LEGAL_DASHBOARD',
      defaultComplianceId: 'LEGAL_COMPLIANCE',
      defaultPortal: 'prime_corporate',
    ),
    PlatformRole.ciso: const RoleMetadata(
      role: PlatformRole.ciso,
      category: 'Corporate',
      accessLevel: 'admin',
      defaultDashboardId: 'CISO_DASHBOARD',
      defaultComplianceId: 'CISO_COMPLIANCE',
      defaultPortal: 'prime_corporate',
    ),
    PlatformRole.itAdmin: const RoleMetadata(
      role: PlatformRole.itAdmin,
      category: 'Corporate',
      accessLevel: 'admin',
      defaultDashboardId: 'ITADMIN_DASHBOARD',
      defaultComplianceId: 'ITADMIN_COMPLIANCE',
      defaultPortal: 'primecare_admin',
    ),

    // === Business Development (10 Roles) ===
    PlatformRole.regionalManagerOntario: const RoleMetadata(
      role: PlatformRole.regionalManagerOntario,
      category: 'Business Development',
      accessLevel: 'admin',
      defaultDashboardId: 'REGIONALMANAGERONTARIO_DASHBOARD',
      defaultComplianceId: 'REGIONALMANAGERONTARIO_COMPLIANCE',
      defaultPortal: 'prime_finance',
    ),
    PlatformRole.regionalManagerUsa: const RoleMetadata(
      role: PlatformRole.regionalManagerUsa,
      category: 'Business Development',
      accessLevel: 'admin',
      defaultDashboardId: 'REGIONALMANAGERUSA_DASHBOARD',
      defaultComplianceId: 'REGIONALMANAGERUSA_COMPLIANCE',
      defaultPortal: 'prime_business_development',
    ),
    PlatformRole.regionalBdm: const RoleMetadata(
      role: PlatformRole.regionalBdm,
      category: 'Business Development',
      accessLevel: 'write',
      defaultDashboardId: 'REGIONALBDM_DASHBOARD',
      defaultComplianceId: 'REGIONALBDM_COMPLIANCE',
      defaultPortal: 'prime_business_development',
    ),
    PlatformRole.franchiseSalesManager: const RoleMetadata(
      role: PlatformRole.franchiseSalesManager,
      category: 'Business Development',
      accessLevel: 'write',
      defaultDashboardId: 'FRANCHISESALESMANAGER_DASHBOARD',
      defaultComplianceId: 'FRANCHISESALESMANAGER_COMPLIANCE',
      defaultPortal: 'prime_business_development',
    ),
    PlatformRole.partnershipManager: const RoleMetadata(
      role: PlatformRole.partnershipManager,
      category: 'Business Development',
      accessLevel: 'write',
      defaultDashboardId: 'PARTNERSHIPMANAGER_DASHBOARD',
      defaultComplianceId: 'PARTNERSHIPMANAGER_COMPLIANCE',
      defaultPortal: 'prime_business_development',
    ),
    PlatformRole.territoryExpansionManager: const RoleMetadata(
      role: PlatformRole.territoryExpansionManager,
      category: 'Business Development',
      accessLevel: 'write',
      defaultDashboardId: 'TERRITORYEXPANSIONMANAGER_DASHBOARD',
      defaultComplianceId: 'TERRITORYEXPANSIONMANAGER_COMPLIANCE',
      defaultPortal: 'prime_business_development',
    ),
    PlatformRole.territorySalesManager: const RoleMetadata(
      role: PlatformRole.territorySalesManager,
      category: 'Business Development',
      accessLevel: 'write',
      defaultDashboardId: 'TERRITORYSALESMANAGER_DASHBOARD',
      defaultComplianceId: 'TERRITORYSALESMANAGER_COMPLIANCE',
      defaultPortal: 'prime_business_development',
    ),
    PlatformRole.generalManager: const RoleMetadata(
      role: PlatformRole.generalManager,
      category: 'Business Development',
      accessLevel: 'admin',
      defaultDashboardId: 'GENERALMANAGER_DASHBOARD',
      defaultComplianceId: 'GENERALMANAGER_COMPLIANCE',
      defaultPortal: 'prime_business_development',
    ),
    PlatformRole.localMarketingManager: const RoleMetadata(
      role: PlatformRole.localMarketingManager,
      category: 'Business Development',
      accessLevel: 'write',
      defaultDashboardId: 'LOCALMARKETINGMANAGER_DASHBOARD',
      defaultComplianceId: 'LOCALMARKETINGMANAGER_COMPLIANCE',
      defaultPortal: 'prime_marketing',
    ),
    PlatformRole.communityOutreach: const RoleMetadata(
      role: PlatformRole.communityOutreach,
      category: 'Business Development',
      accessLevel: 'write',
      defaultDashboardId: 'COMMUNITYOUTREACH_DASHBOARD',
      defaultComplianceId: 'COMMUNITYOUTREACH_COMPLIANCE',
      defaultPortal: 'prime_marketing',
    ),

    // === Franchise Tier (7 Roles) ===
    PlatformRole.franchiseOwner: const RoleMetadata(
      role: PlatformRole.franchiseOwner,
      category: 'Franchise',
      accessLevel: 'admin',
      defaultDashboardId: 'FRANCHISEOWNER_DASHBOARD',
      defaultComplianceId: 'FRANCHISEOWNER_COMPLIANCE',
      defaultPortal: 'prime_franchise',
    ),
    PlatformRole.operationsManager: const RoleMetadata(
      role: PlatformRole.operationsManager,
      category: 'Franchise',
      accessLevel: 'write',
      defaultDashboardId: 'OPERATIONSMANAGER_DASHBOARD',
      defaultComplianceId: 'OPERATIONSMANAGER_COMPLIANCE',
      defaultPortal: 'prime_franchise',
    ),
    PlatformRole.scheduler: const RoleMetadata(
      role: PlatformRole.scheduler,
      category: 'Franchise',
      accessLevel: 'write',
      defaultDashboardId: 'SCHEDULER_DASHBOARD',
      defaultComplianceId: 'SCHEDULER_COMPLIANCE',
      defaultPortal: 'prime_franchise',
    ),
    PlatformRole.billingAdmin: const RoleMetadata(
      role: PlatformRole.billingAdmin,
      category: 'Franchise',
      accessLevel: 'write',
      defaultDashboardId: 'BILLINGADMIN_DASHBOARD',
      defaultComplianceId: 'BILLINGADMIN_COMPLIANCE',
      defaultPortal: 'prime_franchise',
    ),
    PlatformRole.hrHiring: const RoleMetadata(
      role: PlatformRole.hrHiring,
      category: 'Franchise',
      accessLevel: 'write',
      defaultDashboardId: 'HRHIRING_DASHBOARD',
      defaultComplianceId: 'HRHIRING_COMPLIANCE',
      defaultPortal: 'prime_franchise',
    ),
    PlatformRole.hrManager: const RoleMetadata(
      role: PlatformRole.hrManager,
      category: 'Franchise',
      accessLevel: 'write',
      defaultDashboardId: 'HRMANAGER_DASHBOARD',
      defaultComplianceId: 'HRMANAGER_COMPLIANCE',
      defaultPortal: 'prime_franchise',
    ),
    PlatformRole.owner: const RoleMetadata(
      role: PlatformRole.owner,
      category: 'Franchise',
      accessLevel: 'admin',
      defaultDashboardId: 'OWNER_DASHBOARD',
      defaultComplianceId: 'OWNER_COMPLIANCE',
      defaultPortal: 'prime_franchise',
    ),

    // === Clinical & Support (19 Roles) ===
    PlatformRole.clinicalDirector: const RoleMetadata(
      role: PlatformRole.clinicalDirector,
      category: 'Clinical',
      accessLevel: 'admin',
      defaultDashboardId: 'CLINICALDIRECTOR_DASHBOARD',
      defaultComplianceId: 'CLINICALDIRECTOR_COMPLIANCE',
      defaultPortal: 'prime_clinical',
    ),
    PlatformRole.intakeCoordinator: const RoleMetadata(
      role: PlatformRole.intakeCoordinator,
      category: 'Clinical',
      accessLevel: 'write',
      defaultDashboardId: 'INTAKECOORDINATOR_DASHBOARD',
      defaultComplianceId: 'INTAKECOORDINATOR_COMPLIANCE',
      defaultPortal: 'prime_clinical',
    ),
    PlatformRole.qualityAssurance: const RoleMetadata(
      role: PlatformRole.qualityAssurance,
      category: 'Clinical',
      accessLevel: 'compliance',
      defaultDashboardId: 'QUALITYASSURANCE_DASHBOARD',
      defaultComplianceId: 'QUALITYASSURANCE_COMPLIANCE',
      defaultPortal: 'prime_clinical',
    ),
    PlatformRole.trainingCoordinator: const RoleMetadata(
      role: PlatformRole.trainingCoordinator,
      category: 'Clinical',
      accessLevel: 'write',
      defaultDashboardId: 'TRAININGCOORDINATOR_DASHBOARD',
      defaultComplianceId: 'TRAININGCOORDINATOR_COMPLIANCE',
      defaultPortal: 'prime_workflows_forms',
    ),
    PlatformRole.volunteerCoordinator: const RoleMetadata(
      role: PlatformRole.volunteerCoordinator,
      category: 'Clinical',
      accessLevel: 'write',
      defaultDashboardId: 'VOLUNTEERCOORDINATOR_DASHBOARD',
      defaultComplianceId: 'VOLUNTEERCOORDINATOR_COMPLIANCE',
      defaultPortal: 'prime_clinical',
    ),
    PlatformRole.receptionist: const RoleMetadata(
      role: PlatformRole.receptionist,
      category: 'Clinical',
      accessLevel: 'read',
      defaultDashboardId: 'RECEPTIONIST_DASHBOARD',
      defaultComplianceId: 'RECEPTIONIST_COMPLIANCE',
      defaultPortal: 'prime_clinical',
    ),
    PlatformRole.psw: const RoleMetadata(
      role: PlatformRole.psw,
      category: 'Clinical',
      accessLevel: 'write',
      defaultDashboardId: 'PSW_DASHBOARD',
      defaultComplianceId: 'PSW_COMPLIANCE',
      defaultPortal: 'prime_clinical',
    ),
    PlatformRole.rn: const RoleMetadata(
      role: PlatformRole.rn,
      category: 'Clinical',
      accessLevel: 'write',
      defaultDashboardId: 'RN_DASHBOARD',
      defaultComplianceId: 'RN_COMPLIANCE',
      defaultPortal: 'prime_clinical',
    ),
    PlatformRole.rpn: const RoleMetadata(
      role: PlatformRole.rpn,
      category: 'Clinical',
      accessLevel: 'write',
      defaultDashboardId: 'RPN_DASHBOARD',
      defaultComplianceId: 'RPN_COMPLIANCE',
      defaultPortal: 'prime_clinical',
    ),
    PlatformRole.rmt: const RoleMetadata(
      role: PlatformRole.rmt,
      category: 'Clinical',
      accessLevel: 'write',
      defaultDashboardId: 'RMT_DASHBOARD',
      defaultComplianceId: 'RMT_COMPLIANCE',
      defaultPortal: 'prime_clinical',
    ),
    PlatformRole.chiropractor: const RoleMetadata(
      role: PlatformRole.chiropractor,
      category: 'Clinical',
      accessLevel: 'write',
      defaultDashboardId: 'CHIROPRACTOR_DASHBOARD',
      defaultComplianceId: 'CHIROPRACTOR_COMPLIANCE',
      defaultPortal: 'prime_clinical',
    ),
    PlatformRole.physiotherapist: const RoleMetadata(
      role: PlatformRole.physiotherapist,
      category: 'Clinical',
      accessLevel: 'write',
      defaultDashboardId: 'PHYSIOTHERAPIST_DASHBOARD',
      defaultComplianceId: 'PHYSIOTHERAPIST_COMPLIANCE',
      defaultPortal: 'prime_clinical',
    ),
    PlatformRole.socialWorker: const RoleMetadata(
      role: PlatformRole.socialWorker,
      category: 'Clinical',
      accessLevel: 'write',
      defaultDashboardId: 'SOCIALWORKER_DASHBOARD',
      defaultComplianceId: 'SOCIALWORKER_COMPLIANCE',
      defaultPortal: 'prime_clinical',
    ),
    PlatformRole.clinic: const RoleMetadata(
      role: PlatformRole.clinic,
      category: 'Clinical',
      accessLevel: 'write',
      defaultDashboardId: 'CLINIC_DASHBOARD',
      defaultComplianceId: 'CLINIC_COMPLIANCE',
      defaultPortal: 'prime_clinical',
    ),
    PlatformRole.patient: const RoleMetadata(
      role: PlatformRole.patient,
      category: 'Clinical',
      accessLevel: 'read',
      defaultDashboardId: 'PATIENT_DASHBOARD',
      defaultComplianceId: 'PATIENT_COMPLIANCE',
      defaultPortal: 'prime_client_portal',
    ),
    PlatformRole.customerSupport: const RoleMetadata(
      role: PlatformRole.customerSupport,
      category: 'Clinical',
      accessLevel: 'write',
      defaultDashboardId: 'CUSTOMERSUPPORT_DASHBOARD',
      defaultComplianceId: 'CUSTOMERSUPPORT_COMPLIANCE',
      defaultPortal: 'prime_support',
    ),
    PlatformRole.intake: const RoleMetadata(
      role: PlatformRole.intake,
      category: 'Clinical',
      accessLevel: 'write',
      defaultDashboardId: 'INTAKE_DASHBOARD',
      defaultComplianceId: 'INTAKE_COMPLIANCE',
      defaultPortal: 'prime_clinical',
    ),
    PlatformRole.qa: const RoleMetadata(
      role: PlatformRole.qa,
      category: 'Clinical',
      accessLevel: 'compliance',
      defaultDashboardId: 'QA_DASHBOARD',
      defaultComplianceId: 'QA_COMPLIANCE',
      defaultPortal: 'prime_clinical',
    ),
    PlatformRole.support: const RoleMetadata(
      role: PlatformRole.support,
      category: 'Clinical',
      accessLevel: 'write',
      defaultDashboardId: 'SUPPORT_DASHBOARD',
      defaultComplianceId: 'SUPPORT_COMPLIANCE',
      defaultPortal: 'prime_support',
    ),

    // === Training & Architecture (6 Roles) ===
    PlatformRole.trainingDirectorCertificate: const RoleMetadata(
      role: PlatformRole.trainingDirectorCertificate,
      category: 'Training/Architecture',
      accessLevel: 'write',
      defaultDashboardId: 'TRAININGDIRECTORCERTIFICATE_DASHBOARD',
      defaultComplianceId: 'TRAININGDIRECTORCERTIFICATE_COMPLIANCE',
      defaultPortal: 'prime_workflows_forms',
    ),
    PlatformRole.trainingHub: const RoleMetadata(
      role: PlatformRole.trainingHub,
      category: 'Training/Architecture',
      accessLevel: 'read',
      defaultDashboardId: 'TRAININGHUB_DASHBOARD',
      defaultComplianceId: 'TRAININGHUB_COMPLIANCE',
      defaultPortal: 'prime_workflows_forms',
    ),
    PlatformRole.courseArchitect: const RoleMetadata(
      role: PlatformRole.courseArchitect,
      category: 'Training/Architecture',
      accessLevel: 'write',
      defaultDashboardId: 'COURSEARCHITECT_DASHBOARD',
      defaultComplianceId: 'COURSEARCHITECT_COMPLIANCE',
      defaultPortal: 'prime_workflows_forms',
    ),
    PlatformRole.architecturePlanning: const RoleMetadata(
      role: PlatformRole.architecturePlanning,
      category: 'Training/Architecture',
      accessLevel: 'admin',
      defaultDashboardId: 'ARCHITECTUREPLANNING_DASHBOARD',
      defaultComplianceId: 'ARCHITECTUREPLANNING_COMPLIANCE',
      defaultPortal: 'prime_corporate',
    ),
    PlatformRole.systemVerification: const RoleMetadata(
      role: PlatformRole.systemVerification,
      category: 'Training/Architecture',
      accessLevel: 'admin',
      defaultDashboardId: 'SYSTEMVERIFICATION_DASHBOARD',
      defaultComplianceId: 'SYSTEMVERIFICATION_COMPLIANCE',
      defaultPortal: 'primecare_governance',
    ),
    PlatformRole.dynamicScreen: const RoleMetadata(
      role: PlatformRole.dynamicScreen,
      category: 'Training/Architecture',
      accessLevel: 'write',
      defaultDashboardId: 'DYNAMICSCREEN_DASHBOARD',
      defaultComplianceId: 'DYNAMICSCREEN_COMPLIANCE',
      defaultPortal: 'primecare_governance',
    ),

    // === Client Side (3 Roles) ===
    PlatformRole.client: const RoleMetadata(
      role: PlatformRole.client,
      category: 'Client Side',
      accessLevel: 'read',
      defaultDashboardId: 'CLIENT_DASHBOARD',
      defaultComplianceId: 'CLIENT_COMPLIANCE',
      defaultPortal: 'prime_client_portal',
    ),
    PlatformRole.familyMember: const RoleMetadata(
      role: PlatformRole.familyMember,
      category: 'Client Side',
      accessLevel: 'read',
      defaultDashboardId: 'FAMILYMEMBER_DASHBOARD',
      defaultComplianceId: 'FAMILYMEMBER_COMPLIANCE',
      defaultPortal: 'prime_client_portal',
    ),
    PlatformRole.guest: const RoleMetadata(
      role: PlatformRole.guest,
      category: 'Client Side',
      accessLevel: 'read',
      defaultDashboardId: 'GUEST_DASHBOARD',
      defaultComplianceId: 'GUEST_COMPLIANCE',
      defaultPortal: 'prime_client_portal',
    ),

    // === Infrastructure (2 Roles) ===
    PlatformRole.admin: const RoleMetadata(
      role: PlatformRole.admin,
      category: 'Infrastructure',
      accessLevel: 'admin',
      defaultDashboardId: 'ADMIN_DASHBOARD',
      defaultComplianceId: 'ADMIN_COMPLIANCE',
      defaultPortal: 'primecare_admin',
    ),
    PlatformRole.system: const RoleMetadata(
      role: PlatformRole.system,
      category: 'Infrastructure',
      accessLevel: 'admin',
      defaultDashboardId: 'SYSTEM_DASHBOARD',
      defaultComplianceId: 'SYSTEM_COMPLIANCE',
      defaultPortal: 'primecare_governance',
    ),
  };

  /// Retrieves metadata for a specific PlatformRole.
  static RoleMetadata? getMetadata(PlatformRole role) {
    return _registry[role];
  }

  /// Retrieves all registered primary roles and their configurations.
  static List<RoleMetadata> getAllRoles() {
    return _registry.values.toList();
  }

  /// Filters roles by their category.
  static List<RoleMetadata> getRolesByCategory(String category) {
    return _registry.values.where((m) => m.category.toLowerCase() == category.toLowerCase()).toList();
  }

  /// Filters roles by their portal hosting.
  static List<RoleMetadata> getRolesByPortal(String portal) {
    return _registry.values.where((m) => m.defaultPortal.toLowerCase() == portal.toLowerCase()).toList();
  }

  /// Audit check to ensure complete coverage of PlatformRoles.
  /// Ignores helper category roles.
  static bool verifyCompleteCoverage() {
    final primaryRoles = PlatformRole.values.where((r) =>
      r != PlatformRole.unknown &&
      r.index < PlatformRole.corporate.index
    );

    for (final role in primaryRoles) {
      if (!_registry.containsKey(role)) {
        return false;
      }
    }
    return true;
  }
}
