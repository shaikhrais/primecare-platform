import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'physiotherapist_menu_config.dart';
import 'physiotherapist_routes.dart';

class PhysiotherapistSideBarWidget extends StatelessWidget {
  const PhysiotherapistSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: PhysiotherapistRoutes.dashboard,
      roleTitle: 'Physiotherapist (PT)',
      officeCode: 'Clinical Team',
      menus: getPhysiotherapistMenus(),
    );
  }
}
