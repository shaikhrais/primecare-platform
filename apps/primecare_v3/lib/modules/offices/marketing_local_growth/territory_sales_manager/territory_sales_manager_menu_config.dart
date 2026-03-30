import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'territory_sales_manager_routes.dart';

List<SidebarMenuConfig> getTerritorySalesManagerMenus() {
  return [
    SidebarMenuConfig(label: 'Dashboard', route: TerritorySalesManagerRoutes.dashboard, icon: Icons.dashboard),
    SidebarMenuConfig(label: 'Clients', route: TerritorySalesManagerRoutes.clients, icon: Icons.people),
    SidebarMenuConfig(label: 'Staff / Teams', route: TerritorySalesManagerRoutes.staff, icon: Icons.badge),
    SidebarMenuConfig(label: 'Schedule', route: TerritorySalesManagerRoutes.schedule, icon: Icons.calendar_today),
    SidebarMenuConfig(label: 'Reports', route: TerritorySalesManagerRoutes.reports, icon: Icons.analytics),
    SidebarMenuConfig(label: 'Dynamic SDUI', route: TerritorySalesManagerRoutes.dynamicForms, icon: Icons.dynamic_form),
    SidebarMenuConfig(label: 'Settings', route: TerritorySalesManagerRoutes.settings, icon: Icons.settings),
  ];
}
