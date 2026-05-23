// Governance - Category: test | Purpose: UI Screen component rendering the Governance Dashboard Controller Test workspace interface.
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_governance/governance/controllers/governance_dashboard_controller.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_governance/core/governance/governance_provider.dart';
import 'package:primecare_governance/governance/models/governance_report.dart';

class MockGovernanceNotifier extends GovernanceNotifier {
  bool refreshCalled = false;
  bool applyFixesCalled = false;

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
      integrityScore: 100,
      categorizedCoverage: {},
      featureHealth: {},
      apiUptime: 100,
      dbConnections: 0,
      liveServiceHealth: {},
      recentEvents: [],
      healthTrend: [],
      productionReadyScreensCount: 0,
      highRiskScreensCount: 0,
      localizationGapsCount: 0,
      duplicateRoutesCount: 0,
      totalSprintPoints: 0,
      platformHealthScore: 100,
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
      intakeReadinessScore: 100,
      allScreens: {},
    );
  }

  @override
  Future<void> refresh({bool background = false}) async {
    refreshCalled = true;
  }

  @override
  Future<void> applyAutomatedFixes({bool background = false}) async {
    applyFixesCalled = true;
  }
}

void main() {
  group('GovernanceDashboardController Comprehensive Suite', () {
    late ProviderContainer container;
    late MockGovernanceNotifier mockGovernanceNotifier;

    setUp(() {
      mockGovernanceNotifier = MockGovernanceNotifier();
      container = ProviderContainer(
        overrides: [
          governanceProvider.overrideWith(() => mockGovernanceNotifier),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state is correct', () async {
      await container.read(governanceDashboardControllerProvider.future);
      final state = container.read(governanceDashboardControllerProvider);

      expect(state.value?.selectedSeverity, isNull);
      expect(state.value?.selectedCategory, isNull);
      expect(state.value?.searchQuery, isEmpty);
      expect(state.value?.isExporting, isFalse);
    });

    group('State Mutations', () {
      test('setSeverity updates state and handles null', () async {
        await container.read(governanceDashboardControllerProvider.future);
        final controller = container.read(governanceDashboardControllerProvider.notifier);

        controller.setSeverity(AuditSeverity.critical);
        expect(container.read(governanceDashboardControllerProvider).value?.selectedSeverity, equals(AuditSeverity.critical));

        controller.setSeverity(null);
        expect(container.read(governanceDashboardControllerProvider).value?.selectedSeverity, isNull);
      });

      test('setCategory updates state and handles null', () async {
        await container.read(governanceDashboardControllerProvider.future);
        final controller = container.read(governanceDashboardControllerProvider.notifier);

        controller.setCategory(GovernanceCategory.routing);
        expect(container.read(governanceDashboardControllerProvider).value?.selectedCategory, equals(GovernanceCategory.routing));

        controller.setCategory(null);
        expect(container.read(governanceDashboardControllerProvider).value?.selectedCategory, isNull);
      });

      test('setSearchQuery updates state', () async {
        await container.read(governanceDashboardControllerProvider.future);
        final controller = container.read(governanceDashboardControllerProvider.notifier);

        controller.setSearchQuery('test query');
        expect(container.read(governanceDashboardControllerProvider).value?.searchQuery, equals('test query'));
      });

      test('clearFilters resets all filter properties', () async {
        await container.read(governanceDashboardControllerProvider.future);
        final controller = container.read(governanceDashboardControllerProvider.notifier);

        controller.setSeverity(AuditSeverity.critical);
        controller.setCategory(GovernanceCategory.routing);
        controller.setSearchQuery('test query');

        controller.clearFilters();

        final state = container.read(governanceDashboardControllerProvider);
        expect(state.value?.selectedSeverity, isNull);
        expect(state.value?.selectedCategory, isNull);
        expect(state.value?.searchQuery, isEmpty);
      });
    });

    group('Business Logic Integrations', () {
      test('rescan triggers governanceProvider refresh', () async {
        await container.read(governanceDashboardControllerProvider.future);
        final controller = container.read(governanceDashboardControllerProvider.notifier);

        expect(mockGovernanceNotifier.refreshCalled, isFalse);
        controller.rescan();
        expect(mockGovernanceNotifier.refreshCalled, isTrue);
      });

      test('remediate triggers governanceProvider applyAutomatedFixes', () async {
        await container.read(governanceDashboardControllerProvider.future);
        final controller = container.read(governanceDashboardControllerProvider.notifier);

        expect(mockGovernanceNotifier.applyFixesCalled, isFalse);
        await controller.remediate();
        expect(mockGovernanceNotifier.applyFixesCalled, isTrue);
      });
    });

    group('Export Capabilities', () {
      final dummyReport = GovernanceReport(
        totalScreens: 1,
        totalIssues: 0,
        criticalIssues: 0,
        highIssues: 0,
        mediumIssues: 0,
        lowIssues: 0,
        productionReadyScreens: 1,
        blockedScreens: 0,
        averageTestPassRate: 100.0,
        renderOkPercent: 100.0,
        accessibilityPercent: 100.0,
        performancePercent: 100.0,
        issues: [],
      );

      test('exportReport formats correctly (markdown)', () async {
        await container.read(governanceDashboardControllerProvider.future);
        final controller = container.read(governanceDashboardControllerProvider.notifier);

        final result = await controller.exportReport('markdown', dummyReport);
        expect(result, isNotNull);
        expect(result, contains('# PrimeCare Platform Governance Report'));
        expect(container.read(governanceDashboardControllerProvider).value?.isExporting, isFalse);
      });

      test('exportReport formats correctly (json)', () async {
        await container.read(governanceDashboardControllerProvider.future);
        final controller = container.read(governanceDashboardControllerProvider.notifier);

        final result = await controller.exportReport('json', dummyReport);
        expect(result, isNotNull);
        expect(result, contains('"totalScreens":1'));
      });

      test('exportReport formats correctly (csv)', () async {
        await container.read(governanceDashboardControllerProvider.future);
        final controller = container.read(governanceDashboardControllerProvider.notifier);

        final result = await controller.exportReport('csv', dummyReport);
        expect(result, isNotNull);
        expect(result, contains('Severity,Category,Screen,Route,Message,Fix,Owner,DetectedAt'));
      });

      test('exportReport formats correctly (html)', () async {
        await container.read(governanceDashboardControllerProvider.future);
        final controller = container.read(governanceDashboardControllerProvider.notifier);

        final result = await controller.exportReport('html', dummyReport);
        expect(result, isNotNull);
        expect(result, contains('<!DOCTYPE html>'));
        expect(result, contains('PrimeCare Platform Governance Report'));
      });

      test('exportReport formats correctly (pdf)', () async {
        await container.read(governanceDashboardControllerProvider.future);
        final controller = container.read(governanceDashboardControllerProvider.notifier);

        final result = await controller.exportReport('pdf', dummyReport);
        expect(result, equals('Professional PDF Report Generated'));
      });

      test('exportReport sets isExporting flag during execution', () async {
        await container.read(governanceDashboardControllerProvider.future);
        final controller = container.read(governanceDashboardControllerProvider.notifier);

        final futureResult = controller.exportReport('pdf', dummyReport);
        // The flag should be true while exporting (pdf has an await, so it yields)
        expect(container.read(governanceDashboardControllerProvider).value?.isExporting, isTrue);
        
        await futureResult;
        // The flag should be false after completion
        expect(container.read(governanceDashboardControllerProvider).value?.isExporting, isFalse);
      });

      test('exportReport returns null if state value is null (loading)', () async {
        final loadingContainer = ProviderContainer();
        final controller = loadingContainer.read(governanceDashboardControllerProvider.notifier);
        // Do not await future, so it is in AsyncLoading state, and state.value is null
        final result = await controller.exportReport('json', dummyReport);
        expect(result, isNull);
      });
    });
  });
}
