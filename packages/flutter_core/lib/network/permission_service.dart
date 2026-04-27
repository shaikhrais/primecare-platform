// Layer: 01_INFRASTRUCTURE
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:primecare_adapters/primecare_adapters.dart';
import '../routes/route_guard.dart';

/// Service responsible for fetching, caching, and disseminating dynamic
/// route permission boundaries from the PrimeCare backend.
class PermissionService {
  static const String _cacheKey = 'primecare_role_permissions';

  /// Loads permissions from cache and synchronizes RouteGuard synchronously on startup.
  static Future<void> loadCachedPermissions() async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString(_cacheKey);
    if (cached != null) {
      try {
        final Map<String, dynamic> decoded =
            json.decode(cached) as Map<String, dynamic>;
        final Map<String, List<String>> permissions = {};
        for (var key in decoded.keys) {
          permissions[key] = (decoded[key] as List)
              .map((e) => e.toString())
              .toList();
        }
        RouteGuard.synchronizePermissions(permissions);
      } catch (e) {
        // If parsing fails, fall back silently to the RouteGuard's static defaults.
      }
    }
  }

  /// Fetches permissions from the backend asynchronously and updates RouteGuard.
  static Future<void> fetchAndSyncPermissions(ApiClient apiClient) async {
    try {
      final response = await apiClient.get(
        ApiConfig.endpoints['systemPermissions']!,
      );
      if (response.statusCode == 200 && response.data != null) {
        final Map<String, dynamic> data = response.data as Map<String, dynamic>;
        final Map<String, List<String>> permissions = {};
        for (var key in data.keys) {
          // Safely cast to List<String>
          permissions[key] = (data[key] as List)
              .map((e) => e.toString())
              .toList();
        }

        RouteGuard.synchronizePermissions(permissions);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_cacheKey, json.encode(permissions));
      } else {
        await _applyMockFallback();
      }
    } catch (e) {
      // In development, handle 404 or backend absence by applying a mock payload.
      await _applyMockFallback();
    }
  }

  static Future<void> _applyMockFallback() async {
    final mockPermissions = {
      'ceo': ['/corporate', '/common'],
      'founder': ['/corporate', '/common'],
      'coo': ['/corporate', '/common'],
      'cfo': ['/corporate', '/common'],
      'cto': ['/corporate', '/common'],
      'regional_manager': ['/bd', '/common'],
      'franchise_owner': ['/franchise', '/common'],
      'operations_manager': ['/franchise', '/common'],
      'admin': ['/franchise', '/common'],
      'receptionist': ['/common', '/dynamic'],
      'rn': ['/clinic', '/common', '/dynamic'],
      'rpn': ['/clinic', '/common', '/dynamic'],
      'rmt': ['/clinic', '/common', '/dynamic'],
      'psw': ['/clinic', '/common', '/dynamic'],
      'physio': ['/clinic', '/common', '/dynamic'],
      'client': ['/client', '/common'],
      'family': ['/client', '/common'],
    };

    RouteGuard.synchronizePermissions(mockPermissions);
  }
}
