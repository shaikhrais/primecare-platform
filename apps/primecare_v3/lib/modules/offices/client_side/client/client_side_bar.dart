import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';
import 'client_menu_config.dart';
import 'client_routes.dart';

class ClientSideBarWidget extends StatelessWidget {
  const ClientSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: ClientRoutes.dashboard,
      roleTitle: 'Client',
      officeCode: 'Client Side',
      menus: getClientMenus(),
    );
  }
}
