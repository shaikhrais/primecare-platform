import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'rpn_menu_config.dart';
import 'rpn_routes.dart';

class RpnSideBarWidget extends StatelessWidget {
  const RpnSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: RpnRoutes.dashboard,
      roleTitle: 'RPN',
      officeCode: 'Clinical Team',
      menus: getRpnMenus(),
    );
  }
}
