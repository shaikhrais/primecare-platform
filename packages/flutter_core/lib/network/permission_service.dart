import '../src/network/api_client.dart';
import '../src/security/policies/route_permission_policy.dart';

/// Compatibility entry point; policy/cache mechanics live in shared security parents.
class PermissionService {
  static final RoutePermissionPolicy _policy = RoutePermissionPolicy();
  static Future<void> loadCachedPermissions() =>
      _policy.loadCachedPermissions();
  static Future<void> fetchAndSyncPermissions(ApiClient apiClient) =>
      _policy.fetchAndSyncPermissions(apiClient);
}
