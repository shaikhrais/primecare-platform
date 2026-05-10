import 'package:flutter_core/models/platform_geometry.dart';
import 'package:flutter_core/models/api_metadata.dart';
import 'package:flutter_core/models/governance_types.dart';

/// [ApiGovernanceRegistry] - Central registry for all platform API endpoints.
/// Defines the architectural intent and compliance standards for the backend.
class ApiGovernanceRegistry {
  static const PlatformSize design4K = PlatformSize(3840, 2160);

  static final Map<String, ApiMetadata> endpoints = {
    'AUTH_LOGIN': ApiMetadata(
      id: 'AUTH_LOGIN',
      endpoint: '/v1/auth/login',
      method: 'POST',
      subsystem: 'infrastructure',
      allowedRoles: ['PUBLIC'],
      lifecycleStatus: LifecycleStatus.completed,
      securityLevel: SecurityTier.high,
      isSecurityVerified: true,
      isAuditCompliant: true,
      designSize: design4K,
    ),
    'GOVERNANCE_TELEMETRY': ApiMetadata(
      id: 'GOVERNANCE_TELEMETRY',
      endpoint: '/api/system/governance/telemetry',
      method: 'GET',
      subsystem: 'governance',
      allowedRoles: ['ADMIN', 'GOVERNANCE_OFFICER'],
      lifecycleStatus: LifecycleStatus.completed,
      securityLevel: SecurityTier.internal,
      isSecurityVerified: true,
      isAuditCompliant: true,
      designSize: design4K,
    ),
    'BILLING_SUMMARY': ApiMetadata(
      id: 'BILLING_SUMMARY',
      endpoint: '/v1/billing/summary',
      method: 'GET',
      subsystem: 'finance',
      allowedRoles: ['FINANCE_DIRECTOR', 'ADMIN'],
      lifecycleStatus: LifecycleStatus.design,
      securityLevel: SecurityTier.high,
      isAuditCompliant: false,
      designSize: design4K,
    ),
    'CLINICAL_PATIENTS': ApiMetadata(
      id: 'CLINICAL_PATIENTS',
      endpoint: '/v1/clinical/patients',
      method: 'GET',
      subsystem: 'clinical',
      allowedRoles: ['STAFF', 'ADMIN'],
      lifecycleStatus: LifecycleStatus.design,
      securityLevel: SecurityTier.high,
      isPhiEnabled: true,
      designSize: design4K,
    ),
    'OPERATIONS_LOGISTICS': ApiMetadata(
      id: 'OPERATIONS_LOGISTICS',
      endpoint: '/v1/operations/logistics',
      method: 'GET',
      subsystem: 'operations',
      allowedRoles: ['ADMIN', 'OPERATIONS_MANAGER'],
      lifecycleStatus: LifecycleStatus.backlog,
      securityLevel: SecurityTier.medium,
      designSize: design4K,
    ),
  };

  /// Returns all endpoints for a specific subsystem.
  static List<ApiMetadata> getBySubsystem(String subsystem) {
    return endpoints.values.where((e) => e.subsystem == subsystem).toList();
  }

  /// Checks if an endpoint is production-ready.
  static bool isReady(String id) {
    final api = endpoints[id];
    if (api == null) return false;
    return api.lifecycleStatus == LifecycleStatus.completed && api.isAuditCompliant;
  }
}
