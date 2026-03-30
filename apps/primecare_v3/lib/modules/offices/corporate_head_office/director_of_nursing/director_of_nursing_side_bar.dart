import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'director_of_nursing_menu_config.dart';
import 'director_of_nursing_routes.dart';

class DirectorOfNursingSideBarWidget extends StatelessWidget {
  const DirectorOfNursingSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: DirectorOfNursingRoutes.dashboard,
      roleTitle: 'Director of Nursing (DON)',
      officeCode: 'Corporate / Head Office',
      menus: getDirectorOfNursingMenus(),
    );
  }
}
