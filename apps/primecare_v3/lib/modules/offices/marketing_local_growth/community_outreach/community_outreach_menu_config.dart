import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'community_outreach_routes.dart';

List<SidebarMenuConfig> getCommunityOutreachMenus() {
  return [
    SidebarMenuConfig(label: 'Dashboard', route: CommunityOutreachRoutes.dashboard, icon: Icons.dashboard),
    SidebarMenuConfig(label: 'Clients', route: CommunityOutreachRoutes.clients, icon: Icons.people),
    SidebarMenuConfig(label: 'Staff / Teams', route: CommunityOutreachRoutes.staff, icon: Icons.badge),
    SidebarMenuConfig(label: 'Schedule', route: CommunityOutreachRoutes.schedule, icon: Icons.calendar_today),
    SidebarMenuConfig(label: 'Reports', route: CommunityOutreachRoutes.reports, icon: Icons.analytics),
    SidebarMenuConfig(label: 'Dynamic SDUI', route: CommunityOutreachRoutes.dynamicForms, icon: Icons.dynamic_form),
    SidebarMenuConfig(label: 'Settings', route: CommunityOutreachRoutes.settings, icon: Icons.settings),
  ];
}
