import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'partnership_manager_menu_config.dart';
import 'partnership_manager_routes.dart';

class PartnershipManagerSideBarWidget extends StatelessWidget {
  const PartnershipManagerSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: PartnershipManagerRoutes.dashboard,
      roleTitle: 'Partnership Manager',
      officeCode: 'Business Development Team',
      menus: getPartnershipManagerMenus(),
    );
  }
}
