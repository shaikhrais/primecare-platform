import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'regional_bd_manager_on_menu_config.dart';
import 'regional_bd_manager_on_routes.dart';

class RegionalBdManagerOnSideBarWidget extends StatelessWidget {
  const RegionalBdManagerOnSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: RegionalBdManagerOnRoutes.dashboard,
      roleTitle: 'Regional BD Manager (Ontario)',
      officeCode: 'Business Development Team',
      menus: getRegionalBdManagerOnMenus(),
    );
  }
}
