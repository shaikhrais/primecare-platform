import 'governance_types.dart';
import 'platform_geometry.dart';

/// [ScreenMetadata] - Comprehensive governance model for a single platform screen.
/// Centralizes the architectural intent, status, and requirements for UI components.
class ScreenMetadata {
  final String id;
  final String title;
  final String route;
  final String subsystem;
  final LifecycleStatus lifecycleStatus;
  final PriorityLevel priority;
  final List<String> requiredApis;
  final List<String> requiredPermissions;
  final List<String> roles;
  final bool isAuditCompliant;
  final PlatformSize designSize;

  const ScreenMetadata({
    required this.id,
    required this.title,
    required this.route,
    required this.subsystem,
    this.lifecycleStatus = LifecycleStatus.backlog,
    this.priority = PriorityLevel.p2,
    this.requiredApis = const [],
    this.requiredPermissions = const [],
    this.roles = const [],
    this.isAuditCompliant = false,
    this.designSize = const PlatformSize(3840, 2160),
  });

  /// Logic to determine if implementation can proceed.
  bool get canImplement => isAuditCompliant && lifecycleStatus != LifecycleStatus.legacy;
}
