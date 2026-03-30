import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'family_member_routes.dart';

List<SidebarMenuConfig> getFamilyMemberMenus() {
  return [
    SidebarMenuConfig(label: 'Dashboard', route: FamilyMemberRoutes.dashboard, icon: Icons.dashboard),
    SidebarMenuConfig(label: 'Clients', route: FamilyMemberRoutes.clients, icon: Icons.people),
    SidebarMenuConfig(label: 'Staff / Teams', route: FamilyMemberRoutes.staff, icon: Icons.badge),
    SidebarMenuConfig(label: 'Schedule', route: FamilyMemberRoutes.schedule, icon: Icons.calendar_today),
    SidebarMenuConfig(label: 'Reports', route: FamilyMemberRoutes.reports, icon: Icons.analytics),
    SidebarMenuConfig(label: 'Dynamic SDUI', route: FamilyMemberRoutes.dynamicForms, icon: Icons.dynamic_form),
    SidebarMenuConfig(label: 'Settings', route: FamilyMemberRoutes.settings, icon: Icons.settings),
  ];
}
