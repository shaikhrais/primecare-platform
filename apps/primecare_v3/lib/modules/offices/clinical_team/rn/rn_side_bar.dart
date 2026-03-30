import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'rn_menu_config.dart';
import 'rn_routes.dart';

class RnSideBarWidget extends StatelessWidget {
  const RnSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: RnRoutes.dashboard,
      roleTitle: 'RN (Registered Nurse)',
      officeCode: 'Clinical Team',
      menus: getRnMenus(),
    );
  }
}
