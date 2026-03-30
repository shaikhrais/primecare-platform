import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'care_coordinator_menu_config.dart';
import 'care_coordinator_routes.dart';

class CareCoordinatorSideBarWidget extends StatelessWidget {
  const CareCoordinatorSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: CareCoordinatorRoutes.dashboard,
      roleTitle: 'Care Coordinator',
      officeCode: 'Clinical Team',
      menus: getCareCoordinatorMenus(),
    );
  }
}
