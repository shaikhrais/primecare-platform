import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'psw_menu_config.dart';
import 'psw_routes.dart';

class PswSideBarWidget extends StatelessWidget {
  const PswSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: PswRoutes.dashboard,
      roleTitle: 'PSW',
      officeCode: 'Clinical Team',
      menus: getPswMenus(),
    );
  }
}
