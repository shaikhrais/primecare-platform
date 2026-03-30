import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'intake_coordinator_menu_config.dart';
import 'intake_coordinator_routes.dart';

class IntakeCoordinatorSideBarWidget extends StatelessWidget {
  const IntakeCoordinatorSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: IntakeCoordinatorRoutes.dashboard,
      roleTitle: 'Intake Coordinator',
      officeCode: 'Support Team',
      menus: getIntakeCoordinatorMenus(),
    );
  }
}
