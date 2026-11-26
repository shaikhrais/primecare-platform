import 'package:flutter_core/flutter_core.dart' show ApiConfig, RouteGuard;
import 'base_permission_policy.dart';

/// Immutable names for the existing permission cache and endpoint registry entry.
/// This UI policy never establishes backend authorization.
class PermissionPolicyConfiguration {
  final String cacheKey;
  final String endpointKey;
  const PermissionPolicyConfiguration({
    this.cacheKey = 'primecare_role_permissions',
    this.endpointKey = 'systemPermissions',
  });
}

class RoutePermissionPolicy extends BasePermissionPolicy {
  final PermissionPolicyConfiguration configuration;
  RoutePermissionPolicy({
    this.configuration = const PermissionPolicyConfiguration(),
  });
  @override
  String get cacheKey => configuration.cacheKey;
  @override
  String get endpoint => ApiConfig.endpoints[configuration.endpointKey]!;
  @override
  Map<String, List<String>> get fallbackPermissions =>
      RouteGuard.defaultPermissions;
  @override
  void synchronizePermissions(Map<String, List<String>> permissions) =>
      RouteGuard.synchronizePermissions(permissions);
}
