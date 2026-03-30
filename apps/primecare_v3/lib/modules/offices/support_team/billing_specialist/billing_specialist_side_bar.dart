import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'billing_specialist_menu_config.dart';
import 'billing_specialist_routes.dart';

class BillingSpecialistSideBarWidget extends StatelessWidget {
  const BillingSpecialistSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: BillingSpecialistRoutes.dashboard,
      roleTitle: 'Billing Specialist',
      officeCode: 'Support Team',
      menus: getBillingSpecialistMenus(),
    );
  }
}
