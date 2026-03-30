import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'care_coordinator_routes.dart';

List<SidebarMenuConfig> getCareCoordinatorMenus() {
  return [
    SidebarMenuConfig(label: 'Dashboard', route: CareCoordinatorRoutes.dashboard, icon: Icons.dashboard),
    SidebarMenuConfig(label: 'Clients', route: CareCoordinatorRoutes.clients, icon: Icons.people),
    SidebarMenuConfig(label: 'Staff / Teams', route: CareCoordinatorRoutes.staff, icon: Icons.badge),
    SidebarMenuConfig(label: 'Schedule', route: CareCoordinatorRoutes.schedule, icon: Icons.calendar_today),
    SidebarMenuConfig(label: 'Reports', route: CareCoordinatorRoutes.reports, icon: Icons.analytics),
    SidebarMenuConfig(label: 'Dynamic SDUI', route: CareCoordinatorRoutes.dynamicForms, icon: Icons.dynamic_form),
    SidebarMenuConfig(label: 'Settings', route: CareCoordinatorRoutes.settings, icon: Icons.settings),
  ];
}
