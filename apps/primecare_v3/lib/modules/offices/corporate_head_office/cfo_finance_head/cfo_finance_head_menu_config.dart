import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'cfo_finance_head_routes.dart';

List<SidebarMenuConfig> getCfoFinanceHeadMenus() {
  return [
    SidebarMenuConfig(label: 'Dashboard', route: CfoFinanceHeadRoutes.dashboard, icon: Icons.dashboard),
    SidebarMenuConfig(label: 'Clients', route: CfoFinanceHeadRoutes.clients, icon: Icons.people),
    SidebarMenuConfig(label: 'Staff / Teams', route: CfoFinanceHeadRoutes.staff, icon: Icons.badge),
    SidebarMenuConfig(label: 'Schedule', route: CfoFinanceHeadRoutes.schedule, icon: Icons.calendar_today),
    SidebarMenuConfig(label: 'Reports', route: CfoFinanceHeadRoutes.reports, icon: Icons.analytics),
    SidebarMenuConfig(label: 'Dynamic SDUI', route: CfoFinanceHeadRoutes.dynamicForms, icon: Icons.dynamic_form),
    SidebarMenuConfig(label: 'Settings', route: CfoFinanceHeadRoutes.settings, icon: Icons.settings),
  ];
}
