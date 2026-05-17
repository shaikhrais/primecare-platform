
import '../registry/platform_role.dart';
import '../registry/platform_screen_registry.dart';
import '../config/test_credentials_registry.dart';
import 'screen_metadata.dart';
import 'navigation_item.dart';
import 'package:flutter/material.dart';

/// [GovernanceRole] - Centralizes governance, navigation, and screen access for a platform role.
/// This fulfills the "Real Programmer" requirement by automating menu generation from the registry.
class GovernanceRole {
  final PlatformRole role;

  GovernanceRole(this.role);

  /// Exposes the current application environment mode (e.g. localTesting, staging, production)
  AppMode get currentAppMode => TestCredentialsRegistry.currentMode;

  /// Retrieves the standard test credentials for this role if running locally.
  /// This will intentionally throw a fatal error if accessed in production mode.
  TestCredential? get testCredential => TestCredentialsRegistry.getForRole(role);

  /// Returns the human-readable name of the role.
  String get name => role.displayName;

  /// Returns the ID of the role for registry lookups.
  String get id => role.name.toUpperCase();

  /// Automatically retrieves all screens authorized for this role from the registry.
  List<ScreenMetadata> get authorizedScreens {
    return PlatformScreenRegistry.screens.values.where((screen) {
      // Check for role-specific or 'ADMIN' / 'ALL' / 'CEO' access
      final roleName = role.name.toUpperCase();
      return roleName == 'ADMIN' ||
             roleName == 'SUPERADMIN' ||
             roleName == 'CEO' ||
             screen.roles.contains(roleName) || 
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

  /// Returns the total count of navigation sidebar items specifically assigned to this role.
  int get totalSidebarItems => menuItems.length;

  /// Infers the primary Application Grouping (Corporate, Franchise, Clinical, Client, Support)
  /// based on the authorized routes assigned to this role.
  String get primaryAppGrouping {
    int franch = 0, clin = 0, client = 0, supp = 0;
    
    for (var screen in authorizedScreens) {
      final r = screen.routePath.toLowerCase();
      if (r.contains('corporate')) {
        // Intentionally ignored or handled
      }
      if (r.contains('franchise')) franch++;
      if (r.contains('clinical') || r.contains('clinic')) clin++;
      if (r.contains('client')) client++;
      if (r.contains('support')) supp++;
    }

    if (supp > 0) return 'Support App';
    if (client > 0) return 'Client App';
    if (clin > 0) return 'Clinical App';
    if (franch > 0) return 'Franchise App';
    return 'Corporate App'; // Default fallback
  }

  /// Returns the total unique sidebar items available across the entire primary application grouping.
  /// This matches the total metrics calculated for each app shell (e.g., Corporate=38, Franchise=15).
  int get totalAppSidebarItems {
    final appGroup = primaryAppGrouping;
    
    // We calculate unique screen titles to match the sidebar visualization items
    Set<String> uniqueItems = {};
    for (var screen in PlatformScreenRegistry.screens.values) {
      final r = screen.routePath.toLowerCase();
      bool belongsToApp = false;
      
      if (appGroup == 'Corporate App' && (r.contains('corporate') || r.contains('common'))) belongsToApp = true;
      else if (appGroup == 'Franchise App' && (r.contains('franchise') || r.contains('common'))) belongsToApp = true;
      else if (appGroup == 'Clinical App' && (r.contains('clinical') || r.contains('clinic') || r.contains('common'))) belongsToApp = true;
      else if (appGroup == 'Client App' && (r.contains('client') || r.contains('common'))) belongsToApp = true;
      else if (appGroup == 'Support App' && (r.contains('support') || r.contains('common'))) belongsToApp = true;
      
      if (belongsToApp) {
        uniqueItems.add(screen.title);
      }
    }
    return uniqueItems.length;
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
  String toString() => 'GovernanceRole($name, screens: ${authorizedScreens.length}, app: $primaryAppGrouping)';
}
