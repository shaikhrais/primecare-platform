import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'billing_admin_menu_config.dart';
import 'billing_admin_routes.dart';

class BillingAdminSideBarWidget extends StatelessWidget {
  const BillingAdminSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: BillingAdminRoutes.dashboard,
      roleTitle: 'Billing / Admin',
      officeCode: 'Franchise Level (Hamilton)',
      menus: getBillingAdminMenus(),
    );
  }
}
