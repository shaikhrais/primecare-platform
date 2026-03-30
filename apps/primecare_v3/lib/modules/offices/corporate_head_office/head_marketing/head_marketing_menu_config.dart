import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'head_marketing_routes.dart';

List<SidebarMenuConfig> getHeadMarketingMenus() {
  return [
    SidebarMenuConfig(label: 'Dashboard', route: HeadMarketingRoutes.dashboard, icon: Icons.dashboard),
    SidebarMenuConfig(label: 'Clients', route: HeadMarketingRoutes.clients, icon: Icons.people),
    SidebarMenuConfig(label: 'Staff / Teams', route: HeadMarketingRoutes.staff, icon: Icons.badge),
    SidebarMenuConfig(label: 'Schedule', route: HeadMarketingRoutes.schedule, icon: Icons.calendar_today),
    SidebarMenuConfig(label: 'Reports', route: HeadMarketingRoutes.reports, icon: Icons.analytics),
    SidebarMenuConfig(label: 'Dynamic SDUI', route: HeadMarketingRoutes.dynamicForms, icon: Icons.dynamic_form),
    SidebarMenuConfig(label: 'Settings', route: HeadMarketingRoutes.settings, icon: Icons.settings),
  ];
}
