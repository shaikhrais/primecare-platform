import 'package:flutter/material.dart';
import 'governance_types.dart';
import 'platform_geometry.dart';

/// [ScreenMetadata] - Comprehensive governance model for a single platform screen.
/// Centralizes the architectural intent, status, and requirements for UI components.
class ScreenMetadata {
  final String id;
  final String title;
  final String route;
  final String subsystem;
  final String featureName;
  final IconData? icon;
  final LifecycleStatus lifecycleStatus;
  final PriorityLevel priority;
  final List<String> requiredApis;
  final List<String> requiredPermissions;
  final List<String> roles;
  final bool isAuditCompliant;
  final PlatformSize designSize;
  final List<String> implementedComponents;
  final List<String> pendingComponents;
  final String sourcePath;
  final bool isVirtual;
  final List<String> translationKeys;

  // Readiness / QA Metrics
  final bool isRenderOk;
  final bool userApprovedLayout;
  final double testPassRate;
  final int testScenarioCount;
  final bool isPhiCompliant;
  final bool isLocalizationReady;
  final bool isDesktopVerified;
  final bool isAccessibilityVerified;
  final bool isPerformanceVerified;
  final bool isTabletVerified;
  final double accessibilityScore;
  final double performanceScore;
  final List<String> translatedLanguages;
  final bool isFullyTranslated;
  final bool hasAllTranslations;
  final bool hasEmptyState;

  // Governance / Project Management
  final String assignedDeveloper;
  final int complexity;
  final SecurityTier securityLevel;
  final String sprintName;
  final String lastVerificationHash;
  final String deploymentEnvironment;
  final bool isMobileVerified;
  final String uatApprover;
  final bool hasUnsavedChangeGuard;
  final int storyPoints;
  final GovernanceCategory category;

  // Feature Verification Flags
  final bool isDataBindingVerified;
  final bool isSecurityVerified;
  final bool isTelemetryVerified;
  final bool isNavigationVerified;

  // Extension Fields for Governance HUD
  final double completionPercent;
  final bool hasRisk;
  final bool isReadyForProduction;
  final String office;

  const ScreenMetadata({
    required this.id,
    required this.title,
    String? route,
    String? routePath,
    this.subsystem = 'unknown',
    this.featureName = '',
    this.icon,
    this.lifecycleStatus = LifecycleStatus.backlog,
    this.priority = PriorityLevel.p2,
    this.requiredApis = const [],
    this.requiredPermissions = const [],
    List<String>? roles,
    List<String>? allowedRoles,
    this.isAuditCompliant = false,
    this.designSize = const PlatformSize(3840, 2160),
    dynamic designSizeValue, // Support Size or PlatformSize
    this.implementedComponents = const [],
    this.pendingComponents = const [],
    this.sourcePath = '',
    this.isVirtual = false,
    this.translationKeys = const [],
    this.isRenderOk = false,
    this.userApprovedLayout = false,
    this.testPassRate = 0.0,
    this.testScenarioCount = 0,
    this.isPhiCompliant = false,
    this.isLocalizationReady = false,
    this.isDesktopVerified = false,
    this.isAccessibilityVerified = false,
    this.isPerformanceVerified = false,
    this.accessibilityScore = 0.0,
    this.performanceScore = 0.0,
    this.isTabletVerified = false,
    this.translatedLanguages = const [],
    this.isFullyTranslated = false,
    this.hasAllTranslations = false,
    this.assignedDeveloper = 'unassigned',
    this.complexity = 5,
    this.securityLevel = SecurityTier.medium,
    this.sprintName = 'backlog',
    this.lastVerificationHash = 'HASH_PENDING',
    this.deploymentEnvironment = 'development',
    this.isMobileVerified = false,
    this.uatApprover = 'none',
    this.hasUnsavedChangeGuard = false,
    this.storyPoints = 0,
    this.category = GovernanceCategory.audit,
    this.hasEmptyState = false,
    this.isDataBindingVerified = false,
    this.isSecurityVerified = false,
    this.isTelemetryVerified = false,
    this.isNavigationVerified = false,
    this.completionPercent = 0.0,
    this.hasRisk = false,
    this.isReadyForProduction = false,
    this.office = 'Default',
  })  : this.route = routePath ?? route ?? '',
        this.roles = allowedRoles ?? roles ?? const [];

