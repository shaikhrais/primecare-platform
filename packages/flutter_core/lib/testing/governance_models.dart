
/// Represents a specific issue found during testing.
class BugGovernance {
  final String bugId;
  final String issue;
  final String severity; // High, Medium, Low
  final String impact;
  final String suggestedFix;

  BugGovernance({
    required this.bugId,
    required this.issue,
    required this.severity,
    required this.impact,
    required this.suggestedFix,
  });

  Map<String, dynamic> toJson() => {
    'bugId': bugId,
    'issue': issue,
    'severity': severity,
    'impact': impact,
    'suggestedFix': suggestedFix,
  };
}

/// Represents an individual test execution (manual or automated).
class TestCaseGovernance {
  final String testId;
  final String testCase;
  final String expectedResult;
  final String actualResult;
  final String status; // Pass, Fail, Blocked

  TestCaseGovernance({
    required this.testId,
    required this.testCase,
    required this.expectedResult,
    required this.actualResult,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
    'testId': testId,
    'testCase': testCase,
    'expectedResult': expectedResult,
    'actualResult': actualResult,
    'status': status,
  };
}

/// Represents the health of the underlying infrastructure.
class InfrastructureGovernance {
  final bool isDatabaseConnected;
  final bool isApiGatewayResponsive;
  final bool isAuthServiceHealthy;
  final List<BugGovernance> infrastructureBugs;

  InfrastructureGovernance({
    required this.isDatabaseConnected,
    required this.isApiGatewayResponsive,
    required this.isAuthServiceHealthy,
    this.infrastructureBugs = const [],
  });

  bool get isHealthy => isDatabaseConnected && isApiGatewayResponsive && isAuthServiceHealthy;

  Map<String, dynamic> toJson() => {
    'isDatabaseConnected': isDatabaseConnected,
    'isApiGatewayResponsive': isApiGatewayResponsive,
    'isAuthServiceHealthy': isAuthServiceHealthy,
    'infrastructureBugs': infrastructureBugs.map((e) => e.toJson()).toList(),
  };
}

/// Represents the readiness of the platform before executing full tests.
class PlatformReadinessGovernance {
  final bool isRegistrySynced;
  final bool isRoutingValid;
  final List<BugGovernance> readinessBugs;

  PlatformReadinessGovernance({
    required this.isRegistrySynced,
    required this.isRoutingValid,
    this.readinessBugs = const [],
  });

  bool get isReady => isRegistrySynced && isRoutingValid;

  Map<String, dynamic> toJson() => {
    'isRegistrySynced': isRegistrySynced,
    'isRoutingValid': isRoutingValid,
    'readinessBugs': readinessBugs.map((e) => e.toJson()).toList(),
  };
}

/// Defines the execution stages for the strict 10-step testing pipeline.
enum TestingPipelineStage {
  infrastructureHealth,
  platformReadiness,
  loginAuth,
  rolePermission,
  screenTesting,
  apiDataScope,
  securityTesting,
  workflowTesting,
  stabilityReport,
  releaseDecision
}

/// Telemetry and governance data for a single screen.
class ScreenGovernance {
  final String screenName;
  final bool isAuthorized;
  final bool isImplemented;
  final Map<String, int> componentFrequencies;
  final List<BugGovernance> screenBugs;

  ScreenGovernance({
    required this.screenName,
    required this.isAuthorized,
    required this.isImplemented,
    required this.componentFrequencies,
    this.screenBugs = const [],
  });

  Map<String, dynamic> toJson() => {
    'screenName': screenName,
    'isAuthorized': isAuthorized,
    'isImplemented': isImplemented,
    'componentFrequencies': componentFrequencies,
    'screenBugs': screenBugs.map((e) => e.toJson()).toList(),
  };
}

/// Represents the testing hierarchy for a specific user role.
class RoleGovernance {
  final String roleName;
  final List<ScreenGovernance> screens;
  final List<TestCaseGovernance> testCases;
  final List<BugGovernance> overallBugs;

  RoleGovernance({
    required this.roleName,
    this.screens = const [],
    this.testCases = const [],
    this.overallBugs = const [],
  });

  Map<String, dynamic> toJson() => {
    'roleName': roleName,
    'screens': screens.map((e) => e.toJson()).toList(),
    'testCases': testCases.map((e) => e.toJson()).toList(),
    'overallBugs': overallBugs.map((e) => e.toJson()).toList(),
  };
}

/// Root level container for application testing state.
class AppGovernance {
  final String appName;
  final List<RoleGovernance> roles;

  AppGovernance({
    required this.appName,
    this.roles = const [],
  });

  Map<String, dynamic> toJson() => {
    'appName': appName,
    'roles': roles.map((e) => e.toJson()).toList(),
  };
}

/// Defines severity levels for governance reporting.
class GovernanceSeverity {
  static const String info = 'INFO';
  static const String warning = 'WARNING';
  static const String high = 'HIGH';
  static const String critical = 'CRITICAL';
  static const String codeRed = 'CODE RED';
}

/// Evaluates stability and makes a final release decision.
class RoleTestReportGovernance {
  final RoleGovernance roleData;

  RoleTestReportGovernance(this.roleData);

  int get totalTests => roleData.testCases.length;
  int get passedTests => roleData.testCases.where((e) => e.status == 'Pass').length;
  int get failedTests => roleData.testCases.where((e) => e.status == 'Fail').length;
  int get blockedTests => roleData.testCases.where((e) => e.status == 'Blocked').length;

  int get totalBugs => roleData.overallBugs.length + roleData.screens.expand((s) => s.screenBugs).length;

  int get codeRedBugs {
    final allBugs = [...roleData.overallBugs, ...roleData.screens.expand((s) => s.screenBugs)];
    return allBugs.where((e) => e.severity == GovernanceSeverity.codeRed || e.severity == 'CODE RED').length;
  }

  int get criticalBugs {
    final allBugs = [...roleData.overallBugs, ...roleData.screens.expand((s) => s.screenBugs)];
    return allBugs.where((e) => e.severity == GovernanceSeverity.critical || e.severity == 'CRITICAL').length;
  }

  int get highSeverityBugs {
    final allBugs = [...roleData.overallBugs, ...roleData.screens.expand((s) => s.screenBugs)];
    return allBugs.where((e) => e.severity == GovernanceSeverity.high || e.severity == 'HIGH' || e.severity == 'High').length;
  }

  String get releaseDecision {
    if (codeRedBugs > 0) return 'BLOCKED - CODE RED INCIDENT';
    if (criticalBugs > 0) return 'DO NOT RELEASE - CRITICAL FAILURES';
    if (highSeverityBugs > 0) return 'DO NOT RELEASE - HIGH RISK';
    if (failedTests > 0) return 'CONDITIONAL PASS';
    return 'APPROVED FOR RELEASE';
  }

  Map<String, dynamic> toJson() => {
    'role': roleData.roleName,
    'totalTests': totalTests,
    'passedTests': passedTests,
    'failedTests': failedTests,
    'blockedTests': blockedTests,
    'totalBugs': totalBugs,
    'codeRedBugs': codeRedBugs,
    'criticalBugs': criticalBugs,
    'highSeverityBugs': highSeverityBugs,
    'releaseDecision': releaseDecision,
  };
}
