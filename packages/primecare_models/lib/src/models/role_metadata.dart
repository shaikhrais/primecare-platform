import 'platform_role.dart';

/// Represents high-fidelity metadata for a specific platform role.
/// Centralizes access level controls, target dashboards, portals, and compliance routing.
class RoleMetadata {
  final PlatformRole role;

  /// The functional classification of the role
  /// E.g. 'Corporate', 'Business Development', 'Franchise', 'Clinical', 'Training/Architecture', 'Client Side', 'Infrastructure'
  final String category;

  /// Access control level: 'read', 'write', 'admin', 'compliance'
  final String accessLevel;

  /// Canonical identifier for the dashboard screen
  final String defaultDashboardId;

  /// Canonical identifier for the compliance/governance screen
  final String defaultComplianceId;

  /// Canonical identifier for the application/portal hosting the role
  final String defaultPortal;

  /// Set of dashboards this role is authorized to view
  final List<String> allowedDashboardIds;

  /// Set of compliance screens this role is authorized to view
  final List<String> allowedComplianceIds;

  const RoleMetadata({
    required this.role,
    required this.category,
    required this.accessLevel,
    required this.defaultDashboardId,
    required this.defaultComplianceId,
    required this.defaultPortal,
    this.allowedDashboardIds = const [],
    this.allowedComplianceIds = const [],
  });

  /// True if the role possesses administrative permissions.
  bool get isAdmin => accessLevel == 'admin';

  /// True if the role possesses compliance-level auditing permissions.
  bool get isCompliance =>
      accessLevel == 'compliance' || accessLevel == 'admin';

  /// Returns the human-readable description of this role's purpose.
  String get description =>
      '${role.displayName} is a $category role with $accessLevel access inside $defaultPortal.';
}

