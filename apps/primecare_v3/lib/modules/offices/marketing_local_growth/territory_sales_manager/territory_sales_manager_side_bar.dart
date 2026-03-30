import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'territory_sales_manager_menu_config.dart';
import 'territory_sales_manager_routes.dart';

class TerritorySalesManagerSideBarWidget extends StatelessWidget {
  const TerritorySalesManagerSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: TerritorySalesManagerRoutes.dashboard,
      roleTitle: 'Territory Sales Manager',
      officeCode: 'Marketing and Local Growth',
      menus: getTerritorySalesManagerMenus(),
    );
  }
}
