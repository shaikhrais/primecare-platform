import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'community_outreach_menu_config.dart';
import 'community_outreach_routes.dart';

class CommunityOutreachSideBarWidget extends StatelessWidget {
  const CommunityOutreachSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: CommunityOutreachRoutes.dashboard,
      roleTitle: 'Community Outreach',
      officeCode: 'Marketing and Local Growth',
      menus: getCommunityOutreachMenus(),
    );
  }
}
