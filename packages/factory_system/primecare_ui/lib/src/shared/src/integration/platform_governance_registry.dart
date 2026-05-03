// Layer: 00_GOVERNANCE_MANIFEST
// Generated: 2026-04-30T09:37:42.886699
// Architecture: Immutable Platform Master Registry

class PlatformGovernanceRegistry {
  static const String buildVersion = '4.5.0-SYNC';
  static const String buildSignature = 'UNIVERSAL-LOCK-STABLE';

  // --- VOLUMETRIC METRICS (LOC) ---
  static const Map<PlatformProject, int> projectLocManifest = {
    PlatformProject.governanceApp: 377587,
    PlatformProject.corporateApp: 141489,
    PlatformProject.franchiseApp: 129131,
    PlatformProject.clinicApp: 126193,
    PlatformProject.uiFactory: 49926,
    PlatformProject.marketingApp: 129082,
    PlatformProject.businessDevApp: 129087,
    PlatformProject.supportApp: 129088,
    PlatformProject.clientApp: 129097,
    PlatformProject.flutterCore: 10129,
    PlatformProject.enterpriseBlueprintApp: 152,
    PlatformProject.verificationService: 367521,
    PlatformProject.apiGateway: 234483,
    PlatformProject.authApi: 2078,
    PlatformProject.billingApi: 671,
    PlatformProject.clientApi: 5355,
    PlatformProject.complianceApi: 13104,
    PlatformProject.franchiseReportingApi: 1932,
    PlatformProject.governanceApi: 457,
    PlatformProject.governanceService: 1000,
    PlatformProject.notesApi: 595,
    PlatformProject.notificationApi: 274,
    PlatformProject.providerApi: 3431,
    PlatformProject.schedulingApi: 1040,
    PlatformProject.visitApi: 92,
  };

  // --- VOLUMETRIC METRICS (FILE COUNTS) ---
  static const Map<PlatformProject, int> projectFileManifest = {
    PlatformProject.governanceApp: 419,
    PlatformProject.corporateApp: 17,
    PlatformProject.franchiseApp: 16,
    PlatformProject.clinicApp: 18,
    PlatformProject.uiFactory: 926,
    PlatformProject.marketingApp: 16,
    PlatformProject.businessDevApp: 16,
    PlatformProject.supportApp: 16,
    PlatformProject.clientApp: 16,
    PlatformProject.flutterCore: 99,
    PlatformProject.enterpriseBlueprintApp: 2,
    PlatformProject.verificationService: 47,
    PlatformProject.apiGateway: 91,
    PlatformProject.authApi: 25,
    PlatformProject.billingApi: 10,
    PlatformProject.clientApi: 80,
    PlatformProject.complianceApi: 143,
    PlatformProject.franchiseReportingApi: 35,
    PlatformProject.governanceApi: 6,
    PlatformProject.governanceService: 5,
    PlatformProject.notesApi: 8,
    PlatformProject.notificationApi: 4,
    PlatformProject.providerApi: 40,
    PlatformProject.schedulingApi: 11,
    PlatformProject.visitApi: 4,
  };

  // --- MVC MANIFEST (UI TIER) ---
  static const Map<PlatformProject, Map<String, int>> uiMvcManifest = {
    PlatformProject.governanceApp: {'M': 1, 'V': 22, 'C': 8},
    PlatformProject.corporateApp: {'M': 1, 'V': 1, 'C': 1},
    PlatformProject.franchiseApp: {'M': 1, 'V': 1, 'C': 1},
    PlatformProject.clinicApp: {'M': 1, 'V': 1, 'C': 1},
    PlatformProject.uiFactory: {'M': 381, 'V': 165, 'C': 88},
    PlatformProject.marketingApp: {'M': 1, 'V': 1, 'C': 1},
    PlatformProject.businessDevApp: {'M': 1, 'V': 1, 'C': 1},
    PlatformProject.supportApp: {'M': 1, 'V': 1, 'C': 1},
    PlatformProject.clientApp: {'M': 1, 'V': 1, 'C': 1},
    PlatformProject.flutterCore: {'M': 1, 'V': 1, 'C': 1},
    PlatformProject.enterpriseBlueprintApp: {'M': 1, 'V': 1, 'C': 1},
    PlatformProject.verificationService: {'M': 1, 'V': 1, 'C': 1},
    PlatformProject.governanceService: {'M': 1, 'V': 1, 'C': 1},
  };

  // --- MVC MANIFEST (API TIER) ---
  static const Map<PlatformProject, Map<String, int>> apiMvcManifest = {
    PlatformProject.apiGateway: {'M': 1, 'V': 0, 'C': 1},
    PlatformProject.authApi: {'M': 1, 'V': 0, 'C': 1},
    PlatformProject.billingApi: {'M': 1, 'V': 0, 'C': 1},
    PlatformProject.clientApi: {'M': 1, 'V': 0, 'C': 1},
    PlatformProject.complianceApi: {'M': 1, 'V': 0, 'C': 1},
    PlatformProject.franchiseReportingApi: {'M': 1, 'V': 0, 'C': 1},
    PlatformProject.governanceApi: {'M': 1, 'V': 0, 'C': 2},
    PlatformProject.notesApi: {'M': 1, 'V': 0, 'C': 1},
    PlatformProject.notificationApi: {'M': 1, 'V': 0, 'C': 1},
    PlatformProject.providerApi: {'M': 1, 'V': 0, 'C': 1},
    PlatformProject.schedulingApi: {'M': 1, 'V': 0, 'C': 1},
    PlatformProject.visitApi: {'M': 1, 'V': 0, 'C': 1},
  };

  // --- RBAC & GOVERNANCE METRICS ---
  static const int totalRoles = 55;
  static const int rolesWithAccess = 55;

  static const int totalUiProjects = 13;
  static const int totalApiProjects = 12;
  static const int totalScreens = 251;
  static const bool isLoginWorking = true;

  static const List<PlatformProject> uiProjects = [
    PlatformProject.governanceApp,
    PlatformProject.corporateApp,
    PlatformProject.franchiseApp,
    PlatformProject.clinicApp,
    PlatformProject.uiFactory,
    PlatformProject.marketingApp,
    PlatformProject.businessDevApp,
    PlatformProject.supportApp,
    PlatformProject.clientApp,
    PlatformProject.flutterCore,
    PlatformProject.enterpriseBlueprintApp,
    PlatformProject.verificationService,
    PlatformProject.governanceService,
  ];

  static const List<PlatformProject> apiProjects = [
    PlatformProject.apiGateway,
    PlatformProject.authApi,
    PlatformProject.billingApi,
    PlatformProject.clientApi,
    PlatformProject.complianceApi,
    PlatformProject.franchiseReportingApi,
    PlatformProject.governanceApi,
    PlatformProject.notesApi,
    PlatformProject.notificationApi,
    PlatformProject.providerApi,
    PlatformProject.schedulingApi,
    PlatformProject.visitApi,
  ];

  static Map<String, String> getManifestSummary() {
    return {
      'Version': buildVersion,
      'Status': 'SYNCHRONIZED',
      'Total Projects': '${projectLocManifest.length}',
    };
  }

  static List<PlatformProject> get allProjects => PlatformProject.values;
}

enum PlatformProject {
  governanceApp, corporateApp, franchiseApp, clinicApp, uiFactory, marketingApp, businessDevApp, supportApp, clientApp, flutterCore, enterpriseBlueprintApp, verificationService, apiGateway, authApi, billingApi, clientApi, complianceApi, franchiseReportingApi, governanceApi, governanceService, notesApi, notificationApi, providerApi, schedulingApi, visitApi
}
