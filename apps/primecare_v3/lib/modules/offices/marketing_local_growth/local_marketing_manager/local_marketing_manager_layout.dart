import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import 'local_marketing_manager_side_bar.dart';
import 'local_marketing_manager_top_bar.dart';

class LocalMarketingManagerLayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const LocalMarketingManagerLayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const LocalMarketingManagerSideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const LocalMarketingManagerTopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
