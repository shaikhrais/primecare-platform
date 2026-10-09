// Governance - Category: model | Purpose: Layer: 01_INFRASTRUCTURE [LifecycleStatus] - Tracks the stage of a feature (Screen or API) in the development lifecyc...
// Layer: 01_INFRASTRUCTURE

/// [LifecycleStatus] - Tracks the stage of a feature (Screen or API) in the development lifecycle.
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

/// [SecurityTier] - Defines the data sensitivity of the component.
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

/// [DataMode] - Tracks the source of data for the component.
enum DataMode { mock, live, hybrid }

/// [AuditStatus] - Tracks the compliance status of a component.
enum AuditStatus {
  pending,
  passed,
  failed,
  waived,
}

/// [SystemReadiness] - Tracks the overall readiness of a subsystem.
enum SystemReadiness {
  experimental,
  preview,
  ready,
  deprecated,
}

/// [PlatformReadinessReport] - Aggregates compliance and mesh data into a system-wide readiness score.
class PlatformReadinessReport {
  final int totalServices;
  final int activeServices;
  final double complianceScore; // 0.0 - 1.0
  final List<String> criticalIssues;
  final DateTime timestamp;

  PlatformReadinessReport({
    required this.totalServices,
    required this.activeServices,
    required this.complianceScore,
    required this.criticalIssues,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'totalServices': totalServices,
    'activeServices': activeServices,
    'complianceScore': complianceScore,
    'criticalIssues': criticalIssues,
    'timestamp': timestamp.toIso8601String(),
  };
}

enum AuditSeverity { critical, high, medium, low, info }

/// [GovernanceCategory] - Categorizes governance issues.
enum GovernanceCategory {
  routing,
  rbac,
  lifecycle,
  component,
  render,
  testing,
  accessibility,
  performance,
  security,
  audit,
  ownership,
  api,
  data,
  compliance,
  localization,
  responsive,
  production,
}

/// [PlatformAuditIssue] - Represents a specific architectural or compliance issue found during audit.
class PlatformAuditIssue {
  final String id;
  final String title;
  final GovernanceCategory category;
  final String screenId;
  final String routePath;
  final String subsystem;
  final String registry;
  final String issue;
  final String suggestion;
  final AuditSeverity severity;
  final bool autoRemediable;
  final Map<String, dynamic> metadata;
  final DateTime detectedAt;
  final String owner;

  PlatformAuditIssue({
    required this.id,
    this.title = '',
    this.category = GovernanceCategory.audit,
    this.screenId = '',
    this.routePath = '',
    required this.subsystem,
    required this.registry,
    required this.issue,
    required this.suggestion,
    this.severity = AuditSeverity.medium,
    this.autoRemediable = false,
    this.metadata = const {},
    DateTime? detectedAt,
    this.owner = 'unassigned',
  }) : detectedAt = detectedAt ?? DateTime.now();

  /// Compatibility aliases
  String get message => issue;
  String get suggestedFix => suggestion;

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'category': category.name,
    'screenId': screenId,
    'routePath': routePath,
    'subsystem': subsystem,
    'registry': registry,
    'issue': issue,
    'suggestion': suggestion,
    'severity': severity.name,
    'autoRemediable': autoRemediable,
    'metadata': metadata,
    'detectedAt': detectedAt.toIso8601String(),
    'owner': owner,
  };
}

