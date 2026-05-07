import 'package:flutter/material.dart';

/// [LifecycleStatus] - Tracks the stage of a screen in the development lifecycle.
enum LifecycleStatus {
  backlog,
  research,
  design,
  generation,
  testing,
  completed,
  legacy;

  static LifecycleStatus fromString(String value) {
    return LifecycleStatus.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
      orElse: () => LifecycleStatus.backlog,
    );
  }
}

/// [PriorityLevel] - Defines the business priority of a feature.
enum PriorityLevel {
  p0,
  p1,
  p2,
  p3;

  static PriorityLevel fromString(String value) {
    return PriorityLevel.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
      orElse: () => PriorityLevel.p2,
    );
  }
}

/// [SecurityTier] - Defines the data sensitivity of the screen.
enum SecurityTier {
  low,
  medium,
  high,
  internal;

  static SecurityTier fromString(String value) {
    return SecurityTier.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
      orElse: () => SecurityTier.medium,
    );
  }
}

/// [DataMode] - Tracks the source of data for the screen.
enum DataMode { mock, live, hybrid }

/// [ScreenMetadata] - Comprehensive governance model for a single platform screen.
class ScreenMetadata {
  final String id;
  final String featureName;
  final String routePath;
  final List<String> allowedRoles;
  final String title;
  final IconData? icon;
  final String description;
  final List<String> implementedComponents;
  final List<String> pendingComponents;
  final String office;
  final String role;
  final String lastCompletedDate;
  final String lastAuditDate;
  final String requestDate;
  final String researchDate;
  final String designDate;
  final String generationDate;
  final String testingDate;
  final String lastVerificationHash;
  final String uatApprover;
  final String deploymentEnvironment;
  final bool isRenderOk;
  final bool userApprovedLayout;
  final List<String> flowSteps;
  final String currentFlowStep;
  final LifecycleStatus lifecycleStatus;
  final String researchNotes;
  final String designMarkdown;
  final Map<String, dynamic> mockData;
  final String visualCategory;
  final int testScenarioCount;
  final double testPassRate;
  final double architecturalParityScore;
  final SecurityTier securityLevel;
  final bool isAccessibilityVerified;
  final bool isPerformanceVerified;
  final int complexity;
  final int storyPoints;
  final PriorityLevel priority;
  final String sprintName;
  final String assignedDeveloper;
  final List<String> subTasks;
  final String? serialNo;
  final List<String> requiredApis;
  final List<String> requiredPermissions;
  final List<String> featureFlags;
  final DataMode dataMode;
  final bool hasUnsavedChangeGuard;
  final bool isLocalizationReady;
  final bool isMobileVerified;
  final bool isTabletVerified;
  final bool isDesktopVerified;
  final bool isPhiCompliant;
  final String figmaUrl;
  final String productOwner;
  final String qaOwner;
  final List<String> blockers;
  final List<String> knownBugs;
  final List<String> dependencies;
  final DateTime? productionReadyDate;
  final double accessibilityScore;
  final double performanceScore;
  final List<String> changeLog;
  final int sprintPoints;
  final String sourcePath;
  final bool isVirtual;

  const ScreenMetadata({
    required this.id,
    required this.featureName,
    required this.routePath,
    required this.allowedRoles,
    required this.title,
    this.icon,
    this.description = '',
    this.implementedComponents = const [],
    this.pendingComponents = const [],
    this.office = 'General',
    this.role = 'Standard User',
    this.lastCompletedDate = 'N/A',
    this.lastAuditDate = 'N/A',
    this.requestDate = '2026-04-01',
    this.researchDate = '2026-04-10',
    this.designDate = '2026-04-15',
    this.generationDate = '2026-04-20',
    this.testingDate = '2026-04-25',
    this.lastVerificationHash = 'HASH_PENDING',
    this.uatApprover = 'System Auditor',
    this.deploymentEnvironment = 'development',
    this.isRenderOk = false,
    this.userApprovedLayout = false,
    this.flowSteps = const [],
    this.currentFlowStep = 'Initial',
    this.lifecycleStatus = LifecycleStatus.backlog,
    this.researchNotes = '',
    this.designMarkdown = '',
    this.mockData = const {},
    this.visualCategory = 'General',
    this.testScenarioCount = 0,
    this.testPassRate = 0.0,
    this.architecturalParityScore = 0.0,
    this.securityLevel = SecurityTier.medium,
    this.isAccessibilityVerified = false,
    this.isPerformanceVerified = false,
    this.complexity = 5,
    this.storyPoints = 0,
    this.priority = PriorityLevel.p2,
    this.sprintName = 'Sprint 1',
    this.assignedDeveloper = 'Unassigned',
    this.subTasks = const [],
    this.requiredApis = const [],
    this.requiredPermissions = const [],
    this.featureFlags = const [],
    this.dataMode = DataMode.mock,
    this.hasUnsavedChangeGuard = false,
    this.isLocalizationReady = false,
    this.isMobileVerified = false,
    this.isTabletVerified = false,
    this.isDesktopVerified = false,
    this.isPhiCompliant = false,
    this.figmaUrl = '',
    this.productOwner = '',
    this.qaOwner = '',
    this.blockers = const [],
    this.knownBugs = const [],
    this.dependencies = const [],
    this.productionReadyDate,
    this.accessibilityScore = 0.0,
    this.performanceScore = 0.0,
    this.changeLog = const [],
    this.sprintPoints = 0,
    this.sourcePath = '',
    this.isVirtual = false,
    this.serialNo,
  });

