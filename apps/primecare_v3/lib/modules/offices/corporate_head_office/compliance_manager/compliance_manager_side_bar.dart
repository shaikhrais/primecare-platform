import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'compliance_manager_menu_config.dart';
import 'compliance_manager_routes.dart';

class ComplianceManagerSideBarWidget extends StatelessWidget {
  const ComplianceManagerSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: ComplianceManagerRoutes.dashboard,
      roleTitle: 'Compliance Manager',
      officeCode: 'Corporate / Head Office',
      menus: getComplianceManagerMenus(),
    );
  }
}
