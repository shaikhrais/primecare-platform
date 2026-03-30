import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'director_of_nursing_routes.dart';

List<SidebarMenuConfig> getDirectorOfNursingMenus() {
  return [
    SidebarMenuConfig(label: 'Dashboard', route: DirectorOfNursingRoutes.dashboard, icon: Icons.dashboard),
    SidebarMenuConfig(label: 'Clients', route: DirectorOfNursingRoutes.clients, icon: Icons.people),
    SidebarMenuConfig(label: 'Staff / Teams', route: DirectorOfNursingRoutes.staff, icon: Icons.badge),
    SidebarMenuConfig(label: 'Schedule', route: DirectorOfNursingRoutes.schedule, icon: Icons.calendar_today),
    SidebarMenuConfig(label: 'Reports', route: DirectorOfNursingRoutes.reports, icon: Icons.analytics),
    SidebarMenuConfig(label: 'Dynamic SDUI', route: DirectorOfNursingRoutes.dynamicForms, icon: Icons.dynamic_form),
    SidebarMenuConfig(label: 'Settings', route: DirectorOfNursingRoutes.settings, icon: Icons.settings),
  ];
}
