import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'franchise_sales_manager_menu_config.dart';
import 'franchise_sales_manager_routes.dart';

class FranchiseSalesManagerSideBarWidget extends StatelessWidget {
  const FranchiseSalesManagerSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: FranchiseSalesManagerRoutes.dashboard,
      roleTitle: 'Franchise Sales Manager',
      officeCode: 'Business Development Team',
      menus: getFranchiseSalesManagerMenus(),
    );
  }
}
