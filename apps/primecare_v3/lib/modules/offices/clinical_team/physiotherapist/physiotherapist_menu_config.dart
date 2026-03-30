import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'physiotherapist_routes.dart';

List<SidebarMenuConfig> getPhysiotherapistMenus() {
  return [
    SidebarMenuConfig(label: 'Dashboard', route: PhysiotherapistRoutes.dashboard, icon: Icons.dashboard),
    SidebarMenuConfig(label: 'Clients', route: PhysiotherapistRoutes.clients, icon: Icons.people),
    SidebarMenuConfig(label: 'Staff / Teams', route: PhysiotherapistRoutes.staff, icon: Icons.badge),
    SidebarMenuConfig(label: 'Schedule', route: PhysiotherapistRoutes.schedule, icon: Icons.calendar_today),
    SidebarMenuConfig(label: 'Reports', route: PhysiotherapistRoutes.reports, icon: Icons.analytics),
    SidebarMenuConfig(label: 'Dynamic SDUI', route: PhysiotherapistRoutes.dynamicForms, icon: Icons.dynamic_form),
    SidebarMenuConfig(label: 'Settings', route: PhysiotherapistRoutes.settings, icon: Icons.settings),
  ];
}
