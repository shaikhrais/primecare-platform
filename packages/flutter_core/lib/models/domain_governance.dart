// Governance - Category: model | Purpose: The root business entity. Controls global configurations, branding variables, and subscription limits. A logical coll...
import 'navigation_item.dart';
import 'package:flutter/material.dart';
import '../registry/platform_role.dart';
import '../registry/platform_screen_registry.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../routes/groups/common_routes.dart';
import 'screen.dart';

/// The root business entity. Controls global configurations, branding variables, and subscription limits.
abstract class PlatformTenant {
  String get tenantId;
  String get name;
  ThemeData get branding;
}

/// A logical collection of features. This is the primary unit of security.
abstract class PlatformModule {
  String get moduleId;
  String get name;
  IconData get icon;

  /// Only these roles are allowed to access the routes in this module.
  List<PlatformRole> get allowedRoles;

  /// The screens that belong to this module.
  List<PrimeCareScreen> get screens;
}

/// Defines the governance, navigation, and module access for a specific role.
/// This is the "Role Class" that centralizes what a user sees and can do.
class PlatformRoleDefinition {
  final PlatformRole role;
  final String label;
  final List<PlatformModule> modules;
  final String dashboardRoute;

  PlatformRoleDefinition({
    required this.role,
    String? label,
    required this.modules,
    required this.dashboardRoute,
  }) : label = label ?? role.displayName;

  /// Automatically generates navigation items based on the modules and screens.
  /// This ensures that "using all screens of a role" is the default behavior.
  List<PrimeCareNavigationItem> get navigationItems {
    final items = <PrimeCareNavigationItem>[];
    for (final module in modules) {
      for (final screen in module.screens) {
        // Skip screens with guest role unless guest is the active role
        if (screen.requiredRole == PlatformRole.guest && role != PlatformRole.guest) {
          continue;
        }
        
        items.add(
          PrimeCareNavigationItem(
            label: screen.title,
            icon: screen.icon ?? module.icon,
            route: screen.route,
          ),
        );
      }
    }
    return items;
  }
}


/// The specific portal being booted (e.g., Clinical, Governance, Corporate).
abstract class PlatformApplication {
  String get appId;
  String get name;
  PlatformTenant get tenant;

  /// Canonical list of role definitions for this application.
  List<PlatformRoleDefinition> get roleDefinitions;

  /// Returns the definition for a specific role.
  PlatformRoleDefinition? getDefinition(PlatformRole role) {
    final existing = roleDefinitions.where((d) => d.role == role).firstOrNull;
    if (existing != null) {
      return existing;
    }

    // Dynamic fallback for any role with authorized screens!
    final authorized = getAuthorizedModules(role);
    if (authorized.isEmpty) return null;

    // Resolve dashboard route
    String dbRoute = CommonRoutes.clinicalDashboard;
    final roleUpper = role.name.toUpperCase();
    for (final screen in PlatformScreenRegistry.screens.values) {
      if (screen.id.endsWith('_DASHBOARD') && screen.roles.contains(roleUpper)) {
        dbRoute = screen.routePath;
        break;
      }
    }

    return PlatformRoleDefinition(
      role: role,
      modules: authorized,
      dashboardRoute: dbRoute,
    );
  }

  /// Legacy support for raw modules list. Derived from role definitions.
  List<PlatformModule> get modules =>
      roleDefinitions.expand((d) => d.modules).toSet().toList();

  /// Returns the modules authorized for a given role based on role definitions.
  List<PlatformModule> getAuthorizedModules(PlatformRole role) {
    final definition = roleDefinitions.where((d) => d.role == role).firstOrNull;

    if (definition != null) {
      return definition.modules;
    }

    final legacyList = modules.where((m) => m.allowedRoles.contains(role)).toList();
    if (legacyList.isNotEmpty) {
      return legacyList;
    }

    // Dynamic fallback for any role with authorized screens!
    final roleNameUpper = role.name.toUpperCase();
    final matchingScreens = PlatformScreenRegistry.screens.values.where((screen) {
      return roleNameUpper == 'ADMIN' ||
             roleNameUpper == 'SUPERADMIN' ||
             roleNameUpper == 'CEO' ||
             screen.roles.contains(roleNameUpper) || 
             screen.roles.contains('ADMIN') || 
             screen.roles.contains('ALL');
    }).toList();

    if (matchingScreens.isEmpty) return [];

    final primeCareScreens = matchingScreens.map((s) {
      return PrimeCareScreen(
        title: s.title,
        route: s.routePath,
        requiredRole: role,
        icon: LucideIcons.circle,
      );
    }).toList();

    return [
      _DynamicPlatformModule(
        role: role,
        screens: primeCareScreens,
      )
    ];
  }
}

/// Canonical implementation of the PrimeCare Tenant.
class PrimeCareTenant extends PlatformTenant {
  @override
  String get tenantId => 'primecare_hq';

  @override
  String get name => 'PrimeCare';

  @override
  ThemeData get branding => ThemeData.light();
}

class _DynamicPlatformModule extends PlatformModule {
  final PlatformRole role;
  @override
  final List<PrimeCareScreen> screens;

  _DynamicPlatformModule({required this.role, required this.screens});

  @override
  String get moduleId => 'dynamic_${role.name}';

  @override
  String get name => '${role.displayName} Workspace';

  @override
  IconData get icon => LucideIcons.layoutDashboard;

  @override
  List<PlatformRole> get allowedRoles => [role];
}
