import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_governance/governance/services/governance_remediation_engine.dart';
import 'package:primecare_governance/core/governance/governance_provider.dart';

void main() {
  test('Execute Autonomous Remediation', () async {
    // 1. Initialize container with a mock state for governanceProvider to avoid native dependencies
    final container = ProviderContainer(
      overrides: [
        governanceProvider.overrideWith(() => MockGovernanceNotifier()),
      ],
    );
    
    print('Starting platform remediation via GovernanceRemediationEngine...');
    
    // 2. Instantiate engine
    final engine = container.read(governanceRemediationEngineProvider);
    
    // 3. Execute remediation
    final result = await engine.executeGlobalRemediation();
    
    print('Remediation complete.');
    print('Issues Detected: ${result.issuesDetected}');
    print('Issues Resolved: ${result.issuesResolved}');
    
    for (final log in result.resolutionLogs) {
      print(' - $log');
    }
    
    container.dispose();
  });
}

class MockGovernanceNotifier extends GovernanceNotifier {
  @override
  GovernanceState build() {
    return GovernanceState(
      projects: [],
      totalLoc: 0,
      totalFiles: 0,
      totalScreens: 0,
      registeredScreens: 0,
      missingScreens: 0,
      brokenScreens: 0,
      totalRoutes: 0,
      workingRoutes: 0,
      totalRegisteredForms: 0,
      discoveredForms: [],
      missingForms: 0,
      totalRoles: 0,
      rolesWithAccess: 0,
      totalTickets: 0,
      openTickets: 0,
      unauthorizedAccessCount: 0,
      totalApis: 0,
      workingApis: 0,
      failedApis: 0,
      isLoginWorking: true,
      isLogoutWorking: true,
      isTokenValid: true,
      isSyncing: false,
      isBackgroundSyncing: false,
      hasDrift: false,
      driftIssues: [],
      integrityScore: 100.0,
      categorizedCoverage: {},
      featureHealth: {},
      apiUptime: 99.9,
      dbConnections: 0,
      liveServiceHealth: {},
      recentEvents: [],
      healthTrend: [],
      productionReadyScreensCount: 0,
      highRiskScreensCount: 0,
      localizationGapsCount: 0,
      duplicateRoutesCount: 0,
      totalSprintPoints: 0,
      platformHealthScore: 100.0,
      productionReadyScreens: [],
      highRiskScreens: [],
      localizationGapScreens: [],
      duplicateRouteScreens: [],
      duplicateRouteNames: [],
      eventFilter: GovernanceEventLevel.all,
      subsystemIssues: [],
      pendingProposalsCount: 0,
      approvedProposalsCount: 0,
      deployedProposalsCount: 0,
      intakeReadinessScore: 0,
      allScreens: {},
    );
  }
}
