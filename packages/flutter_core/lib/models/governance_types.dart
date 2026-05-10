// Layer: 01_INFRASTRUCTURE
import 'platform_geometry.dart';

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
