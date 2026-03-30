import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'local_marketing_manager_routes.dart';

List<SidebarMenuConfig> getLocalMarketingManagerMenus() {
  return [
    SidebarMenuConfig(label: 'Dashboard', route: LocalMarketingManagerRoutes.dashboard, icon: Icons.dashboard),
    SidebarMenuConfig(label: 'Clients', route: LocalMarketingManagerRoutes.clients, icon: Icons.people),
    SidebarMenuConfig(label: 'Staff / Teams', route: LocalMarketingManagerRoutes.staff, icon: Icons.badge),
    SidebarMenuConfig(label: 'Schedule', route: LocalMarketingManagerRoutes.schedule, icon: Icons.calendar_today),
    SidebarMenuConfig(label: 'Reports', route: LocalMarketingManagerRoutes.reports, icon: Icons.analytics),
    SidebarMenuConfig(label: 'Dynamic SDUI', route: LocalMarketingManagerRoutes.dynamicForms, icon: Icons.dynamic_form),
    SidebarMenuConfig(label: 'Settings', route: LocalMarketingManagerRoutes.settings, icon: Icons.settings),
  ];
}
