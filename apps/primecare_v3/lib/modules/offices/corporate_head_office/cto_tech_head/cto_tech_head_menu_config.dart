import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'cto_tech_head_routes.dart';

List<SidebarMenuConfig> getCtoTechHeadMenus() {
  return [
    SidebarMenuConfig(label: 'Dashboard', route: CtoTechHeadRoutes.dashboard, icon: Icons.dashboard),
    SidebarMenuConfig(label: 'Clients', route: CtoTechHeadRoutes.clients, icon: Icons.people),
    SidebarMenuConfig(label: 'Staff / Teams', route: CtoTechHeadRoutes.staff, icon: Icons.badge),
    SidebarMenuConfig(label: 'Schedule', route: CtoTechHeadRoutes.schedule, icon: Icons.calendar_today),
    SidebarMenuConfig(label: 'Reports', route: CtoTechHeadRoutes.reports, icon: Icons.analytics),
    SidebarMenuConfig(label: 'Dynamic SDUI', route: CtoTechHeadRoutes.dynamicForms, icon: Icons.dynamic_form),
    SidebarMenuConfig(label: 'Settings', route: CtoTechHeadRoutes.settings, icon: Icons.settings),
  ];
}
