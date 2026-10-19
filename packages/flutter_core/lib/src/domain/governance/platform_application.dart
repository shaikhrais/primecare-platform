part of '../../../models/domain_governance.dart';

/// The specific portal being booted (e.g., Clinical, Governance, Corporate).
abstract class PlatformApplication extends BasePlatformApplication<PlatformTenant, PlatformRoleDefinition> {

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
