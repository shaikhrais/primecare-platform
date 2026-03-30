import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'customer_support_menu_config.dart';
import 'customer_support_routes.dart';

class CustomerSupportSideBarWidget extends StatelessWidget {
  const CustomerSupportSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: CustomerSupportRoutes.dashboard,
      roleTitle: 'Customer Support',
      officeCode: 'Support Team',
      menus: getCustomerSupportMenus(),
    );
  }
}
