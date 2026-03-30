import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'scheduler_coordinator_menu_config.dart';
import 'scheduler_coordinator_routes.dart';

class SchedulerCoordinatorSideBarWidget extends StatelessWidget {
  const SchedulerCoordinatorSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: SchedulerCoordinatorRoutes.dashboard,
      roleTitle: 'Scheduler / Coordinator',
      officeCode: 'Franchise Level (Hamilton)',
      menus: getSchedulerCoordinatorMenus(),
    );
  }
}
