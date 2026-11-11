// Governance - Category: controller | Purpose: Core implementation file for the Governance Provider platform logic.
import 'dart:async';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart' as ui;
import 'governance_api_service.dart';
import 'ticket_registry.dart';
import 'screen_registry.dart' as local;
import 'package:flutter_core/flutter_core.dart' as meta;
import 'screen_governance_service.dart';
import '../../governance/models/governance_report.dart';
import '../../governance/services/screen_governance_reporter.dart';
import '../../governance/services/history_provider.dart';
import '../../governance/services/cross_subsystem_auditor.dart';
import '../utils/logger.dart';
import '../../governance/services/governance_remediation_engine.dart';
import '../../governance/services/network_parity_service.dart';

final networkParityServiceProvider = Provider<NetworkParityService>((ref) {
  return NetworkParityService(baseUrl: 'http://localhost:8700/api/governance');
});

enum GovernanceEventLevel { all, info, success, warning, error, critical }

/// [GovernanceEvent] - A live security or architectural event.
class GovernanceEvent {
  final String type;
  final String message;
  final GovernanceEventLevel level;
  final String? source;
  final DateTime timestamp;

  GovernanceEvent({
    required this.type,
    required this.message,
    required this.level,
    this.source,
    required this.timestamp,
  });
}

/// [ProjectHealthSummary] - Aggregated metrics for a single platform project.
class ProjectHealthSummary {
  final ui.PlatformProject project;
  final String name;
  final bool isUi;
  final double? healthScore;
  final String status;
  final int? warningCount;
  final int? errorCount;
  final int? criticalCount;
  final List<String> issues;
  final List<String> suggestions;
  final int loc;
  final int files;
  final int? folders;
  final int? largeFiles;
  final int? emptyFiles;
  final int? duplicateFiles;
  final int? unusedFiles;
  final Map<String, int> mvc;
  final int models;
  final int views;
  final int controllers;
  final int? services;
  final int? repositories;
  final int? providers;
  final int? widgets;
  final int? totalScreens;
  final int? brokenRoutes;
  final int? missingForms;
  final int? failedApis;
  final DateTime? lastCheckedAt;
  final String source;

  ProjectHealthSummary({
    this.source = 'declared-manifest-only; runtime integrity unverified',
    required this.project,
    required this.name,
    required this.isUi,
    required this.healthScore,
    required this.status,
    required this.warningCount,
    required this.errorCount,
    required this.criticalCount,
    required this.issues,
    required this.suggestions,
    required this.loc,
    required this.files,
    required this.folders,
    required this.largeFiles,
    required this.emptyFiles,
    required this.duplicateFiles,
    required this.unusedFiles,
    required this.mvc,
    required this.models,
    required this.views,
    required this.controllers,
    required this.services,
    required this.repositories,
    required this.providers,
    required this.widgets,
    required this.totalScreens,
    required this.brokenRoutes,
    required this.missingForms,
    required this.failedApis,
    required this.lastCheckedAt,
  });
}

/// [GovernanceState] - The master state object for the Governance HUD.
class GovernanceState {
  static const _notProvided = Object();
  final List<ProjectHealthSummary> projects;
  final int totalLoc;
  final int totalFiles;
  final int totalScreens;
  final int registeredScreens;
  final int missingScreens;
  final int brokenScreens;
  final int totalRoutes;
  final int workingRoutes;
  final int totalRegisteredForms;
  final List<String> discoveredForms;
  final int missingForms;
  final int totalRoles;
  final int rolesWithAccess;
  final int totalTickets;
  final int openTickets;
  final int unauthorizedAccessCount;
  final int totalApis;
  final int workingApis;
  final int failedApis;
  final bool runtimeAuditAvailable;
  final bool? isLoginWorking;
  final bool? isLogoutWorking;
  final bool? isTokenValid;
  final bool isSyncing;
  final bool isBackgroundSyncing;
  final bool hasDrift;
  final List<String> driftIssues;
  final double? integrityScore;
  final Map<String, List<bool>> categorizedCoverage;
  final Map<String, double> featureHealth;
  final bool telemetryAvailable;
  final double apiUptime;
  final int dbConnections;
  final Map<String, dynamic> liveServiceHealth;
  final List<GovernanceEvent> recentEvents;
  final List<Map<String, dynamic>> healthTrend;

