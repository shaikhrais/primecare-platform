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

  // Readiness / QA Metrics
  final bool isRenderOk;
  final bool userApprovedLayout;
  final double testPassRate;
  final bool isPhiCompliant;
  final bool isLocalizationReady;
  final bool isDesktopVerified;
  final bool isAccessibilityVerified;
  final double accessibilityScore;
  final double performanceScore;
  final List<String> translatedLanguages;
  final bool isFullyTranslated;
  final bool hasAllTranslations;

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
    this.isRenderOk = false,
    this.userApprovedLayout = false,
    this.testPassRate = 0.0,
    this.isPhiCompliant = false,
    this.isLocalizationReady = false,
    this.isDesktopVerified = false,
    this.isAccessibilityVerified = false,
    this.accessibilityScore = 0.0,
    this.performanceScore = 0.0,
    this.translatedLanguages = const [],
    this.isFullyTranslated = false,
    this.hasAllTranslations = false,
  })  : this.route = routePath ?? route ?? '',
        this.roles = allowedRoles ?? roles ?? const [];

  /// Compatibility aliases
  String get routePath => route;
  List<String> get allowedRoles => roles;

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
    bool? isRenderOk,
    bool? userApprovedLayout,
    double? testPassRate,
    bool? isPhiCompliant,
    bool? isLocalizationReady,
    bool? isDesktopVerified,
    bool? isAccessibilityVerified,
    double? accessibilityScore,
    double? performanceScore,
    List<String>? translatedLanguages,
    bool? isFullyTranslated,
    bool? hasAllTranslations,
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
      isRenderOk: isRenderOk ?? this.isRenderOk,
      userApprovedLayout: userApprovedLayout ?? this.userApprovedLayout,
      testPassRate: testPassRate ?? this.testPassRate,
      isPhiCompliant: isPhiCompliant ?? this.isPhiCompliant,
      isLocalizationReady: isLocalizationReady ?? this.isLocalizationReady,
      isDesktopVerified: isDesktopVerified ?? this.isDesktopVerified,
      isAccessibilityVerified: isAccessibilityVerified ?? this.isAccessibilityVerified,
      accessibilityScore: accessibilityScore ?? this.accessibilityScore,
      performanceScore: performanceScore ?? this.performanceScore,
      translatedLanguages: translatedLanguages ?? this.translatedLanguages,
      isFullyTranslated: isFullyTranslated ?? this.isFullyTranslated,
      hasAllTranslations: hasAllTranslations ?? this.hasAllTranslations,
    );
  }
}
