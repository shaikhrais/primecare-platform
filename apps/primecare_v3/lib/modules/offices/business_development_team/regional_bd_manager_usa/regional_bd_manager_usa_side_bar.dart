import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'regional_bd_manager_usa_menu_config.dart';
import 'regional_bd_manager_usa_routes.dart';

class RegionalBdManagerUsaSideBarWidget extends StatelessWidget {
  const RegionalBdManagerUsaSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: RegionalBdManagerUsaRoutes.dashboard,
      roleTitle: 'Regional BD Manager (USA)',
      officeCode: 'Business Development Team',
      menus: getRegionalBdManagerUsaMenus(),
    );
  }
}