  // New High-Fidelity Governance Metrics
  final int productionReadyScreensCount;
  final int highRiskScreensCount;
  final int localizationGapsCount;
  final int duplicateRoutesCount;
  final int totalSprintPoints;
  final double platformHealthScore;
  final List<meta.ScreenMetadata> productionReadyScreens;
  final List<meta.ScreenMetadata> highRiskScreens;
  final List<meta.ScreenMetadata> localizationGapScreens;
  final List<meta.ScreenMetadata> duplicateRouteScreens;
  final List<String> duplicateRouteNames;
  final List<AuditIssue> subsystemIssues;
  final GovernanceReport? report;
  final Map<String, meta.ScreenMetadata> allScreens;

  // Proposal Pipeline Metrics
  final int? pendingProposalsCount;
  final int? approvedProposalsCount;
  final int? deployedProposalsCount;
  final double? intakeReadinessScore;

  final GovernanceEventLevel eventFilter;

  GovernanceState({
    required this.projects,
    required this.totalLoc,
    required this.totalFiles,
    required this.totalScreens,
    required this.registeredScreens,
    required this.missingScreens,
    required this.brokenScreens,
    required this.totalRoutes,
    required this.workingRoutes,
    required this.totalRegisteredForms,
    required this.discoveredForms,
    required this.missingForms,
    required this.totalRoles,
    required this.rolesWithAccess,
    required this.totalTickets,
    required this.openTickets,
    required this.unauthorizedAccessCount,
    required this.totalApis,
    required this.workingApis,
    required this.failedApis,
    this.runtimeAuditAvailable = false,
    required this.isLoginWorking,
    required this.isLogoutWorking,
    required this.isTokenValid,
    required this.isSyncing,
    required this.isBackgroundSyncing,
    required this.hasDrift,
    required this.driftIssues,
    required this.integrityScore,
    required this.categorizedCoverage,
    required this.featureHealth,
    this.telemetryAvailable = false,
    required this.apiUptime,
    required this.dbConnections,
    required this.liveServiceHealth,
    required this.recentEvents,
    required this.healthTrend,
    required this.productionReadyScreensCount,
    required this.highRiskScreensCount,
    required this.localizationGapsCount,
    required this.duplicateRoutesCount,
    required this.totalSprintPoints,
    required this.platformHealthScore,
    required this.productionReadyScreens,
    required this.highRiskScreens,
    required this.localizationGapScreens,
    required this.duplicateRouteScreens,
    required this.duplicateRouteNames,
    required this.eventFilter,
    required this.subsystemIssues,
    required this.pendingProposalsCount,
    required this.approvedProposalsCount,
    required this.deployedProposalsCount,
    required this.intakeReadinessScore,
    required this.allScreens,
    this.report,
  });

