import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import 'physiotherapist_side_bar.dart';
import 'physiotherapist_top_bar.dart';

class PhysiotherapistLayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const PhysiotherapistLayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const PhysiotherapistSideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const PhysiotherapistTopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
