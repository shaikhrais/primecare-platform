import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import 'head_marketing_side_bar.dart';
import 'head_marketing_top_bar.dart';

class HeadMarketingLayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const HeadMarketingLayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const HeadMarketingSideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const HeadMarketingTopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