  GovernanceState copyWith({
    List<ProjectHealthSummary>? projects,
    int? totalLoc,
    int? totalFiles,
    int? totalScreens,
    int? registeredScreens,
    int? missingScreens,
    int? brokenScreens,
    int? totalRoutes,
    int? workingRoutes,
    int? totalRegisteredForms,
    List<String>? discoveredForms,
    int? missingForms,
    int? totalRoles,
    int? rolesWithAccess,
    int? totalTickets,
    int? openTickets,
    int? unauthorizedAccessCount,
    int? totalApis,
    int? workingApis,
    int? failedApis,
    bool? runtimeAuditAvailable,
    Object? isLoginWorking = _notProvided,
    Object? isLogoutWorking = _notProvided,
    Object? isTokenValid = _notProvided,
    bool? isSyncing,
    bool? isBackgroundSyncing,
    bool? hasDrift,
    List<String>? driftIssues,
    Object? integrityScore = _notProvided,
    Map<String, List<bool>>? categorizedCoverage,
    Map<String, double>? featureHealth,
    bool? telemetryAvailable,
    double? apiUptime,
    int? dbConnections,
    Map<String, dynamic>? liveServiceHealth,
    List<GovernanceEvent>? recentEvents,
    int? productionReadyScreensCount,
    int? highRiskScreensCount,
    int? localizationGapsCount,
    int? duplicateRoutesCount,
    int? totalSprintPoints,
    double? platformHealthScore,
    List<meta.ScreenMetadata>? productionReadyScreens,
    List<meta.ScreenMetadata>? highRiskScreens,
    List<meta.ScreenMetadata>? localizationGapScreens,
    List<meta.ScreenMetadata>? duplicateRouteScreens,
    List<String>? duplicateRouteNames,
    List<Map<String, dynamic>>? healthTrend,
    GovernanceEventLevel? eventFilter,
    List<AuditIssue>? subsystemIssues,
    Object? pendingProposalsCount = _notProvided,
    Object? approvedProposalsCount = _notProvided,
    Object? deployedProposalsCount = _notProvided,
    Object? intakeReadinessScore = _notProvided,
    Map<String, meta.ScreenMetadata>? allScreens,
    GovernanceReport? report,
  }) {
    return GovernanceState(
      projects: projects ?? this.projects,
      totalLoc: totalLoc ?? this.totalLoc,
      totalFiles: totalFiles ?? this.totalFiles,
      totalScreens: totalScreens ?? this.totalScreens,
      registeredScreens: registeredScreens ?? this.registeredScreens,
      missingScreens: missingScreens ?? this.missingScreens,
      brokenScreens: brokenScreens ?? this.brokenScreens,
      totalRoutes: totalRoutes ?? this.totalRoutes,
      workingRoutes: workingRoutes ?? this.workingRoutes,
      totalRegisteredForms: totalRegisteredForms ?? this.totalRegisteredForms,
      discoveredForms: discoveredForms ?? this.discoveredForms,
      missingForms: missingForms ?? this.missingForms,
      totalRoles: totalRoles ?? this.totalRoles,
      rolesWithAccess: rolesWithAccess ?? this.rolesWithAccess,
      totalTickets: totalTickets ?? this.totalTickets,
      openTickets: openTickets ?? this.openTickets,
      unauthorizedAccessCount:
          unauthorizedAccessCount ?? this.unauthorizedAccessCount,
      totalApis: totalApis ?? this.totalApis,
      workingApis: workingApis ?? this.workingApis,
      failedApis: failedApis ?? this.failedApis,
      runtimeAuditAvailable: runtimeAuditAvailable ?? this.runtimeAuditAvailable,
      isLoginWorking: identical(isLoginWorking, _notProvided) ? this.isLoginWorking : isLoginWorking as bool?,
      isLogoutWorking: identical(isLogoutWorking, _notProvided) ? this.isLogoutWorking : isLogoutWorking as bool?,
      isTokenValid: identical(isTokenValid, _notProvided) ? this.isTokenValid : isTokenValid as bool?,
      isSyncing: isSyncing ?? this.isSyncing,
      isBackgroundSyncing: isBackgroundSyncing ?? this.isBackgroundSyncing,
      hasDrift: hasDrift ?? this.hasDrift,
      driftIssues: driftIssues ?? this.driftIssues,
      integrityScore: identical(integrityScore, _notProvided) ? this.integrityScore : integrityScore as double?,
      categorizedCoverage: categorizedCoverage ?? this.categorizedCoverage,
      featureHealth: featureHealth ?? this.featureHealth,
      telemetryAvailable: telemetryAvailable ?? this.telemetryAvailable,
      apiUptime: apiUptime ?? this.apiUptime,
      dbConnections: dbConnections ?? this.dbConnections,
      liveServiceHealth: liveServiceHealth ?? this.liveServiceHealth,
      recentEvents: recentEvents ?? this.recentEvents,
      productionReadyScreensCount:
          productionReadyScreensCount ?? this.productionReadyScreensCount,
      highRiskScreensCount: highRiskScreensCount ?? this.highRiskScreensCount,
      localizationGapsCount:
          localizationGapsCount ?? this.localizationGapsCount,
      duplicateRoutesCount: duplicateRoutesCount ?? this.duplicateRoutesCount,
      totalSprintPoints: totalSprintPoints ?? this.totalSprintPoints,
      platformHealthScore: platformHealthScore ?? this.platformHealthScore,
      productionReadyScreens:
          productionReadyScreens ?? this.productionReadyScreens,
      highRiskScreens: highRiskScreens ?? this.highRiskScreens,
      localizationGapScreens:
          localizationGapScreens ?? this.localizationGapScreens,
      duplicateRouteScreens:
          duplicateRouteScreens ?? this.duplicateRouteScreens,
      duplicateRouteNames: duplicateRouteNames ?? this.duplicateRouteNames,
      healthTrend: healthTrend ?? this.healthTrend,
      eventFilter: eventFilter ?? this.eventFilter,
      subsystemIssues: subsystemIssues ?? this.subsystemIssues,
      pendingProposalsCount:
          identical(pendingProposalsCount, _notProvided) ? this.pendingProposalsCount : pendingProposalsCount as int?,
      approvedProposalsCount:
          identical(approvedProposalsCount, _notProvided) ? this.approvedProposalsCount : approvedProposalsCount as int?,
      deployedProposalsCount:
          identical(deployedProposalsCount, _notProvided) ? this.deployedProposalsCount : deployedProposalsCount as int?,
      intakeReadinessScore: identical(intakeReadinessScore, _notProvided) ? this.intakeReadinessScore : intakeReadinessScore as double?,
      allScreens: allScreens ?? this.allScreens,
      report: report ?? this.report,
    );
  }
}

