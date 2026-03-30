import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'founder_ceo_routes.dart';

List<SidebarMenuConfig> getFounderCeoMenus() {
  return [
    SidebarMenuConfig(label: 'Dashboard', route: FounderCeoRoutes.dashboard, icon: Icons.dashboard),
    SidebarMenuConfig(label: 'Clients', route: FounderCeoRoutes.clients, icon: Icons.people),
    SidebarMenuConfig(label: 'Staff / Teams', route: FounderCeoRoutes.staff, icon: Icons.badge),
    SidebarMenuConfig(label: 'Schedule', route: FounderCeoRoutes.schedule, icon: Icons.calendar_today),
    SidebarMenuConfig(label: 'Reports', route: FounderCeoRoutes.reports, icon: Icons.analytics),
    SidebarMenuConfig(label: 'Dynamic SDUI', route: FounderCeoRoutes.dynamicForms, icon: Icons.dynamic_form),
    SidebarMenuConfig(label: 'Settings', route: FounderCeoRoutes.settings, icon: Icons.settings),
  ];
}
