import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'coo_operations_head_menu_config.dart';
import 'coo_operations_head_routes.dart';

class CooOperationsHeadSideBarWidget extends StatelessWidget {
  const CooOperationsHeadSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: CooOperationsHeadRoutes.dashboard,
      roleTitle: 'COO (Operations Head)',
      officeCode: 'Corporate / Head Office',
      menus: getCooOperationsHeadMenus(),
    );
  }
}