/// [governanceProvider] - Riverpod provider for the Governance HUD data.
class GovernanceNotifier extends Notifier<GovernanceState> {
  StreamSubscription? _telemetrySubscription;
  Timer? _automationTimer;
  int _refreshGeneration = 0;

  // Persist live metrics across rebuilds
  bool _currentTelemetryAvailable = false;
  double _currentApiUptime = 0;
  int _currentDbConnections = 0;
  Map<String, dynamic> _currentServiceHealth = {};
  List<GovernanceEvent> _currentEvents = [];

  @override
  GovernanceState build() {
    _initTelemetry();
    _loadHistory();
    _startAutomationLoop();

    ref.onDispose(() {
      _telemetrySubscription?.cancel();
      _automationTimer?.cancel();
    });

    return _calculateState(
      telemetryAvailable: _currentTelemetryAvailable,
      apiUptime: _currentApiUptime,
      dbConnections: _currentDbConnections,
      liveServiceHealth: _currentServiceHealth,
      existingEvents: _currentEvents,
    );
  }

  void _startAutomationLoop() {
    _automationTimer?.cancel();
    if (Platform.environment.containsKey('FLUTTER_TEST')) return;
    
    // Scheduled observation must not rewrite source or certify acceptance.
    _automationTimer = Timer.periodic(const Duration(minutes: 5), (timer) {
      if (!state.isSyncing && !state.isBackgroundSyncing) {
        refresh(background: true);
      }
    });
  }

  Future<void> _loadHistory({int? generation}) async {
    final expectedGeneration = generation ?? _refreshGeneration;
    try {
      final historyService = ref.read(governanceHistoryServiceProvider);
      final trend = await historyService.getHealthTrend();
      if (ref.mounted && expectedGeneration == _refreshGeneration) {
        state = state.copyWith(healthTrend: trend);
      }
    } catch (e) {
      AppLogger.e('History load failed: $e');
    }
  }

