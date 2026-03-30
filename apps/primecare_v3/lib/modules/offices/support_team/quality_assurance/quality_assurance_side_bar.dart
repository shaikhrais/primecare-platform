import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'quality_assurance_menu_config.dart';
import 'quality_assurance_routes.dart';

class QualityAssuranceSideBarWidget extends StatelessWidget {
  const QualityAssuranceSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: QualityAssuranceRoutes.dashboard,
      roleTitle: 'Quality Assurance',
      officeCode: 'Support Team',
      menus: getQualityAssuranceMenus(),
    );
  }
}
