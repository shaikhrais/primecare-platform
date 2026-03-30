import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'operations_manager_routes.dart';

List<SidebarMenuConfig> getOperationsManagerMenus() {
  return [
    SidebarMenuConfig(label: 'Dashboard', route: OperationsManagerRoutes.dashboard, icon: Icons.dashboard),
    SidebarMenuConfig(label: 'Clients', route: OperationsManagerRoutes.clients, icon: Icons.people),
    SidebarMenuConfig(label: 'Staff / Teams', route: OperationsManagerRoutes.staff, icon: Icons.badge),
    SidebarMenuConfig(label: 'Schedule', route: OperationsManagerRoutes.schedule, icon: Icons.calendar_today),
    SidebarMenuConfig(label: 'Reports', route: OperationsManagerRoutes.reports, icon: Icons.analytics),
    SidebarMenuConfig(label: 'Dynamic SDUI', route: OperationsManagerRoutes.dynamicForms, icon: Icons.dynamic_form),
    SidebarMenuConfig(label: 'Settings', route: OperationsManagerRoutes.settings, icon: Icons.settings),
  ];
}
