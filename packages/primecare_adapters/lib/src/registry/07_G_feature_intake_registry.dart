import '../../core/models.dart';

/// STEP 0: FEATURE INTAKE GOVERNANCE
/// No developer is allowed to create a screen, API, or route without an approved FeatureRequest.
class FeatureRequest {
  final String requestId;
  final String requestedBy;
  final String appId;
  final String module;
  final String featureName;
  final String description;
  final List<String> screens;
  final List<String> apiEndpoints;
  final List<UserRole> roles;
  final String priority;
  final String status;

  const FeatureRequest({
    required this.requestId,
    required this.requestedBy,
    required this.appId,
    required this.module,
    required this.featureName,
    required this.description,
    required this.screens,
    required this.apiEndpoints,
    required this.roles,
    required this.priority,
    required this.status,
  });
}

// Allowed Statuses: Draft, Review, Approved, In Development, Blocked, Completed

const List<FeatureRequest> featureRequests = [
  FeatureRequest(
    requestId: 'FR-001',
    requestedBy: 'System Architect',
    appId: 'APP-CORP-001',
    module: 'Governance & Telemetry',
    featureName: 'Unified Telemetry Engine',
    description: 'Centralized Dashboard rendering bypassing legacy scripts.',
    screens: ['DynamicDashboardScreen'],
    apiEndpoints: ['GET /telemetry/aggregate'],
    roles: [UserRole.ceo, UserRole.cto],
    priority: 'Critical',
    status: 'Completed',
  ),
  FeatureRequest(
    requestId: 'FR-010',
    requestedBy: 'Admin',
    appId: 'APP-PSW-001',
    module: 'Field Operations',
    featureName: 'PSW Check-in with GPS',
    description: 'Require GPS coordinates when PSW checks into a patient home.',
    screens: ['PswCheckinScreen'],
    apiEndpoints: ['POST /checkin/gps'],
    roles: [UserRole.psw],
    priority: 'High',
    status: 'Approved',
  ),
];
