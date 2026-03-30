import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'billing_specialist_routes.dart';

List<SidebarMenuConfig> getBillingSpecialistMenus() {
  return [
    SidebarMenuConfig(label: 'Dashboard', route: BillingSpecialistRoutes.dashboard, icon: Icons.dashboard),
    SidebarMenuConfig(label: 'Clients', route: BillingSpecialistRoutes.clients, icon: Icons.people),
    SidebarMenuConfig(label: 'Staff / Teams', route: BillingSpecialistRoutes.staff, icon: Icons.badge),
    SidebarMenuConfig(label: 'Schedule', route: BillingSpecialistRoutes.schedule, icon: Icons.calendar_today),
    SidebarMenuConfig(label: 'Reports', route: BillingSpecialistRoutes.reports, icon: Icons.analytics),
    SidebarMenuConfig(label: 'Dynamic SDUI', route: BillingSpecialistRoutes.dynamicForms, icon: Icons.dynamic_form),
    SidebarMenuConfig(label: 'Settings', route: BillingSpecialistRoutes.settings, icon: Icons.settings),
  ];
}