  /// Checks if a specific role has permission to access this screen.
  bool canAccess(String userRole) {
    final normalizedRole = userRole.toLowerCase();
    return allowedRoles.any((r) => r.toLowerCase() == normalizedRole) ||
        normalizedRole == 'admin' ||
        normalizedRole == 'super_admin';
  }

  /// Calculates the completion percentage based on component implementation.
  double get completionPercent {
    final total = implementedComponents.length + pendingComponents.length;
    if (total == 0) return 0;
    return (implementedComponents.length / total) * 100;
  }

  /// Comprehensive production readiness check.
  bool get isReadyForProduction {
    return isRenderOk &&
        userApprovedLayout &&
        (isAccessibilityVerified || accessibilityScore >= 90) &&
        (isPerformanceVerified || performanceScore >= 80) &&
        testPassRate >= 90 &&
        pendingComponents.isEmpty &&
        blockers.isEmpty;
  }

  /// Returns a copy of this [ScreenMetadata] with updated fields.
  ScreenMetadata copyWith({
    String? id,
    String? featureName,
    String? routePath,
    List<String>? allowedRoles,
    String? title,
    IconData? icon,
    String? description,
    List<String>? implementedComponents,
    List<String>? pendingComponents,
    String? office,
    String? role,
    String? lastCompletedDate,
    String? lastAuditDate,
    String? requestDate,
    String? researchDate,
    String? designDate,
    String? generationDate,
    String? testingDate,
    String? lastVerificationHash,
    String? uatApprover,
    String? deploymentEnvironment,
    bool? isRenderOk,
    bool? userApprovedLayout,
    List<String>? flowSteps,
    String? currentFlowStep,
    LifecycleStatus? lifecycleStatus,
    String? researchNotes,
    String? designMarkdown,
    Map<String, dynamic>? mockData,
    String? visualCategory,
    int? testScenarioCount,
    double? testPassRate,
    double? architecturalParityScore,
    SecurityTier? securityLevel,
    bool? isAccessibilityVerified,
    bool? isPerformanceVerified,
    int? complexity,
    int? storyPoints,
    PriorityLevel? priority,
    String? sprintName,
    String? assignedDeveloper,
    List<String>? subTasks,
    List<String>? requiredApis,
    List<String>? requiredPermissions,
    List<String>? featureFlags,
    DataMode? dataMode,
    bool? hasUnsavedChangeGuard,
    bool? isLocalizationReady,
    bool? isMobileVerified,
    bool? isTabletVerified,
    bool? isDesktopVerified,
    bool? isPhiCompliant,
    String? figmaUrl,
    String? productOwner,
    String? qaOwner,
    List<String>? blockers,
    List<String>? knownBugs,
    List<String>? dependencies,
    DateTime? productionReadyDate,
    double? accessibilityScore,
    double? performanceScore,
    List<String>? changeLog,
    int? sprintPoints,
    String? sourcePath,
    bool? isVirtual,
    String? serialNo,
  }) {
    return ScreenMetadata(
      id: id ?? this.id,
      featureName: featureName ?? this.featureName,
      routePath: routePath ?? this.routePath,
      allowedRoles: allowedRoles ?? this.allowedRoles,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      description: description ?? this.description,
      implementedComponents:
          implementedComponents ?? this.implementedComponents,
      pendingComponents: pendingComponents ?? this.pendingComponents,
      office: office ?? this.office,
      role: role ?? this.role,
      lastCompletedDate: lastCompletedDate ?? this.lastCompletedDate,
      lastAuditDate: lastAuditDate ?? this.lastAuditDate,
      requestDate: requestDate ?? this.requestDate,
      researchDate: researchDate ?? this.researchDate,
      designDate: designDate ?? this.designDate,
      generationDate: generationDate ?? this.generationDate,
      testingDate: testingDate ?? this.testingDate,
      lastVerificationHash: lastVerificationHash ?? this.lastVerificationHash,
      uatApprover: uatApprover ?? this.uatApprover,
      deploymentEnvironment:
          deploymentEnvironment ?? this.deploymentEnvironment,
      isRenderOk: isRenderOk ?? this.isRenderOk,
      userApprovedLayout: userApprovedLayout ?? this.userApprovedLayout,
      flowSteps: flowSteps ?? this.flowSteps,
      currentFlowStep: currentFlowStep ?? this.currentFlowStep,
      lifecycleStatus: lifecycleStatus ?? this.lifecycleStatus,
      researchNotes: researchNotes ?? this.researchNotes,
      designMarkdown: designMarkdown ?? this.designMarkdown,
      mockData: mockData ?? this.mockData,
      visualCategory: visualCategory ?? this.visualCategory,
      testScenarioCount: testScenarioCount ?? this.testScenarioCount,
      testPassRate: testPassRate ?? this.testPassRate,
      architecturalParityScore:
          architecturalParityScore ?? this.architecturalParityScore,
      securityLevel: securityLevel ?? this.securityLevel,
      isAccessibilityVerified:
          isAccessibilityVerified ?? this.isAccessibilityVerified,
      isPerformanceVerified:
          isPerformanceVerified ?? this.isPerformanceVerified,
      complexity: complexity ?? this.complexity,
      storyPoints: storyPoints ?? this.storyPoints,
      priority: priority ?? this.priority,
      sprintName: sprintName ?? this.sprintName,
      assignedDeveloper: assignedDeveloper ?? this.assignedDeveloper,
      subTasks: subTasks ?? this.subTasks,
      requiredApis: requiredApis ?? this.requiredApis,
      requiredPermissions: requiredPermissions ?? this.requiredPermissions,
      featureFlags: featureFlags ?? this.featureFlags,
      dataMode: dataMode ?? this.dataMode,
      hasUnsavedChangeGuard:
          hasUnsavedChangeGuard ?? this.hasUnsavedChangeGuard,
      isLocalizationReady: isLocalizationReady ?? this.isLocalizationReady,
      isMobileVerified: isMobileVerified ?? this.isMobileVerified,
      isTabletVerified: isTabletVerified ?? this.isTabletVerified,
      isDesktopVerified: isDesktopVerified ?? this.isDesktopVerified,
      isPhiCompliant: isPhiCompliant ?? this.isPhiCompliant,
      figmaUrl: figmaUrl ?? this.figmaUrl,
      productOwner: productOwner ?? this.productOwner,
      qaOwner: qaOwner ?? this.qaOwner,
      blockers: blockers ?? this.blockers,
      knownBugs: knownBugs ?? this.knownBugs,
      dependencies: dependencies ?? this.dependencies,
      productionReadyDate: productionReadyDate ?? this.productionReadyDate,
      accessibilityScore: accessibilityScore ?? this.accessibilityScore,
      performanceScore: performanceScore ?? this.performanceScore,
      changeLog: changeLog ?? this.changeLog,
      sprintPoints: sprintPoints ?? this.sprintPoints,
      sourcePath: sourcePath ?? this.sourcePath,
      isVirtual: isVirtual ?? this.isVirtual,
      serialNo: serialNo ?? this.serialNo,
    );
  }

