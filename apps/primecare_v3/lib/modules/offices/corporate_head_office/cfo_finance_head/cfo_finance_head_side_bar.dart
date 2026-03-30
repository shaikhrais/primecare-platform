import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'cfo_finance_head_menu_config.dart';
import 'cfo_finance_head_routes.dart';

class CfoFinanceHeadSideBarWidget extends StatelessWidget {
  const CfoFinanceHeadSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: CfoFinanceHeadRoutes.dashboard,
      roleTitle: 'CFO (Finance Head)',
      officeCode: 'Corporate / Head Office',
      menus: getCfoFinanceHeadMenus(),
    );
  }
}
