import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'it_administrator_menu_config.dart';
import 'it_administrator_routes.dart';

class ItAdministratorSideBarWidget extends StatelessWidget {
  const ItAdministratorSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: ItAdministratorRoutes.dashboard,
      roleTitle: 'IT Administrator',
      officeCode: 'Support Team',
      menus: getItAdministratorMenus(),
    );
  }
}