  /// Identifies if the screen is currently high-risk.
  bool get hasRisk {
    return (securityLevel == SecurityTier.high ||
            securityLevel == SecurityTier.internal) &&
        (testPassRate < 90 || !isPhiCompliant);
  }

  /// Returns the count of missing components.
  int get missingWorkCount => pendingComponents.length;

  /// [fromFactoryJson] - Hydrates metadata from a factory registry JSON.
  static ScreenMetadata fromFactoryJson(
    String id,
    Map<String, dynamic> json, {
    String office = 'General',
    String role = 'Staff',
  }) {
    final String rawTitle = json['title'] as String? ?? 'N/A';
    final String route =
        (json['route'] ?? json['path']) as String? ?? '/unknown';
    final List<String> components =
        (json['componentLabels'] as List?)?.cast<String>() ?? [];
    final String description = json['structuralPlan'] as String? ?? '';

    return ScreenMetadata(
      id: id,
      featureName: rawTitle,
      routePath: route,
      title: rawTitle,
      description: description,
      pendingComponents: components,
      office: office,
      role: role,
      allowedRoles: [role, 'Admin'],
      lifecycleStatus: LifecycleStatus.backlog,
      icon: _mapIcon(json['icon'] as String?),
    );
  }

  static IconData _mapIcon(String? name) {
    switch (name) {
      case 'settings':
      case 'settings_outlined':
        return Icons.settings_outlined;
      case 'architecture':
      case 'architecture_outlined':
        return Icons.architecture_outlined;
      case 'shipping':
      case 'local_shipping_outlined':
        return Icons.local_shipping_outlined;
      case 'groups':
        return Icons.groups;
      case 'map':
        return Icons.map;
      case 'desk':
        return Icons.desk;
      case 'person_add':
        return Icons.person_add_alt_1;
      case 'auto_awesome_mosaic':
        return Icons.auto_awesome_mosaic;
      case 'users':
        return Icons.people_outline;
      case 'barChart':
        return Icons.bar_chart_outlined;
      case 'indigo': // Sometimes the color is accidentally put in the icon field in factory
        return Icons.analytics_outlined;
      default:
        return Icons.dashboard_outlined;
    }
  }
}
