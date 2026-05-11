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
  governanceOfficer,
  headOfBusDev,
  headOfMarketing,
  trainingDirector,
  financeDirector,
  scrumMaster,
  hrDirector,
  cxDirector,
  shareholder,
  legal,
  ciso,

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
  hrManager,
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
  rpn,
  rmt,
  chiropractor,
  physiotherapist,
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

  /// Returns the platform role from a name string (case-insensitive, handles snake_case).
  static PlatformRole fromName(String? roleName) {
    if (roleName == null || roleName.isEmpty) return PlatformRole.guest;

    final normalized = roleName.toLowerCase().replaceAll('_', '').replaceAll(' ', '');

    if (normalized == 'superadmin') return PlatformRole.admin;

    for (final role in PlatformRole.values) {
      if (role.name.toLowerCase() == normalized ||
          role.nameSnake.replaceAll('_', '') == normalized) {
        return role;
      }
    }

    return PlatformRole.guest;
  }

  /// Derives a categorical platform role from a route string.
  static PlatformRole fromRoute(String route) {
    final segments = route.split('/').where((s) => s.isNotEmpty).toSet();

    // First pass: look for explicit role matches (e.g. /roles/rpn/)
    for (final role in PlatformRole.values) {
      if (role == PlatformRole.unknown) continue;
      if (segments.contains(role.nameSnake)) {
        return role;
      }
    }

    // Second pass: category fallbacks
    if (route.contains('/clinical/')) return PlatformRole.clinical;
    if (route.contains('/offices/')) return PlatformRole.office;
    if (route.contains('/corporate/')) return PlatformRole.corporate;
    if (route.contains('/infrastructure/')) return PlatformRole.infrastructure;
    if (route.contains('/portal/')) return PlatformRole.portal;
    if (route.contains('/franchise/')) return PlatformRole.franchise;
    return PlatformRole.unknown;
  }
}
