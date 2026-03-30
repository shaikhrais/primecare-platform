import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'it_administrator_routes.dart';

List<SidebarMenuConfig> getItAdministratorMenus() {
  return [
    SidebarMenuConfig(label: 'Dashboard', route: ItAdministratorRoutes.dashboard, icon: Icons.dashboard),
    SidebarMenuConfig(label: 'Clients', route: ItAdministratorRoutes.clients, icon: Icons.people),
    SidebarMenuConfig(label: 'Staff / Teams', route: ItAdministratorRoutes.staff, icon: Icons.badge),
    SidebarMenuConfig(label: 'Schedule', route: ItAdministratorRoutes.schedule, icon: Icons.calendar_today),
    SidebarMenuConfig(label: 'Reports', route: ItAdministratorRoutes.reports, icon: Icons.analytics),
    SidebarMenuConfig(label: 'Dynamic SDUI', route: ItAdministratorRoutes.dynamicForms, icon: Icons.dynamic_form),
    SidebarMenuConfig(label: 'Settings', route: ItAdministratorRoutes.settings, icon: Icons.settings),
  ];
}
