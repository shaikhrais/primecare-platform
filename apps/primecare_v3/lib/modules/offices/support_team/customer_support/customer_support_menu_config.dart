import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'customer_support_routes.dart';

List<SidebarMenuConfig> getCustomerSupportMenus() {
  return [
    SidebarMenuConfig(label: 'Dashboard', route: CustomerSupportRoutes.dashboard, icon: Icons.dashboard),
    SidebarMenuConfig(label: 'Clients', route: CustomerSupportRoutes.clients, icon: Icons.people),
    SidebarMenuConfig(label: 'Staff / Teams', route: CustomerSupportRoutes.staff, icon: Icons.badge),
    SidebarMenuConfig(label: 'Schedule', route: CustomerSupportRoutes.schedule, icon: Icons.calendar_today),
    SidebarMenuConfig(label: 'Reports', route: CustomerSupportRoutes.reports, icon: Icons.analytics),
    SidebarMenuConfig(label: 'Dynamic SDUI', route: CustomerSupportRoutes.dynamicForms, icon: Icons.dynamic_form),
    SidebarMenuConfig(label: 'Settings', route: CustomerSupportRoutes.settings, icon: Icons.settings),
  ];
}
