import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'franchise_owner_routes.dart';

List<SidebarMenuConfig> getFranchiseOwnerMenus() {
  return [
    SidebarMenuConfig(label: 'Dashboard', route: FranchiseOwnerRoutes.dashboard, icon: Icons.dashboard),
    SidebarMenuConfig(label: 'Clients', route: FranchiseOwnerRoutes.clients, icon: Icons.people),
    SidebarMenuConfig(label: 'Staff / Teams', route: FranchiseOwnerRoutes.staff, icon: Icons.badge),
    SidebarMenuConfig(label: 'Schedule', route: FranchiseOwnerRoutes.schedule, icon: Icons.calendar_today),
    SidebarMenuConfig(label: 'Reports', route: FranchiseOwnerRoutes.reports, icon: Icons.analytics),
    SidebarMenuConfig(label: 'Dynamic SDUI', route: FranchiseOwnerRoutes.dynamicForms, icon: Icons.dynamic_form),
    SidebarMenuConfig(label: 'Settings', route: FranchiseOwnerRoutes.settings, icon: Icons.settings),
  ];
}
