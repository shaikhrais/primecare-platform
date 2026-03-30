import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'client_routes.dart';

List<SidebarMenuConfig> getClientMenus() {
  return [
    SidebarMenuConfig(label: 'Dashboard', route: ClientRoutes.dashboard, icon: Icons.dashboard),
    SidebarMenuConfig(label: 'Clients', route: ClientRoutes.clients, icon: Icons.people),
    SidebarMenuConfig(label: 'Staff / Teams', route: ClientRoutes.staff, icon: Icons.badge),
    SidebarMenuConfig(label: 'Schedule', route: ClientRoutes.schedule, icon: Icons.calendar_today),
    SidebarMenuConfig(label: 'Reports', route: ClientRoutes.reports, icon: Icons.analytics),
    SidebarMenuConfig(label: 'Dynamic SDUI', route: ClientRoutes.dynamicForms, icon: Icons.dynamic_form),
    SidebarMenuConfig(label: 'Settings', route: ClientRoutes.settings, icon: Icons.settings),
  ];
}
