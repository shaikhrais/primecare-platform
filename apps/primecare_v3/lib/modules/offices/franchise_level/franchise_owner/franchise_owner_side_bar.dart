import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'franchise_owner_menu_config.dart';
import 'franchise_owner_routes.dart';

class FranchiseOwnerSideBarWidget extends StatelessWidget {
  const FranchiseOwnerSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: FranchiseOwnerRoutes.dashboard,
      roleTitle: 'Franchise Owner',
      officeCode: 'Franchise Level (Hamilton)',
      menus: getFranchiseOwnerMenus(),
    );
  }
}
