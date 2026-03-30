import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'operations_manager_menu_config.dart';
import 'operations_manager_routes.dart';

class OperationsManagerSideBarWidget extends StatelessWidget {
  const OperationsManagerSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: OperationsManagerRoutes.dashboard,
      roleTitle: 'Operations Manager',
      officeCode: 'Franchise Level (Hamilton)',
      menus: getOperationsManagerMenus(),
    );
  }
}
