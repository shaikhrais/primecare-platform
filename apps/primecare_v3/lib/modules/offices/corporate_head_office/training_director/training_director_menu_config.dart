import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'training_director_routes.dart';

List<SidebarMenuConfig> getTrainingDirectorMenus() {
  return [
    SidebarMenuConfig(label: 'Dashboard', route: TrainingDirectorRoutes.dashboard, icon: Icons.dashboard),
    SidebarMenuConfig(label: 'Clients', route: TrainingDirectorRoutes.clients, icon: Icons.people),
    SidebarMenuConfig(label: 'Staff / Teams', route: TrainingDirectorRoutes.staff, icon: Icons.badge),
    SidebarMenuConfig(label: 'Schedule', route: TrainingDirectorRoutes.schedule, icon: Icons.calendar_today),
    SidebarMenuConfig(label: 'Reports', route: TrainingDirectorRoutes.reports, icon: Icons.analytics),
    SidebarMenuConfig(label: 'Dynamic SDUI', route: TrainingDirectorRoutes.dynamicForms, icon: Icons.dynamic_form),
    SidebarMenuConfig(label: 'Settings', route: TrainingDirectorRoutes.settings, icon: Icons.settings),
  ];
}
