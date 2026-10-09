/// Shared module metadata; this declaration grants no permissions.
abstract class BasePlatformModule<TIcon, TRole, TScreen> {
  String get moduleId;
  String get name;
  TIcon get icon;
  List<TRole> get allowedRoles;
  List<TScreen> get screens;
}
