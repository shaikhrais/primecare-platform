// Layer: 01_INFRASTRUCTURE
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/domain_governance.dart';
import 'platform_role.dart';

/// Central registry of all applications in the PrimeCare ecosystem.
/// Used for cross-portal governance, audit, and universal navigation.
class PlatformApplicationRegistry {
  static final Map<String, PlatformApplication> _applications = {};

  static void register(PlatformApplication app) {
    _applications[app.appId] = app;
  }

  static List<PlatformApplication> get all => _applications.values.toList();

  static PlatformApplication? getById(String id) => _applications[id];

  /// Checks if a role is covered by at least one application.
  static bool isRoleCovered(PlatformRole role) {
    for (final app in all) {
      if (app.getDefinition(role) != null) return true;
    }
    return false;
  }

  /// Returns the applications that support a given role.
  static List<PlatformApplication> getAppsForRole(PlatformRole role) {
    return all.where((app) => app.getDefinition(role) != null).toList();
  }
}

final platformApplicationRegistryProvider = Provider((ref) => PlatformApplicationRegistry());
