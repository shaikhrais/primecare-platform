import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'regional_bd_manager_usa_routes.dart';

List<SidebarMenuConfig> getRegionalBdManagerUsaMenus() {
  return [
    SidebarMenuConfig(label: 'Dashboard', route: RegionalBdManagerUsaRoutes.dashboard, icon: Icons.dashboard),
    SidebarMenuConfig(label: 'Clients', route: RegionalBdManagerUsaRoutes.clients, icon: Icons.people),
    SidebarMenuConfig(label: 'Staff / Teams', route: RegionalBdManagerUsaRoutes.staff, icon: Icons.badge),
    SidebarMenuConfig(label: 'Schedule', route: RegionalBdManagerUsaRoutes.schedule, icon: Icons.calendar_today),
    SidebarMenuConfig(label: 'Reports', route: RegionalBdManagerUsaRoutes.reports, icon: Icons.analytics),
    SidebarMenuConfig(label: 'Dynamic SDUI', route: RegionalBdManagerUsaRoutes.dynamicForms, icon: Icons.dynamic_form),
    SidebarMenuConfig(label: 'Settings', route: RegionalBdManagerUsaRoutes.settings, icon: Icons.settings),
  ];
}
