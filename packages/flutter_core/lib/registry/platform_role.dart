// Layer: 01_INFRASTRUCTURE
library;

/// High-fidelity enum representing all supported primary roles across the PrimeCare Platform.
/// This enum is the source of truth for Governance, Navigation, and Security.
enum PlatformRole {
  // Corporate Leadership
  ceo,
  coo,
  cfo,
  cto,
  complianceManager,
  headOfBusDev,
  headOfMarketing,
  trainingDirector,
  financeDirector,
  scrumMaster,
  hrDirector,
  cxDirector,
  shareholder,

  // Business Development
  regionalManagerOntario,
  regionalManagerUsa,
  regionalBdm,
  franchiseSalesManager,
  partnershipManager,
  territoryExpansionManager,
  territorySalesManager,
  generalManager,
  localMarketingManager,
  communityOutreach,

  // Franchise Tier
  franchiseOwner,
  operationsManager,
  scheduler,
  billingAdmin,
  hrHiring,
  owner,

  // Clinical & Support
  clinicalDirector,
  intakeCoordinator,
  qualityAssurance,
  trainingCoordinator,
  volunteerCoordinator,
  receptionist,
  psw,
  rn,
  rmt,
  socialWorker,
  clinic,
  patient,
  customerSupport,
  intake,
  qa,
  support,

  // Training & Architecture
  trainingDirectorCertificate,
  trainingHub,
  courseArchitect,
  architecturePlanning,
  systemVerification,
  dynamicScreen,

  // Client Side
  client,
  familyMember,
  guest,

  // Infrastructure
  admin,
  system,

  // Base/Category Roles (for grouping access)
  corporate,
  franchise,
  office,
  clinical,
  portal,
  infrastructure,
  businessDevelopment,

  unknown;

  /// Returns the canonical snake_case string for the role.
  String get nameSnake => name.replaceAllMapped(
    RegExp(r'([A-Z])'),
    (m) => '_${m[1]!.toLowerCase()}',
  );

  /// Returns the human-readable display name.
  String get displayName {
    final words = name.split(RegExp(r'(?=[A-Z])'));
    return words.map((w) => w[0].toUpperCase() + w.substring(1)).join(' ');
  }

  /// Derives a categorical platform role from a route string.
  static PlatformRole fromRoute(String route) {
    if (route.contains('/clinical/')) return PlatformRole.clinical;
    if (route.contains('/offices/')) return PlatformRole.office;
    if (route.contains('/corporate/')) return PlatformRole.corporate;
    if (route.contains('/infrastructure/')) return PlatformRole.infrastructure;
    if (route.contains('/portal/')) return PlatformRole.portal;
    if (route.contains('/franchise/')) return PlatformRole.franchise;
    return PlatformRole.unknown;
  }
}