  /// Compatibility aliases
  String get routePath => route;
  List<String> get allowedRoles => roles;
  int get sprintPoints => storyPoints;
  String get role => roles.isNotEmpty ? roles.first : 'None';

  /// Logic to determine if implementation can proceed.
  bool get canImplement => isAuditCompliant && lifecycleStatus != LifecycleStatus.legacy;

  ScreenMetadata copyWith({
    String? id,
    String? title,
    String? route,
    String? subsystem,
    String? featureName,
    IconData? icon,
    LifecycleStatus? lifecycleStatus,
    PriorityLevel? priority,
    List<String>? requiredApis,
    List<String>? requiredPermissions,
    List<String>? roles,
    bool? isAuditCompliant,
    PlatformSize? designSize,
    List<String>? implementedComponents,
    List<String>? pendingComponents,
    String? sourcePath,
    bool? isVirtual,
    List<String>? translationKeys,
    bool? isRenderOk,
    bool? userApprovedLayout,
    double? testPassRate,
    int? testScenarioCount,
    bool? isPhiCompliant,
    bool? isLocalizationReady,
    bool? isDesktopVerified,
    bool? isAccessibilityVerified,
    bool? isPerformanceVerified,
    bool? isTabletVerified,
    double? accessibilityScore,
    double? performanceScore,
    List<String>? translatedLanguages,
    bool? isFullyTranslated,
    bool? hasAllTranslations,
    String? assignedDeveloper,
    int? complexity,
    SecurityTier? securityLevel,
    String? sprintName,
    String? lastVerificationHash,
    String? deploymentEnvironment,
    bool? isMobileVerified,
    String? uatApprover,
    bool? hasUnsavedChangeGuard,
    int? storyPoints,
    GovernanceCategory? category,
    bool? hasEmptyState,
    bool? isDataBindingVerified,
    bool? isSecurityVerified,
    bool? isTelemetryVerified,
    bool? isNavigationVerified,
    double? completionPercent,
    bool? hasRisk,
    bool? isReadyForProduction,
    String? office,
  }) {
    return ScreenMetadata(
      id: id ?? this.id,
      title: title ?? this.title,
      route: route ?? this.route,
      subsystem: subsystem ?? this.subsystem,
      featureName: featureName ?? this.featureName,
      icon: icon ?? this.icon,
      lifecycleStatus: lifecycleStatus ?? this.lifecycleStatus,
      priority: priority ?? this.priority,
      requiredApis: requiredApis ?? this.requiredApis,
      requiredPermissions: requiredPermissions ?? this.requiredPermissions,
      roles: roles ?? this.roles,
      isAuditCompliant: isAuditCompliant ?? this.isAuditCompliant,
      designSize: designSize ?? this.designSize,
      implementedComponents: implementedComponents ?? this.implementedComponents,
      pendingComponents: pendingComponents ?? this.pendingComponents,
      sourcePath: sourcePath ?? this.sourcePath,
      isVirtual: isVirtual ?? this.isVirtual,
      translationKeys: translationKeys ?? this.translationKeys,
      isRenderOk: isRenderOk ?? this.isRenderOk,
      userApprovedLayout: userApprovedLayout ?? this.userApprovedLayout,
      testPassRate: testPassRate ?? this.testPassRate,
      testScenarioCount: testScenarioCount ?? this.testScenarioCount,
      isPhiCompliant: isPhiCompliant ?? this.isPhiCompliant,
      isLocalizationReady: isLocalizationReady ?? this.isLocalizationReady,
      isDesktopVerified: isDesktopVerified ?? this.isDesktopVerified,
      isAccessibilityVerified: isAccessibilityVerified ?? this.isAccessibilityVerified,
      isPerformanceVerified: isPerformanceVerified ?? this.isPerformanceVerified,
      isTabletVerified: isTabletVerified ?? this.isTabletVerified,
      accessibilityScore: accessibilityScore ?? this.accessibilityScore,
      performanceScore: performanceScore ?? this.performanceScore,
      translatedLanguages: translatedLanguages ?? this.translatedLanguages,
      isFullyTranslated: isFullyTranslated ?? this.isFullyTranslated,
      hasAllTranslations: hasAllTranslations ?? this.hasAllTranslations,
      assignedDeveloper: assignedDeveloper ?? this.assignedDeveloper,
      complexity: complexity ?? this.complexity,
      securityLevel: securityLevel ?? this.securityLevel,
      sprintName: sprintName ?? this.sprintName,
      lastVerificationHash: lastVerificationHash ?? this.lastVerificationHash,
      deploymentEnvironment: deploymentEnvironment ?? this.deploymentEnvironment,
      isMobileVerified: isMobileVerified ?? this.isMobileVerified,
      uatApprover: uatApprover ?? this.uatApprover,
      hasUnsavedChangeGuard: hasUnsavedChangeGuard ?? this.hasUnsavedChangeGuard,
      storyPoints: storyPoints ?? this.storyPoints,
      category: category ?? this.category,
      hasEmptyState: hasEmptyState ?? this.hasEmptyState,
      isDataBindingVerified: isDataBindingVerified ?? this.isDataBindingVerified,
      isSecurityVerified: isSecurityVerified ?? this.isSecurityVerified,
      isTelemetryVerified: isTelemetryVerified ?? this.isTelemetryVerified,
      isNavigationVerified: isNavigationVerified ?? this.isNavigationVerified,
      completionPercent: completionPercent ?? this.completionPercent,
      hasRisk: hasRisk ?? this.hasRisk,
      isReadyForProduction: isReadyForProduction ?? this.isReadyForProduction,
      office: office ?? this.office,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'route': route,
        'subsystem': subsystem,
        'featureName': featureName,
        'lifecycleStatus': lifecycleStatus.name,
        'priority': priority.name,
        'requiredApis': requiredApis,
        'requiredPermissions': requiredPermissions,
        'roles': roles,
        'isAuditCompliant': isAuditCompliant,
        'implementedComponents': implementedComponents,
        'pendingComponents': pendingComponents,
        'sourcePath': sourcePath,
        'isVirtual': isVirtual,
        'translationKeys': translationKeys,
        'isRenderOk': isRenderOk,
        'userApprovedLayout': userApprovedLayout,
        'testPassRate': testPassRate,
        'testScenarioCount': testScenarioCount,
        'isPhiCompliant': isPhiCompliant,
        'isLocalizationReady': isLocalizationReady,
        'isDesktopVerified': isDesktopVerified,
        'isAccessibilityVerified': isAccessibilityVerified,
        'isPerformanceVerified': isPerformanceVerified,
        'accessibilityScore': accessibilityScore,
        'performanceScore': performanceScore,
        'isTabletVerified': isTabletVerified,
        'translatedLanguages': translatedLanguages,
        'isFullyTranslated': isFullyTranslated,
        'hasAllTranslations': hasAllTranslations,
        'hasEmptyState': hasEmptyState,
        'assignedDeveloper': assignedDeveloper,
        'complexity': complexity,
        'securityLevel': securityLevel.name,
        'sprintName': sprintName,
        'lastVerificationHash': lastVerificationHash,
        'deploymentEnvironment': deploymentEnvironment,
        'isMobileVerified': isMobileVerified,
        'uatApprover': uatApprover,
        'hasUnsavedChangeGuard': hasUnsavedChangeGuard,
        'storyPoints': storyPoints,
        'category': category.name,
        'isDataBindingVerified': isDataBindingVerified,
        'isSecurityVerified': isSecurityVerified,
        'isTelemetryVerified': isTelemetryVerified,
        'isNavigationVerified': isNavigationVerified,
        'completionPercent': completionPercent,
        'hasRisk': hasRisk,
        'isReadyForProduction': isReadyForProduction,
        'office': office,
      };
  factory ScreenMetadata.fromJson(Map<String, dynamic> json) {
    return ScreenMetadata(
      id: json['id'] as String,
      title: json['title'] as String,
      route: json['route'] as String?,
      subsystem: json['subsystem'] as String? ?? 'unknown',
      featureName: json['featureName'] as String? ?? '',
      lifecycleStatus: LifecycleStatus.values.firstWhere(
        (e) => e.name == json['lifecycleStatus'],
        orElse: () => LifecycleStatus.backlog,
      ),
      priority: PriorityLevel.values.firstWhere(
        (e) => e.name == json['priority'],
        orElse: () => PriorityLevel.p2,
      ),
      requiredApis: List<String>.from(json['requiredApis'] ?? []),
      requiredPermissions: List<String>.from(json['requiredPermissions'] ?? []),
      roles: List<String>.from(json['roles'] ?? []),
      isAuditCompliant: json['isAuditCompliant'] as bool? ?? false,
      implementedComponents: List<String>.from(json['implementedComponents'] ?? []),
      pendingComponents: List<String>.from(json['pendingComponents'] ?? []),
      sourcePath: json['sourcePath'] as String? ?? '',
      isVirtual: json['isVirtual'] as bool? ?? false,
      translationKeys: List<String>.from(json['translationKeys'] ?? []),
      isRenderOk: json['isRenderOk'] as bool? ?? false,
      userApprovedLayout: json['userApprovedLayout'] as bool? ?? false,
      testPassRate: (json['testPassRate'] as num?)?.toDouble() ?? 0.0,
      testScenarioCount: json['testScenarioCount'] as int? ?? 0,
      isPhiCompliant: json['isPhiCompliant'] as bool? ?? false,
      isLocalizationReady: json['isLocalizationReady'] as bool? ?? false,
      isDesktopVerified: json['isDesktopVerified'] as bool? ?? false,
      isAccessibilityVerified: json['isAccessibilityVerified'] as bool? ?? false,
      isPerformanceVerified: json['isPerformanceVerified'] as bool? ?? false,
      accessibilityScore: (json['accessibilityScore'] as num?)?.toDouble() ?? 0.0,
      performanceScore: (json['performanceScore'] as num?)?.toDouble() ?? 0.0,
      isTabletVerified: json['isTabletVerified'] as bool? ?? false,
      translatedLanguages: List<String>.from(json['translatedLanguages'] ?? []),
      isFullyTranslated: json['isFullyTranslated'] as bool? ?? false,
      hasAllTranslations: json['hasAllTranslations'] as bool? ?? false,
      hasEmptyState: json['hasEmptyState'] as bool? ?? false,
      assignedDeveloper: json['assignedDeveloper'] as String? ?? 'unassigned',
      complexity: json['complexity'] as int? ?? 5,
      securityLevel: SecurityTier.values.firstWhere(
        (e) => e.name == json['securityLevel'],
        orElse: () => SecurityTier.medium,
      ),
      sprintName: json['sprintName'] as String? ?? 'backlog',
      lastVerificationHash: json['lastVerificationHash'] as String? ?? 'HASH_PENDING',
      deploymentEnvironment: json['deploymentEnvironment'] as String? ?? 'development',
      isMobileVerified: json['isMobileVerified'] as bool? ?? false,
      uatApprover: json['uatApprover'] as String? ?? 'none',
      hasUnsavedChangeGuard: json['hasUnsavedChangeGuard'] as bool? ?? false,
      storyPoints: json['storyPoints'] as int? ?? 0,
      category: GovernanceCategory.values.firstWhere(
        (e) => e.name == json['category'],
        orElse: () => GovernanceCategory.audit,
      ),
      isDataBindingVerified: json['isDataBindingVerified'] as bool? ?? false,
      isSecurityVerified: json['isSecurityVerified'] as bool? ?? false,
      isTelemetryVerified: json['isTelemetryVerified'] as bool? ?? false,
      isNavigationVerified: json['isNavigationVerified'] as bool? ?? false,
      completionPercent: (json['completionPercent'] as num?)?.toDouble() ?? 0.0,
      hasRisk: json['hasRisk'] as bool? ?? false,
      isReadyForProduction: json['isReadyForProduction'] as bool? ?? false,
      office: json['office'] as String? ?? 'Default',
    );
  }
}