  void _initTelemetry() {
    if (_telemetrySubscription != null) return;
    final service = ref.read(governanceApiServiceProvider);
    final stream = service.telemetryStream;
    _telemetrySubscription = stream.listen((data) {
      if (!ref.mounted) return;
      final uptime = data['api_uptime'];
      final connections = data['db_connections'];
      final health = data['service_health'];
      final events = data['events'] ?? const [];
      if (uptime is! num || !uptime.isFinite || uptime < 0 || uptime > 100 ||
          connections is! int || connections < 0 || health is! Map ||
          health.entries.any((e) => e.key is! String || (e.key as String).isEmpty ||
            e.value is! String || (e.value as String).isEmpty) ||
          events is! List || events.any((e) => e is! Map || _readRemoteEvent(e) == null)) {
        _markTelemetryUnavailable();
        return;
      }
      for (final e in events) {
        _currentEvents.insert(0, _readRemoteEvent(e)!);
      }
      if (_currentEvents.length > 50) _currentEvents = _currentEvents.sublist(0, 50);
      _currentApiUptime = uptime.toDouble();
      _currentDbConnections = connections;
      _currentServiceHealth = Map<String, dynamic>.unmodifiable(health);
      _currentTelemetryAvailable = true;
      state = state.copyWith(telemetryAvailable: true,
        apiUptime: _currentApiUptime, dbConnections: _currentDbConnections,
        liveServiceHealth: _currentServiceHealth, recentEvents: List.from(_currentEvents));
    }, onError: (Object error, StackTrace stack) {
      _markTelemetryUnavailable();
    }, onDone: _markTelemetryUnavailable);
  }

  GovernanceEvent? _readRemoteEvent(Map<dynamic, dynamic> data) {
    final timestamp = data['timestamp'];
    final parsed = timestamp is String &&
        RegExp(r'(Z|[+-]\d{2}:\d{2})$').hasMatch(timestamp)
        ? DateTime.tryParse(timestamp) : null;
    if (data['type'] is! String || data['message'] is! String ||
        data['level'] is! String || parsed == null) return null;
    return GovernanceEvent(type: data['type'], message: data['message'],
      level: _parseEventLevel(data['level']),
      source: data['source'] is String ? data['source'] : null, timestamp: parsed);
  }

  void _markTelemetryUnavailable() {
    if (!ref.mounted) return;
    _currentTelemetryAvailable = false;
    _currentApiUptime = 0;
    _currentDbConnections = 0;
    _currentServiceHealth = {};
    state = state.copyWith(telemetryAvailable: false, apiUptime: 0,
      dbConnections: 0, liveServiceHealth: const {});
  }

