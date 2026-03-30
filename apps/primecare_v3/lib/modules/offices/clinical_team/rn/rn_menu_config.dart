import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'rn_routes.dart';

List<SidebarMenuConfig> getRnMenus() {
  return [
    SidebarMenuConfig(label: 'Dashboard', route: RnRoutes.dashboard, icon: Icons.dashboard),
    SidebarMenuConfig(label: 'Clients', route: RnRoutes.clients, icon: Icons.people),
    SidebarMenuConfig(label: 'Staff / Teams', route: RnRoutes.staff, icon: Icons.badge),
    SidebarMenuConfig(label: 'Schedule', route: RnRoutes.schedule, icon: Icons.calendar_today),
    SidebarMenuConfig(label: 'Reports', route: RnRoutes.reports, icon: Icons.analytics),
    SidebarMenuConfig(label: 'Dynamic SDUI', route: RnRoutes.dynamicForms, icon: Icons.dynamic_form),
    SidebarMenuConfig(label: 'Settings', route: RnRoutes.settings, icon: Icons.settings),
  ];
}
