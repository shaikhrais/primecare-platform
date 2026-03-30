import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import 'territory_sales_manager_side_bar.dart';
import 'territory_sales_manager_top_bar.dart';

class TerritorySalesManagerLayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const TerritorySalesManagerLayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const TerritorySalesManagerSideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const TerritorySalesManagerTopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
