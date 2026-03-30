import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'franchise_sales_manager_routes.dart';

List<SidebarMenuConfig> getFranchiseSalesManagerMenus() {
  return [
    SidebarMenuConfig(label: 'Dashboard', route: FranchiseSalesManagerRoutes.dashboard, icon: Icons.dashboard),
    SidebarMenuConfig(label: 'Clients', route: FranchiseSalesManagerRoutes.clients, icon: Icons.people),
    SidebarMenuConfig(label: 'Staff / Teams', route: FranchiseSalesManagerRoutes.staff, icon: Icons.badge),
    SidebarMenuConfig(label: 'Schedule', route: FranchiseSalesManagerRoutes.schedule, icon: Icons.calendar_today),
    SidebarMenuConfig(label: 'Reports', route: FranchiseSalesManagerRoutes.reports, icon: Icons.analytics),
    SidebarMenuConfig(label: 'Dynamic SDUI', route: FranchiseSalesManagerRoutes.dynamicForms, icon: Icons.dynamic_form),
    SidebarMenuConfig(label: 'Settings', route: FranchiseSalesManagerRoutes.settings, icon: Icons.settings),
  ];
}
