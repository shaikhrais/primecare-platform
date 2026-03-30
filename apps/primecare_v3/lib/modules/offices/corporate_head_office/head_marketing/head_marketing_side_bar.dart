import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'head_marketing_menu_config.dart';
import 'head_marketing_routes.dart';

class HeadMarketingSideBarWidget extends StatelessWidget {
  const HeadMarketingSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: HeadMarketingRoutes.dashboard,
      roleTitle: 'Head of Marketing',
      officeCode: 'Corporate / Head Office',
      menus: getHeadMarketingMenus(),
    );
  }
}
