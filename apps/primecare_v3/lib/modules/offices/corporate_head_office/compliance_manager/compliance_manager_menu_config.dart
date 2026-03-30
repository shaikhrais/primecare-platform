import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'compliance_manager_routes.dart';

List<SidebarMenuConfig> getComplianceManagerMenus() {
  return [
    SidebarMenuConfig(label: 'Dashboard', route: ComplianceManagerRoutes.dashboard, icon: Icons.dashboard),
    SidebarMenuConfig(label: 'Clients', route: ComplianceManagerRoutes.clients, icon: Icons.people),
    SidebarMenuConfig(label: 'Staff / Teams', route: ComplianceManagerRoutes.staff, icon: Icons.badge),
    SidebarMenuConfig(label: 'Schedule', route: ComplianceManagerRoutes.schedule, icon: Icons.calendar_today),
    SidebarMenuConfig(label: 'Reports', route: ComplianceManagerRoutes.reports, icon: Icons.analytics),
    SidebarMenuConfig(label: 'Dynamic SDUI', route: ComplianceManagerRoutes.dynamicForms, icon: Icons.dynamic_form),
    SidebarMenuConfig(label: 'Settings', route: ComplianceManagerRoutes.settings, icon: Icons.settings),
  ];
}
