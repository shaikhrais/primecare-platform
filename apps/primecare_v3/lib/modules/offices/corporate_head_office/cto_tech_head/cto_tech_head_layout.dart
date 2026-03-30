import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import 'cto_tech_head_side_bar.dart';
import 'cto_tech_head_top_bar.dart';

class CtoTechHeadLayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const CtoTechHeadLayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const CtoTechHeadSideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const CtoTechHeadTopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
