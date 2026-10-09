part of '../../../models/domain_governance.dart';

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
