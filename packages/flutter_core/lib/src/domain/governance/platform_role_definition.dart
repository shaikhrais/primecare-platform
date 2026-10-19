part of '../../../models/domain_governance.dart';

/// Defines the governance, navigation, and module access for a specific role.
/// This is the "Role Class" that centralizes what a user sees and can do.
class PlatformRoleDefinition extends BasePlatformRoleDefinition<PlatformRole, PlatformModule> {
  PlatformRoleDefinition({
    required PlatformRole role,
    String? label,
    required List<PlatformModule> modules,
    required String dashboardRoute,
  }) : super(role: role, label: label ?? role.displayName,
         modules: modules, dashboardRoute: dashboardRoute);

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
