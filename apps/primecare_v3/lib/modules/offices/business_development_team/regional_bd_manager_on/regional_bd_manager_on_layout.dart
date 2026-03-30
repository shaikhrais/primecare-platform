import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import 'regional_bd_manager_on_side_bar.dart';
import 'regional_bd_manager_on_top_bar.dart';

class RegionalBdManagerOnLayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const RegionalBdManagerOnLayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const RegionalBdManagerOnSideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const RegionalBdManagerOnTopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
