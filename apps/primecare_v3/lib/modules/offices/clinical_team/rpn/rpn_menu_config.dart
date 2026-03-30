import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'rpn_routes.dart';

List<SidebarMenuConfig> getRpnMenus() {
  return [
    SidebarMenuConfig(label: 'Dashboard', route: RpnRoutes.dashboard, icon: Icons.dashboard),
    SidebarMenuConfig(label: 'Clients', route: RpnRoutes.clients, icon: Icons.people),
    SidebarMenuConfig(label: 'Staff / Teams', route: RpnRoutes.staff, icon: Icons.badge),
    SidebarMenuConfig(label: 'Schedule', route: RpnRoutes.schedule, icon: Icons.calendar_today),
    SidebarMenuConfig(label: 'Reports', route: RpnRoutes.reports, icon: Icons.analytics),
    SidebarMenuConfig(label: 'Dynamic SDUI', route: RpnRoutes.dynamicForms, icon: Icons.dynamic_form),
    SidebarMenuConfig(label: 'Settings', route: RpnRoutes.settings, icon: Icons.settings),
  ];
}
