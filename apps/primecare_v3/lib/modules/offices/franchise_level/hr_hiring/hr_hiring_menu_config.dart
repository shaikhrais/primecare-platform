import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'hr_hiring_routes.dart';

List<SidebarMenuConfig> getHrHiringMenus() {
  return [
    SidebarMenuConfig(label: 'Dashboard', route: HrHiringRoutes.dashboard, icon: Icons.dashboard),
    SidebarMenuConfig(label: 'Clients', route: HrHiringRoutes.clients, icon: Icons.people),
    SidebarMenuConfig(label: 'Staff / Teams', route: HrHiringRoutes.staff, icon: Icons.badge),
    SidebarMenuConfig(label: 'Schedule', route: HrHiringRoutes.schedule, icon: Icons.calendar_today),
    SidebarMenuConfig(label: 'Reports', route: HrHiringRoutes.reports, icon: Icons.analytics),
    SidebarMenuConfig(label: 'Dynamic SDUI', route: HrHiringRoutes.dynamicForms, icon: Icons.dynamic_form),
    SidebarMenuConfig(label: 'Settings', route: HrHiringRoutes.settings, icon: Icons.settings),
  ];
}
