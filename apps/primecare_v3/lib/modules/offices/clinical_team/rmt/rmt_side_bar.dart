import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'rmt_menu_config.dart';
import 'rmt_routes.dart';

class RmtSideBarWidget extends StatelessWidget {
  const RmtSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: RmtRoutes.dashboard,
      roleTitle: 'RMT',
      officeCode: 'Clinical Team',
      menus: getRmtMenus(),
    );
  }
}
