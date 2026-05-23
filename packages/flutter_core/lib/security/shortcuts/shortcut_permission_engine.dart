// Governance - Category: service | Purpose: Evaluates whether the user is permitted to use the specified shortcut rule.
import 'shortcut_model.dart';
import '../../models/governance_role.dart';
import '../../registry/platform_screen_registry.dart';

class ShortcutPermissionEngine {
  /// Evaluates whether the user is permitted to use the specified shortcut rule.
  static bool evaluate({
    required ShortcutRule rule,
    required GovernanceRole userRole,
    required String currentOffice,
  }) {
    if (!_checkRolePermission(rule, userRole)) return false;
    if (!_checkOfficePermission(rule, currentOffice)) return false;
    if (!_checkFeaturePermission(rule)) return false;
    if (!_checkGovernanceStatus(rule)) return false;
    
    return true;
  }

  static bool _checkRolePermission(ShortcutRule rule, GovernanceRole userRole) {
    if (rule.allowedRoles.contains('ALL')) return true;
    final roleName = userRole.role.name.toUpperCase();
    return rule.allowedRoles.contains(roleName);
  }

  static bool _checkOfficePermission(ShortcutRule rule, String currentOffice) {
    if (rule.allowedOffices.contains('ALL')) return true;
    return rule.allowedOffices.contains(currentOffice.toUpperCase());
  }

  static bool _checkFeaturePermission(ShortcutRule rule) {
    // Check if the feature exists in the platform screen registry
    // Skip checking for global functional shortcuts like Search or Messages
    if (rule.category == ShortcutCategory.GLOBAL && !rule.featureId.contains('DASHBOARD')) {
      return true;
    }
    
    // For specific dashboard navigations, ensure it exists in the registry
    final metadata = PlatformScreenRegistry.screens.values.where((screen) => screen.id == rule.featureId);
    return metadata.isNotEmpty;
  }

  static bool _checkGovernanceStatus(ShortcutRule rule) {
    if (!rule.requiresGovernanceApproval) return true;
    
    if (rule.category == ShortcutCategory.GLOBAL && !rule.featureId.contains('DASHBOARD')) {
      return true;
    }

    // A real governance engine might check if completionPercent == 100.0 or if the feature is approved
    final screen = PlatformScreenRegistry.getById(rule.featureId);
    if (screen == null) return false;
    
    return screen.completionPercent == 100.0 || screen.lifecycleStatus.name.toUpperCase() == 'PRODUCTION';
  }
}
