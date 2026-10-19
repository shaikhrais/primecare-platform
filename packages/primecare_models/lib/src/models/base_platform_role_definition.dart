/// Existing role metadata shared without navigation or authorization behavior.
abstract class BasePlatformRoleDefinition<TRole, TModule> {
  final TRole role;
  final String label;
  final List<TModule> modules;
  final String dashboardRoute;

  BasePlatformRoleDefinition({required this.role, required this.label,
    required this.modules, required this.dashboardRoute});
}
