import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'psw_routes.dart';

List<SidebarMenuConfig> getPswMenus() {
  return [
    SidebarMenuConfig(label: 'Dashboard', route: PswRoutes.dashboard, icon: Icons.dashboard),
    SidebarMenuConfig(label: 'Clients', route: PswRoutes.clients, icon: Icons.people),
    SidebarMenuConfig(label: 'Staff / Teams', route: PswRoutes.staff, icon: Icons.badge),
    SidebarMenuConfig(label: 'Schedule', route: PswRoutes.schedule, icon: Icons.calendar_today),
    SidebarMenuConfig(label: 'Reports', route: PswRoutes.reports, icon: Icons.analytics),
    SidebarMenuConfig(label: 'Dynamic SDUI', route: PswRoutes.dynamicForms, icon: Icons.dynamic_form),
    SidebarMenuConfig(label: 'Settings', route: PswRoutes.settings, icon: Icons.settings),
  ];
}
