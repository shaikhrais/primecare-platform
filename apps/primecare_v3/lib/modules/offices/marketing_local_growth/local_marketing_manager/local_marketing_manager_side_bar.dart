import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'local_marketing_manager_menu_config.dart';
import 'local_marketing_manager_routes.dart';

class LocalMarketingManagerSideBarWidget extends StatelessWidget {
  const LocalMarketingManagerSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: LocalMarketingManagerRoutes.dashboard,
      roleTitle: 'Local Marketing Manager',
      officeCode: 'Marketing and Local Growth',
      menus: getLocalMarketingManagerMenus(),
    );
  }
}
