import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'rmt_routes.dart';

List<SidebarMenuConfig> getRmtMenus() {
  return [
    SidebarMenuConfig(label: 'Dashboard', route: RmtRoutes.dashboard, icon: Icons.dashboard),
    SidebarMenuConfig(label: 'Clients', route: RmtRoutes.clients, icon: Icons.people),
    SidebarMenuConfig(label: 'Staff / Teams', route: RmtRoutes.staff, icon: Icons.badge),
    SidebarMenuConfig(label: 'Schedule', route: RmtRoutes.schedule, icon: Icons.calendar_today),
    SidebarMenuConfig(label: 'Reports', route: RmtRoutes.reports, icon: Icons.analytics),
    SidebarMenuConfig(label: 'Dynamic SDUI', route: RmtRoutes.dynamicForms, icon: Icons.dynamic_form),
    SidebarMenuConfig(label: 'Settings', route: RmtRoutes.settings, icon: Icons.settings),
  ];
}
