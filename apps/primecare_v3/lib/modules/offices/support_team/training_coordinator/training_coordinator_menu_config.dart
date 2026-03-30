import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'training_coordinator_routes.dart';

List<SidebarMenuConfig> getTrainingCoordinatorMenus() {
  return [
    SidebarMenuConfig(label: 'Dashboard', route: TrainingCoordinatorRoutes.dashboard, icon: Icons.dashboard),
    SidebarMenuConfig(label: 'Clients', route: TrainingCoordinatorRoutes.clients, icon: Icons.people),
    SidebarMenuConfig(label: 'Staff / Teams', route: TrainingCoordinatorRoutes.staff, icon: Icons.badge),
    SidebarMenuConfig(label: 'Schedule', route: TrainingCoordinatorRoutes.schedule, icon: Icons.calendar_today),
    SidebarMenuConfig(label: 'Reports', route: TrainingCoordinatorRoutes.reports, icon: Icons.analytics),
    SidebarMenuConfig(label: 'Dynamic SDUI', route: TrainingCoordinatorRoutes.dynamicForms, icon: Icons.dynamic_form),
    SidebarMenuConfig(label: 'Settings', route: TrainingCoordinatorRoutes.settings, icon: Icons.settings),
  ];
}
