import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'founder_ceo_menu_config.dart';
import 'founder_ceo_routes.dart';

class FounderCeoSideBarWidget extends StatelessWidget {
  const FounderCeoSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: FounderCeoRoutes.dashboard,
      roleTitle: 'Founder / CEO',
      officeCode: 'Corporate / Head Office',
      menus: getFounderCeoMenus(),
    );
  }
}
