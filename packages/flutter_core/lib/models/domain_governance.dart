// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import '../registry/platform_role.dart';
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

/// The specific portal being booted (e.g., Clinical, Governance, Corporate).
abstract class PlatformApplication {
  String get appId;
  String get name;
  PlatformTenant get tenant;
  List<PlatformModule> get modules;

  /// Returns the modules authorized for a given role.
  List<PlatformModule> getAuthorizedModules(PlatformRole role) {
    return modules.where((m) => m.allowedRoles.contains(role)).toList();
  }
}
