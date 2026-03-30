import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'coo_operations_head_routes.dart';

List<SidebarMenuConfig> getCooOperationsHeadMenus() {
  return [
    SidebarMenuConfig(label: 'Dashboard', route: CooOperationsHeadRoutes.dashboard, icon: Icons.dashboard),
    SidebarMenuConfig(label: 'Clients', route: CooOperationsHeadRoutes.clients, icon: Icons.people),
    SidebarMenuConfig(label: 'Staff / Teams', route: CooOperationsHeadRoutes.staff, icon: Icons.badge),
    SidebarMenuConfig(label: 'Schedule', route: CooOperationsHeadRoutes.schedule, icon: Icons.calendar_today),
    SidebarMenuConfig(label: 'Reports', route: CooOperationsHeadRoutes.reports, icon: Icons.analytics),
    SidebarMenuConfig(label: 'Dynamic SDUI', route: CooOperationsHeadRoutes.dynamicForms, icon: Icons.dynamic_form),
    SidebarMenuConfig(label: 'Settings', route: CooOperationsHeadRoutes.settings, icon: Icons.settings),
  ];
}
