import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'regional_bd_manager_on_routes.dart';

List<SidebarMenuConfig> getRegionalBdManagerOnMenus() {
  return [
    SidebarMenuConfig(label: 'Dashboard', route: RegionalBdManagerOnRoutes.dashboard, icon: Icons.dashboard),
    SidebarMenuConfig(label: 'Clients', route: RegionalBdManagerOnRoutes.clients, icon: Icons.people),
    SidebarMenuConfig(label: 'Staff / Teams', route: RegionalBdManagerOnRoutes.staff, icon: Icons.badge),
    SidebarMenuConfig(label: 'Schedule', route: RegionalBdManagerOnRoutes.schedule, icon: Icons.calendar_today),
    SidebarMenuConfig(label: 'Reports', route: RegionalBdManagerOnRoutes.reports, icon: Icons.analytics),
    SidebarMenuConfig(label: 'Dynamic SDUI', route: RegionalBdManagerOnRoutes.dynamicForms, icon: Icons.dynamic_form),
    SidebarMenuConfig(label: 'Settings', route: RegionalBdManagerOnRoutes.settings, icon: Icons.settings),
  ];
}
