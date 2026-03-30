import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import 'community_outreach_side_bar.dart';
import 'community_outreach_top_bar.dart';

class CommunityOutreachLayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const CommunityOutreachLayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const CommunityOutreachSideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const CommunityOutreachTopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
