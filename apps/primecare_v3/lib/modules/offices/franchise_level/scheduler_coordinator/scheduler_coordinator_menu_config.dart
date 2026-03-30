import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'scheduler_coordinator_routes.dart';

List<SidebarMenuConfig> getSchedulerCoordinatorMenus() {
  return [
    SidebarMenuConfig(label: 'Dashboard', route: SchedulerCoordinatorRoutes.dashboard, icon: Icons.dashboard),
    SidebarMenuConfig(label: 'Clients', route: SchedulerCoordinatorRoutes.clients, icon: Icons.people),
    SidebarMenuConfig(label: 'Staff / Teams', route: SchedulerCoordinatorRoutes.staff, icon: Icons.badge),
    SidebarMenuConfig(label: 'Schedule', route: SchedulerCoordinatorRoutes.schedule, icon: Icons.calendar_today),
    SidebarMenuConfig(label: 'Reports', route: SchedulerCoordinatorRoutes.reports, icon: Icons.analytics),
    SidebarMenuConfig(label: 'Dynamic SDUI', route: SchedulerCoordinatorRoutes.dynamicForms, icon: Icons.dynamic_form),
    SidebarMenuConfig(label: 'Settings', route: SchedulerCoordinatorRoutes.settings, icon: Icons.settings),
  ];
}
