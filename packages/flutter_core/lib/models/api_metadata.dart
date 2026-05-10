// Layer: 01_INFRASTRUCTURE
import 'governance_types.dart';
import 'platform_geometry.dart';

/// [ApiMetadata] - Comprehensive governance model for a single platform API endpoint.
/// This class is the backend counterpart to the UI's ScreenMetadata, ensuring 
/// architectural parity and strict compliance across the API Gateway.
class ApiMetadata {
  final String id;
  final String endpoint;
  final String method;
  final String subsystem;
  final List<String> allowedRoles;
  final String description;
  final LifecycleStatus lifecycleStatus;
  final SecurityTier securityLevel;
  final PriorityLevel priority;
  final bool isSecurityVerified;
  final bool isPerformanceVerified;
  final bool isAuditCompliant;
  final bool isPhiEnabled;
  final double testPassRate;
  final int requestLimitPerMinute;
  final List<String> requiredPermissions;
  final List<String> responseComponents; // Parity check for payload hydration
  final PlatformSize? designSize;
 // Target complexity marker (e.g., 3840x2160 for 4K data density)

  const ApiMetadata({
    required this.id,
    required this.endpoint,
    this.method = 'GET',
    this.subsystem = 'unspecified',
    required this.allowedRoles,
    this.description = '',
    this.lifecycleStatus = LifecycleStatus.backlog,
    this.securityLevel = SecurityTier.medium,
    this.priority = PriorityLevel.p2,
    this.isSecurityVerified = false,
    this.isPerformanceVerified = false,
    this.isAuditCompliant = false,
    this.isPhiEnabled = false,
    this.testPassRate = 0.0,
    this.requestLimitPerMinute = 60,
    this.requiredPermissions = const [],
    this.responseComponents = const [],
    this.designSize = const PlatformSize(3840, 2160),
  });

  /// Returns a copy of this [ApiMetadata] with updated fields.
  ApiMetadata copyWith({
    String? id,
    String? endpoint,
    String? method,
    String? subsystem,
    List<String>? allowedRoles,
    String? description,
    LifecycleStatus? lifecycleStatus,
    SecurityTier? securityLevel,
    PriorityLevel? priority,
    bool? isSecurityVerified,
    bool? isPerformanceVerified,
    bool? isAuditCompliant,
    bool? isPhiEnabled,
    double? testPassRate,
    int? requestLimitPerMinute,
    List<String>? requiredPermissions,
    List<String>? responseComponents,
    PlatformSize? designSize,
  }) {
    return ApiMetadata(
      id: id ?? this.id,
      endpoint: endpoint ?? this.endpoint,
      method: method ?? this.method,
      subsystem: subsystem ?? this.subsystem,
      allowedRoles: allowedRoles ?? this.allowedRoles,
      description: description ?? this.description,
      lifecycleStatus: lifecycleStatus ?? this.lifecycleStatus,
      securityLevel: securityLevel ?? this.securityLevel,
      priority: priority ?? this.priority,
      isSecurityVerified: isSecurityVerified ?? this.isSecurityVerified,
      isPerformanceVerified: isPerformanceVerified ?? this.isPerformanceVerified,
      isAuditCompliant: isAuditCompliant ?? this.isAuditCompliant,
      isPhiEnabled: isPhiEnabled ?? this.isPhiEnabled,
      testPassRate: testPassRate ?? this.testPassRate,
      requestLimitPerMinute: requestLimitPerMinute ?? this.requestLimitPerMinute,
      requiredPermissions: requiredPermissions ?? this.requiredPermissions,
      responseComponents: responseComponents ?? this.responseComponents,
      designSize: designSize ?? this.designSize,
    );
  }

  /// Maps to a flat Map for database or telemetry transport.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'endpoint': endpoint,
      'method': method,
      'subsystem': subsystem,
      'allowedRoles': allowedRoles,
      'lifecycleStatus': lifecycleStatus.name,
      'securityLevel': securityLevel.name,
      'isAuditCompliant': isAuditCompliant,
      'designSize': designSize != null ? '${designSize!.width}x${designSize!.height}' : null,
    };
  }
}

/// [PrimeCareApi] - The interface that bridges Max OOP MVC with Platform Governance.
/// Every governed API controller MUST implement this to provide its metadata
/// for parity auditing and 4K compliance checks.
abstract class PrimeCareApi {
  ApiMetadata get metadata;
}
