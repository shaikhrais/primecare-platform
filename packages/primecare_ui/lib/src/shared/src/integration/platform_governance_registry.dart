// Governance - Category: service | Purpose: Layer: 00_GOVERNANCE_MANIFEST Architecture: Immutable Platform Master Registry
// Layer: 00_GOVERNANCE_MANIFEST
// Architecture: Immutable Platform Master Registry

class PlatformGovernanceRegistry {
  static const String buildVersion = '4.5.0-STABLE';
  static const String buildSignature = 'UNIVERSAL-LOCK-INITIAL-STABLE';

  static const Map<PlatformProject, int> projectLocManifest = {
    PlatformProject.governanceApp: 322250,
    PlatformProject.corporateApp: 42560,
    PlatformProject.franchiseApp: 14374,
    PlatformProject.clinicApp: 26911,
    PlatformProject.uiFactory: 64317,
    PlatformProject.marketingApp: 11691,
    PlatformProject.businessDevApp: 26610,
    PlatformProject.supportApp: 11693,
    PlatformProject.clientApp: 14425,
    PlatformProject.flutterCore: 45503,
    PlatformProject.enterpriseBlueprintApp: 979,
    PlatformProject.verificationService: 49951,
    PlatformProject.apiGateway: 2216,
    PlatformProject.authApi: 6619,
    PlatformProject.billingApi: 707,
    PlatformProject.clientApi: 5396,
    PlatformProject.complianceApi: 13141,
    PlatformProject.franchiseReportingApi: 1968,
    PlatformProject.governanceApi: 1347,
    PlatformProject.governanceService: 0,
    PlatformProject.notesApi: 631,
    PlatformProject.notificationApi: 310,
    PlatformProject.providerApi: 3467,
    PlatformProject.schedulingApi: 1076,
    PlatformProject.visitApi: 128,
  };

  static const Map<PlatformProject, int> projectFileManifest = {
    PlatformProject.governanceApp: 639,
    PlatformProject.corporateApp: 92,
    PlatformProject.franchiseApp: 63,
    PlatformProject.clinicApp: 71,
    PlatformProject.uiFactory: 940,
    PlatformProject.marketingApp: 51,
    PlatformProject.businessDevApp: 65,
    PlatformProject.supportApp: 51,
    PlatformProject.clientApp: 63,
    PlatformProject.flutterCore: 1167,
    PlatformProject.enterpriseBlueprintApp: 12,
    PlatformProject.verificationService: 167,
    PlatformProject.apiGateway: 55,
    PlatformProject.authApi: 59,
    PlatformProject.billingApi: 12,
    PlatformProject.clientApi: 82,
    PlatformProject.complianceApi: 145,
    PlatformProject.franchiseReportingApi: 37,
    PlatformProject.governanceApi: 10,
    PlatformProject.governanceService: 0,
    PlatformProject.notesApi: 10,
    PlatformProject.notificationApi: 6,
    PlatformProject.providerApi: 42,
    PlatformProject.schedulingApi: 13,
    PlatformProject.visitApi: 6,
  };

  static const Map<PlatformProject, Map<String, int>> uiMvcManifest = {
    PlatformProject.governanceApp: {'M': 7, 'V': 90, 'C': 50},
    PlatformProject.corporateApp: {'M': 2, 'V': 2, 'C': 1},
    PlatformProject.franchiseApp: {'M': 1, 'V': 2, 'C': 1},
    PlatformProject.clinicApp: {'M': 1, 'V': 2, 'C': 1},
    PlatformProject.uiFactory: {'M': 553, 'V': 286, 'C': 26},
    PlatformProject.marketingApp: {'M': 1, 'V': 2, 'C': 1},
    PlatformProject.businessDevApp: {'M': 1, 'V': 2, 'C': 1},
    PlatformProject.supportApp: {'M': 1, 'V': 2, 'C': 1},
    PlatformProject.clientApp: {'M': 1, 'V': 2, 'C': 1},
    PlatformProject.flutterCore: {'M': 15, 'V': 25, 'C': 22},
    PlatformProject.enterpriseBlueprintApp: {'M': 0, 'V': 1, 'C': 0},
    PlatformProject.verificationService: {'M': 0, 'V': 9, 'C': 18},
  };

  static const Map<PlatformProject, Map<String, int>> apiMvcManifest = {
    PlatformProject.apiGateway: {'M': 0, 'V': 0, 'C': 52},
    PlatformProject.authApi: {'M': 0, 'V': 0, 'C': 56},
    PlatformProject.billingApi: {'M': 0, 'V': 0, 'C': 10},
    PlatformProject.clientApi: {'M': 0, 'V': 0, 'C': 80},
    PlatformProject.complianceApi: {'M': 0, 'V': 2, 'C': 141},
    PlatformProject.franchiseReportingApi: {'M': 0, 'V': 0, 'C': 35},
    PlatformProject.governanceApi: {'M': 0, 'V': 0, 'C': 6},
    PlatformProject.governanceService: {'M': 0, 'V': 0, 'C': 0},
    PlatformProject.notesApi: {'M': 0, 'V': 0, 'C': 8},
    PlatformProject.notificationApi: {'M': 0, 'V': 0, 'C': 4},
    PlatformProject.providerApi: {'M': 0, 'V': 0, 'C': 40},
    PlatformProject.schedulingApi: {'M': 0, 'V': 0, 'C': 11},
    PlatformProject.visitApi: {'M': 0, 'V': 0, 'C': 4},
  };

  static const int totalRoles = 55;
  static const int rolesWithAccess = 55;

  static const int totalUiProjects = 12;
  static const int totalApiProjects = 13;
  static const int totalScreens = 160;
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
  ];

  static const List<PlatformProject> apiProjects = [
    PlatformProject.apiGateway,
    PlatformProject.authApi,
    PlatformProject.billingApi,
    PlatformProject.clientApi,
    PlatformProject.complianceApi,
    PlatformProject.franchiseReportingApi,
    PlatformProject.governanceApi,
    PlatformProject.governanceService,
    PlatformProject.notesApi,
    PlatformProject.notificationApi,
    PlatformProject.providerApi,
    PlatformProject.schedulingApi,
    PlatformProject.visitApi,
  ];

  static Map<String, String> getManifestSummary() {
    return {
      'Version': buildVersion,
      'Status': 'STABLE',
      'Total Projects': '${projectLocManifest.length}',
    };
  }
}

enum PlatformProject {
  governanceApp,
  corporateApp,
  franchiseApp,
  clinicApp,
  uiFactory,
  marketingApp,
  businessDevApp,
  supportApp,
  clientApp,
  flutterCore,
  enterpriseBlueprintApp,
  verificationService,
  apiGateway,
  authApi,
  billingApi,
  clientApi,
  complianceApi,
  franchiseReportingApi,
  governanceApi,
  governanceService,
  notesApi,
  notificationApi,
  providerApi,
  schedulingApi,
  visitApi,
}
