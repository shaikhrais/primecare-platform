import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import 'founder_ceo_side_bar.dart';
import 'founder_ceo_top_bar.dart';

class FounderCeoLayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const FounderCeoLayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const FounderCeoSideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const FounderCeoTopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
