import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'billing_admin_routes.dart';

List<SidebarMenuConfig> getBillingAdminMenus() {
  return [
    SidebarMenuConfig(label: 'Dashboard', route: BillingAdminRoutes.dashboard, icon: Icons.dashboard),
    SidebarMenuConfig(label: 'Clients', route: BillingAdminRoutes.clients, icon: Icons.people),
    SidebarMenuConfig(label: 'Staff / Teams', route: BillingAdminRoutes.staff, icon: Icons.badge),
    SidebarMenuConfig(label: 'Schedule', route: BillingAdminRoutes.schedule, icon: Icons.calendar_today),
    SidebarMenuConfig(label: 'Reports', route: BillingAdminRoutes.reports, icon: Icons.analytics),
    SidebarMenuConfig(label: 'Dynamic SDUI', route: BillingAdminRoutes.dynamicForms, icon: Icons.dynamic_form),
    SidebarMenuConfig(label: 'Settings', route: BillingAdminRoutes.settings, icon: Icons.settings),
  ];
}
