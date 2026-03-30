import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'hr_hiring_menu_config.dart';
import 'hr_hiring_routes.dart';

class HrHiringSideBarWidget extends StatelessWidget {
  const HrHiringSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: HrHiringRoutes.dashboard,
      roleTitle: 'HR / Hiring',
      officeCode: 'Franchise Level (Hamilton)',
      menus: getHrHiringMenus(),
    );
  }
}