  GovernanceState _calculateState({
    List<Map<String, dynamic>>? existingTrend,
    List<GovernanceEvent>? existingEvents,
    bool? telemetryAvailable,
    double? apiUptime,
    int? dbConnections,
    Map<String, dynamic>? liveServiceHealth,
  }) {
    // No registered proposal/intake/auth observation transport is configured.
    // Unknown must not be represented as completed, healthy or 100% ready.
    const int? pendingCount = null;
    const int? approvedCount = null;
    const int? deployedCount = null;
    const double? readinessTotal = null;

    final List<ProjectHealthSummary> summaries = [];

    for (final project in ui.PlatformProject.values) {
      final loc =
          ui.PlatformGovernanceRegistry.projectLocManifest[project] ?? 0;
      final fileCount =
          ui.PlatformGovernanceRegistry.projectFileManifest[project] ?? 0;
      final mvc =
          ui.PlatformGovernanceRegistry.uiMvcManifest[project] ??
          ui.PlatformGovernanceRegistry.apiMvcManifest[project] ??
          {};

      final isUi = ui.PlatformGovernanceRegistry.uiProjects.contains(project);
      final score = ui.IntegrityService.calculateHealthScore(project);

      summaries.add(
        ProjectHealthSummary(
          project: project,
          name: project.name,
          isUi: isUi,
          healthScore: score,
          status: ui.IntegrityService.getIntegrityStatus(project),
          warningCount: null,
          errorCount: null,
          criticalCount: null,
          issues: ui.IntegrityService.getProjectIssues(project),
          suggestions: ui.IntegrityService.getProjectSuggestions(project),
          loc: loc,
          files: fileCount,
          folders: null,
          largeFiles: null,
          emptyFiles: null,
          duplicateFiles: null,
          unusedFiles: null,
          mvc: mvc,
          models: mvc['M'] ?? 0,
          views: mvc['V'] ?? 0,
          controllers: mvc['C'] ?? 0,
          services: null,
          repositories: null,
          providers: null,
          widgets: null,
          totalScreens: null,
          brokenRoutes: null,
          missingForms: null,
          failedApis: null,
          lastCheckedAt: null,
        ),
      );
    }

    final auditReports = ui.ScreenRegistry.auditRegistry();
    final hasDrift = auditReports.any((r) => !r.isHealthy);
    final double? avgScore = summaries.isEmpty || summaries.any((s) => s.healthScore == null)
        ? null
        : summaries.map((s) => s.healthScore!).reduce((a, b) => a + b) / summaries.length;

    // Group discovered forms by feature
    final Map<String, List<bool>> categorizedCoverage = {};
    final Map<String, List<double>> featureScores = {};

    for (final screen in local.ScreenRegistry.screens.values) {
      final category = screen.featureName;
      categorizedCoverage
          .putIfAbsent(category, () => [])
          .add(screen.isRenderOk);
      featureScores
          .putIfAbsent(category, () => [])
          .add(screen.completionPercent);
    }

    // Initialize Governance Services
    final govService = ScreenGovernanceService(
      local.ScreenRegistry.screens.values.toList(),
    );
    final governanceReport = ScreenGovernanceReporter.generateReport();

    return GovernanceState(
      projects: summaries,
      totalLoc: summaries.fold(0, (sum, s) => sum + s.loc),
      totalFiles: summaries.fold(0, (sum, s) => sum + s.files),
      totalScreens: local.ScreenRegistry.screens.length,
      registeredScreens: ui.ScreenRegistry.getAllScreens().length,
      missingScreens: auditReports.where((r) => !r.isHealthy).length,
      brokenScreens: 0,
      totalRoutes: ui.ScreenRegistry.getAllScreens().length,
      workingRoutes: 0,
      totalRegisteredForms: 0,
      discoveredForms: [],
      missingForms: 0,
      totalRoles: ui.PlatformGovernanceRegistry.totalRoles,
      rolesWithAccess: ui.PlatformGovernanceRegistry.rolesWithAccess,
      totalTickets: TicketRegistry.totalTickets,
      openTickets: TicketRegistry.openTickets,
      unauthorizedAccessCount: 0,
      totalApis: 0,
      workingApis: 0,
      failedApis: 0,
      isLoginWorking: null,
      isLogoutWorking: null,
      isTokenValid: null,
      isSyncing: false,
      isBackgroundSyncing: false,
      hasDrift: hasDrift,
      driftIssues: auditReports
          .where((r) => !r.isHealthy)
          .map((r) => r.message)
          .toList(),
      integrityScore: avgScore,
      categorizedCoverage: {},
      featureHealth: {},
      telemetryAvailable: telemetryAvailable ?? false,
      apiUptime: apiUptime ?? 0.0,
      dbConnections: dbConnections ?? 0,
      liveServiceHealth: liveServiceHealth ?? const {},
      recentEvents: existingEvents ?? const [],
      productionReadyScreensCount: governanceReport.productionReadyScreens
          .toInt(),
      highRiskScreensCount:
          (governanceReport.highIssues + governanceReport.criticalIssues)
              .toInt(),
      localizationGapsCount: governanceReport.issues
          .where((i) => i.category.toString().contains('localization'))
          .length,
      duplicateRoutesCount: govService.findDuplicateRoutes().length,
      totalSprintPoints: govService.getTotalSprintPoints().toInt(),
      platformHealthScore: governanceReport.overallHealthScore,
      productionReadyScreens: govService.getProductionReadyScreens(),
      highRiskScreens: govService.getHighRiskScreens(),
      localizationGapScreens: govService.getLocalizationGaps(),
      duplicateRouteScreens: govService.getDuplicateRouteScreens(),
      duplicateRouteNames: govService.findDuplicateRoutes(),
      report: governanceReport,
      eventFilter: GovernanceEventLevel.all,
      healthTrend: existingTrend ?? const [],
      subsystemIssues: const [],
      pendingProposalsCount: pendingCount,
      approvedProposalsCount: approvedCount,
      deployedProposalsCount: deployedCount,
      intakeReadinessScore: readinessTotal,
      allScreens: local.ScreenRegistry.screens,
    );
  }

