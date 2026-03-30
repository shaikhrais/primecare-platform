import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'training_director_menu_config.dart';
import 'training_director_routes.dart';

class TrainingDirectorSideBarWidget extends StatelessWidget {
  const TrainingDirectorSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: TrainingDirectorRoutes.dashboard,
      roleTitle: 'Training Director',
      officeCode: 'Corporate / Head Office',
      menus: getTrainingDirectorMenus(),
    );
  }
}
