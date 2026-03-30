import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'training_coordinator_menu_config.dart';
import 'training_coordinator_routes.dart';

class TrainingCoordinatorSideBarWidget extends StatelessWidget {
  const TrainingCoordinatorSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: TrainingCoordinatorRoutes.dashboard,
      roleTitle: 'Training Coordinator',
      officeCode: 'Support Team',
      menus: getTrainingCoordinatorMenus(),
    );
  }
}
