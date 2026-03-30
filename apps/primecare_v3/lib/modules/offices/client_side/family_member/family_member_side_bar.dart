import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'family_member_menu_config.dart';
import 'family_member_routes.dart';

class FamilyMemberSideBarWidget extends StatelessWidget {
  const FamilyMemberSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: FamilyMemberRoutes.dashboard,
      roleTitle: 'Family Member',
      officeCode: 'Client Side',
      menus: getFamilyMemberMenus(),
    );
  }
}
