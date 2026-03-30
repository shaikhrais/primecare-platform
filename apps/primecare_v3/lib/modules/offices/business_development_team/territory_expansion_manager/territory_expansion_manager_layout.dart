import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import 'territory_expansion_manager_side_bar.dart';
import 'territory_expansion_manager_top_bar.dart';

class TerritoryExpansionManagerLayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const TerritoryExpansionManagerLayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const TerritoryExpansionManagerSideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const TerritoryExpansionManagerTopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
