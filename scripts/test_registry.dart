import 'package:flutter_core/registry/platform_role.dart';
import 'package:flutter_core/registry/platform_screen_registry.dart';
import 'package:flutter_core/models/governance_role.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  print('Evaluating PSW role screens...');
  final role = PlatformRole.psw;
  final govRole = GovernanceRole(role);
  print('Role: ${govRole.name}');
  print('Authorized screens count: ${govRole.authorizedScreens.length}');
  
  for (var screen in govRole.authorizedScreens) {
    print('  - Screen: ${screen.id} (title: ${screen.title}, roles: ${screen.roles})');
  }

  print('Total sidebar items: ${govRole.totalSidebarItems}');
  print('App grouping: ${govRole.primaryAppGrouping}');
  print('Total app sidebar items: ${govRole.totalAppSidebarItems}');
}
