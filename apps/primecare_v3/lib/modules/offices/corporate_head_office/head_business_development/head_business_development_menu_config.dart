import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'head_business_development_routes.dart';

List<SidebarMenuConfig> getHeadBusinessDevelopmentMenus() {
  return [
    SidebarMenuConfig(label: 'Dashboard', route: HeadBusinessDevelopmentRoutes.dashboard, icon: Icons.dashboard),
    SidebarMenuConfig(label: 'Clients', route: HeadBusinessDevelopmentRoutes.clients, icon: Icons.people),
    SidebarMenuConfig(label: 'Staff / Teams', route: HeadBusinessDevelopmentRoutes.staff, icon: Icons.badge),
    SidebarMenuConfig(label: 'Schedule', route: HeadBusinessDevelopmentRoutes.schedule, icon: Icons.calendar_today),
    SidebarMenuConfig(label: 'Reports', route: HeadBusinessDevelopmentRoutes.reports, icon: Icons.analytics),
    SidebarMenuConfig(label: 'Dynamic SDUI', route: HeadBusinessDevelopmentRoutes.dynamicForms, icon: Icons.dynamic_form),
    SidebarMenuConfig(label: 'Settings', route: HeadBusinessDevelopmentRoutes.settings, icon: Icons.settings),
  ];
}
