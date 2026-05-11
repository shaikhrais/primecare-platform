
import '../registry/platform_role.dart';
import '../registry/platform_screen_registry.dart';
import 'screen_metadata.dart';
import 'navigation_item.dart';
import 'package:flutter/material.dart';

/// [GovernanceRole] - Centralizes governance, navigation, and screen access for a platform role.
/// This fulfills the "Real Programmer" requirement by automating menu generation from the registry.
class GovernanceRole {
  final PlatformRole role;

  GovernanceRole(this.role);

  /// Returns the human-readable name of the role.
  String get name => role.displayName;

  /// Returns the ID of the role for registry lookups.
  String get id => role.name.toUpperCase();

  /// Automatically retrieves all screens authorized for this role from the registry.
  List<ScreenMetadata> get authorizedScreens {
    return PlatformScreenRegistry.screens.values.where((screen) {
      // Check for role-specific or 'ADMIN' / 'ALL' access
      final roleName = role.name.toUpperCase();
      return screen.roles.contains(roleName) || 
             screen.roles.contains('ADMIN') || 
             screen.roles.contains('ALL');
    }).toList();
  }

  /// Generates navigation menu items dynamically from the registered screens.
  /// This ensures that "using all screens of a role" is the default behavior.
  List<PrimeCareNavigationItem> get menuItems {
    return authorizedScreens.map((screen) {
      return PrimeCareNavigationItem(
        label: screen.title,
        icon: screen.icon ?? Icons.circle_outlined,
        route: screen.routePath,
      );
    }).toList();
  }

  /// Returns the primary dashboard for this role.
  ScreenMetadata? get dashboard {
    try {
      return authorizedScreens.firstWhere((s) => s.id.contains('DASHBOARD'));
    } catch (_) {
      return authorizedScreens.isNotEmpty ? authorizedScreens.first : null;
    }
  }

  @override
  String toString() => 'GovernanceRole($name, screens: ${authorizedScreens.length})';
}