  /// Performs a deep audit across all platform subsystems.
  Future<void> performCrossSubsystemAudit() async {
    state = state.copyWith(isSyncing: true);

    try {
      final auditor = CrossSubsystemAuditor(projectRoot: '.');

      // 1. Audit Form Provider Parity
      final formIssues = await auditor.auditFormProviderParity();

      // 2. Audit Screen Registry Parity (against Governance Blueprint)
      final screenIssues = await auditor.auditScreenRegistryParity();

      final allIssues = [...formIssues, ...screenIssues];
      if (!ref.mounted) return;
      state = state.copyWith(subsystemIssues: allIssues, isSyncing: false);

      if (allIssues.isNotEmpty) {
        logEvent(
          'Auditor',
          'Cross-Subsystem Audit: Detected ${allIssues.length} architectural consistency issues.',
          GovernanceEventLevel.warning,
        );
      }
    } catch (e) {
      AppLogger.e('Cross-Subsystem Audit failed', e);
      if (ref.mounted) state = state.copyWith(isSyncing: false);
    }
  }

  void logEvent(String type, String message, GovernanceEventLevel level) {
    final event = GovernanceEvent(
      type: type,
      message: message,
      level: level,
      timestamp: DateTime.now(),
    );
    state = state.copyWith(
      recentEvents: [event, ...state.recentEvents].take(50).toList(),
    );
  }

  /// [runSync] - Syncs platform metrics (Alias for refresh)
  Future<void> runSync() => refresh();

  /// [runAudit] - Runs an architectural integrity audit (Alias for refresh)
  Future<void> runAudit() => refresh();

  /// [runRemediation] - Triggers autonomous drift recovery (Alias for applyAutomatedFixes)
  Future<void> runRemediation() => applyAutomatedFixes();

  /// Blueprint declarations are audit inputs, never authority to create routes,
  /// permissions, implementation credit or acceptance evidence.
  Future<void> hydrateRegistries() async {
    await performCrossSubsystemAudit();
    if (!ref.mounted) return;
    logEvent('Hydrator',
      'Blueprint audit only: no registrations, permissions or completion values changed. Reconcile findings with pinned production metadata.',
      GovernanceEventLevel.warning);
  }

  /// [applyAutomatedFixes] - Triggers the ASTPatchEngine to remediate
  /// detected architectural drift or missing metadata.
  Future<void> applyAutomatedFixes({bool background = false}) async {
    if (background) {
      state = state.copyWith(isBackgroundSyncing: true);
    } else {
      state = state.copyWith(isSyncing: true);
    }

    try {
      final remediationEngine = ref.read(governanceRemediationEngineProvider);
      final result = await remediationEngine.executeGlobalRemediation();

      final fixCount = result.issuesResolved;

      // Record remediation event
      if (fixCount > 0) {
        logEvent(
          'Audit',
          'Autonomous Remediation: Resolved $fixCount architectural drift issues.',
          GovernanceEventLevel.success,
        );

        // Log individual resolutions
        for (final log in result.resolutionLogs) {
          if (log.startsWith('[RESOLVED]')) {
            AppLogger.i('Remediation: $log');
          }
        }
      }

      // Final refresh to reflect all changes
      await refresh();
    } catch (e, stack) {
      AppLogger.e('Error applying automated fixes', e, stack);
    } finally {
      if (ref.mounted) state = state.copyWith(isSyncing: false, isBackgroundSyncing: false);
    }
  }

