import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'intake_coordinator_routes.dart';

List<SidebarMenuConfig> getIntakeCoordinatorMenus() {
  return [
    SidebarMenuConfig(label: 'Dashboard', route: IntakeCoordinatorRoutes.dashboard, icon: Icons.dashboard),
    SidebarMenuConfig(label: 'Clients', route: IntakeCoordinatorRoutes.clients, icon: Icons.people),
    SidebarMenuConfig(label: 'Staff / Teams', route: IntakeCoordinatorRoutes.staff, icon: Icons.badge),
    SidebarMenuConfig(label: 'Schedule', route: IntakeCoordinatorRoutes.schedule, icon: Icons.calendar_today),
    SidebarMenuConfig(label: 'Reports', route: IntakeCoordinatorRoutes.reports, icon: Icons.analytics),
    SidebarMenuConfig(label: 'Dynamic SDUI', route: IntakeCoordinatorRoutes.dynamicForms, icon: Icons.dynamic_form),
    SidebarMenuConfig(label: 'Settings', route: IntakeCoordinatorRoutes.settings, icon: Icons.settings),
  ];
}
