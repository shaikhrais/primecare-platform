import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import 'regional_bd_manager_usa_side_bar.dart';
import 'regional_bd_manager_usa_top_bar.dart';

class RegionalBdManagerUsaLayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const RegionalBdManagerUsaLayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const RegionalBdManagerUsaSideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const RegionalBdManagerUsaTopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
