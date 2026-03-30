import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'head_business_development_menu_config.dart';
import 'head_business_development_routes.dart';

class HeadBusinessDevelopmentSideBarWidget extends StatelessWidget {
  const HeadBusinessDevelopmentSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: HeadBusinessDevelopmentRoutes.dashboard,
      roleTitle: 'Head of Business Development',
      officeCode: 'Corporate / Head Office',
      menus: getHeadBusinessDevelopmentMenus(),
    );
  }
}
