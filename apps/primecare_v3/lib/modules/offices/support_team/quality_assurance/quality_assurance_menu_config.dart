import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'quality_assurance_routes.dart';

List<SidebarMenuConfig> getQualityAssuranceMenus() {
  return [
    SidebarMenuConfig(label: 'Dashboard', route: QualityAssuranceRoutes.dashboard, icon: Icons.dashboard),
    SidebarMenuConfig(label: 'Clients', route: QualityAssuranceRoutes.clients, icon: Icons.people),
    SidebarMenuConfig(label: 'Staff / Teams', route: QualityAssuranceRoutes.staff, icon: Icons.badge),
    SidebarMenuConfig(label: 'Schedule', route: QualityAssuranceRoutes.schedule, icon: Icons.calendar_today),
    SidebarMenuConfig(label: 'Reports', route: QualityAssuranceRoutes.reports, icon: Icons.analytics),
    SidebarMenuConfig(label: 'Dynamic SDUI', route: QualityAssuranceRoutes.dynamicForms, icon: Icons.dynamic_form),
    SidebarMenuConfig(label: 'Settings', route: QualityAssuranceRoutes.settings, icon: Icons.settings),
  ];
}
