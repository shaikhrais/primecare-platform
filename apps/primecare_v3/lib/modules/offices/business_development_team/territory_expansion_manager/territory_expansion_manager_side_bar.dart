import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'territory_expansion_manager_menu_config.dart';
import 'territory_expansion_manager_routes.dart';

class TerritoryExpansionManagerSideBarWidget extends StatelessWidget {
  const TerritoryExpansionManagerSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: TerritoryExpansionManagerRoutes.dashboard,
      roleTitle: 'Territory Expansion Manager',
      officeCode: 'Business Development Team',
      menus: getTerritoryExpansionManagerMenus(),
    );
  }
}
