import 'package:flutter/material.dart';

class ScreenMetadata {
  final String id;
  final String featureName;
  final String routePath;
  final List<String> allowedRoles;
  final String title;
  final IconData? icon;

  const ScreenMetadata({
    required this.id,
    required this.featureName,
    required this.routePath,
    required this.allowedRoles,
    required this.title,
    this.icon,
  });
}

class ScreenRegistry {
  static const String userList = 'USER_LIST';
  static const String userCreate = 'USER_CREATE';
  static const String userEdit = 'USER_EDIT';
  static const String dashboard = 'DASHBOARD';
  static const String governanceMgmt = 'GOVERNANCE_MGMT';
  static const String featureIntake = 'FEATURE_INTAKE';
  static const String systemHealth = 'SYSTEM_HEALTH';

  static final Map<String, ScreenMetadata> screens = {
    dashboard: const ScreenMetadata(
      id: dashboard,
      featureName: 'Core',
      routePath: '/',
      allowedRoles: ['admin', 'manager', 'user'],
      title: 'Dashboard',
      icon: Icons.dashboard,
    ),
    systemHealth: const ScreenMetadata(
      id: systemHealth,
      featureName: 'System',
      routePath: '/health',
      allowedRoles: ['admin', 'developer'],
      title: 'System Health',
      icon: Icons.analytics,
    ),
    userList: const ScreenMetadata(
      id: userList,
      featureName: 'User Management',
      routePath: '/users',
      allowedRoles: ['admin', 'manager'],
      title: 'User Management',
      icon: Icons.people,
    ),
    userCreate: const ScreenMetadata(
      id: userCreate,
      featureName: 'User Management',
      routePath: '/users/create',
      allowedRoles: ['admin'],
      title: 'Create User',
      icon: Icons.person_add,
    ),
    governanceMgmt: const ScreenMetadata(
      id: governanceMgmt,
      featureName: 'System',
      routePath: '/governance',
      allowedRoles: ['admin'],
      title: 'Governance Management',
      icon: Icons.settings_suggest,
    ),
    featureIntake: const ScreenMetadata(
      id: featureIntake,
      featureName: 'Core',
      routePath: '/intake',
      allowedRoles: ['admin', 'developer'],
      title: 'Feature Intake',
      icon: Icons.add_moderator,
    ),
  };

  static ScreenMetadata? getById(String id) => screens[id];
}
