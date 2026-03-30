import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'partnership_manager_routes.dart';

List<SidebarMenuConfig> getPartnershipManagerMenus() {
  return [
    SidebarMenuConfig(label: 'Dashboard', route: PartnershipManagerRoutes.dashboard, icon: Icons.dashboard),
    SidebarMenuConfig(label: 'Clients', route: PartnershipManagerRoutes.clients, icon: Icons.people),
    SidebarMenuConfig(label: 'Staff / Teams', route: PartnershipManagerRoutes.staff, icon: Icons.badge),
    SidebarMenuConfig(label: 'Schedule', route: PartnershipManagerRoutes.schedule, icon: Icons.calendar_today),
    SidebarMenuConfig(label: 'Reports', route: PartnershipManagerRoutes.reports, icon: Icons.analytics),
    SidebarMenuConfig(label: 'Dynamic SDUI', route: PartnershipManagerRoutes.dynamicForms, icon: Icons.dynamic_form),
    SidebarMenuConfig(label: 'Settings', route: PartnershipManagerRoutes.settings, icon: Icons.settings),
  ];
}
