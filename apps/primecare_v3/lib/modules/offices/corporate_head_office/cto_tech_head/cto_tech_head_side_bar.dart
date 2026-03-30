import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'cto_tech_head_menu_config.dart';
import 'cto_tech_head_routes.dart';

class CtoTechHeadSideBarWidget extends StatelessWidget {
  const CtoTechHeadSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: CtoTechHeadRoutes.dashboard,
      roleTitle: 'CTO (Tech Head)',
      officeCode: 'Corporate / Head Office',
      menus: getCtoTechHeadMenus(),
    );
  }
}