  /// Refreshes the state (useful if the registry changes at runtime).
  Future<void> refresh({bool background = false}) async {
    final generation = ++_refreshGeneration;
    if (background) {
      state = state.copyWith(isBackgroundSyncing: true);
    } else {
      state = state.copyWith(isSyncing: true);
    }

    try {
      // 1. Fetch Backend Audit Data (Platform Parity Bridge)
      final backendIssues = await ref
          .read(networkParityServiceProvider)
          .fetchBackendAudit();
      if (!ref.mounted || generation != _refreshGeneration) return;

      // 1b. Fetch Backend Telemetry Data
      final telemetryData = await ref
          .read(networkParityServiceProvider)
          .fetchTelemetry();
      if (!ref.mounted || generation != _refreshGeneration) return;
      
      final telemetryEvents = <GovernanceEvent>[];
      for (final event in telemetryData) {
        final observed = _readRemoteEvent(event);
        if (observed == null) {
          _markTelemetryUnavailable();
          logEvent('Telemetry', 'Remote telemetry event evidence is invalid; no timestamp inferred.',
            GovernanceEventLevel.error);
        } else {
          telemetryEvents.add(observed);
        }
      }

      // 2. Calculate Base Local State
      var newState = _calculateState(
        existingTrend: state.healthTrend,
        existingEvents: [
          ...telemetryEvents,
          ...state.recentEvents,
        ].take(50).toList(),
        telemetryAvailable: state.telemetryAvailable,
        apiUptime: state.apiUptime,
        dbConnections: state.dbConnections,
        liveServiceHealth: state.liveServiceHealth,
      );

      // 3. Inject Backend Parity Data into Platform HUD
      newState = newState.copyWith(
        subsystemIssues: [...newState.subsystemIssues, ...backendIssues],
        hasDrift: newState.hasDrift || backendIssues.isNotEmpty,
        driftIssues: [
          ...newState.driftIssues,
          ...backendIssues.map((i) => "[BACKEND] ${i.message}"),
        ],
      );

      // Sync private fields with state
      _currentTelemetryAvailable = newState.telemetryAvailable;
      _currentApiUptime = newState.apiUptime;
      _currentDbConnections = newState.dbConnections;
      _currentServiceHealth = newState.liveServiceHealth;
      _currentEvents = newState.recentEvents;

      state = newState;

      // Capture snapshot for history
      if (state.report != null) {
        try {
          await ref
              .read(governanceHistoryServiceProvider)
              .captureSnapshot(state.report!);
          if (!ref.mounted || generation != _refreshGeneration) return;
          await _loadHistory(generation: generation);
        } catch (e) {
          AppLogger.e('History capture failed: $e');
        }
      }
    } catch (error) {
      if (!ref.mounted || generation != _refreshGeneration) return;
      _markTelemetryUnavailable();
      logEvent('Audit', 'Governance refresh unavailable; observations remain unverified.',
        GovernanceEventLevel.error);
    } finally {
      if (ref.mounted && generation == _refreshGeneration) {
        state = state.copyWith(isSyncing: false, isBackgroundSyncing: false);
      }
    }
  }

  /// Executes a remote governance action and returns the output.
  Future<GovernanceActionResponse> executeRemoteAction(String actionKey) async {
    state = state.copyWith(isSyncing: true);

    try {
      final apiService = ref.read(governanceApiServiceProvider);
      final response = await apiService.executeAction(actionKey);

      if (response.success && ref.mounted) {
        // If it was a sync action, refresh the local state
        if (actionKey.contains('sync')) {
          refresh();
        }
      }

      return response;
    } catch (e) {
      return GovernanceActionResponse(
        success: false,
        output: 'Fatal error during remote execution: $e',
        error: e.toString(),
      );
    } finally {
      if (ref.mounted) state = state.copyWith(isSyncing: false);
    }
  }

  void setEventFilter(GovernanceEventLevel filter) {
    state = state.copyWith(eventFilter: filter);
  }

  GovernanceEventLevel _parseEventLevel(dynamic level) {
    if (level == null) return GovernanceEventLevel.info;
    final levelStr = level.toString().toLowerCase();

    if (levelStr.contains('success')) return GovernanceEventLevel.success;
    if (levelStr.contains('warn')) return GovernanceEventLevel.warning;
    if (levelStr.contains('error')) return GovernanceEventLevel.error;
    if (levelStr.contains('critical') || levelStr.contains('high')) {
      return GovernanceEventLevel.critical;
    }

    return GovernanceEventLevel.info;
  }
}

final governanceProvider =
    NotifierProvider<GovernanceNotifier, GovernanceState>(() {
      return GovernanceNotifier();
    });
