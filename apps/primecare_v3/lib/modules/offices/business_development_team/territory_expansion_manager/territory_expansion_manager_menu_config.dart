import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'territory_expansion_manager_routes.dart';

List<SidebarMenuConfig> getTerritoryExpansionManagerMenus() {
  return [
    SidebarMenuConfig(label: 'Dashboard', route: TerritoryExpansionManagerRoutes.dashboard, icon: Icons.dashboard),
    SidebarMenuConfig(label: 'Clients', route: TerritoryExpansionManagerRoutes.clients, icon: Icons.people),
    SidebarMenuConfig(label: 'Staff / Teams', route: TerritoryExpansionManagerRoutes.staff, icon: Icons.badge),
    SidebarMenuConfig(label: 'Schedule', route: TerritoryExpansionManagerRoutes.schedule, icon: Icons.calendar_today),
    SidebarMenuConfig(label: 'Reports', route: TerritoryExpansionManagerRoutes.reports, icon: Icons.analytics),
    SidebarMenuConfig(label: 'Dynamic SDUI', route: TerritoryExpansionManagerRoutes.dynamicForms, icon: Icons.dynamic_form),
    SidebarMenuConfig(label: 'Settings', route: TerritoryExpansionManagerRoutes.settings, icon: Icons.settings),
  ];
}
