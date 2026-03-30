import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import 'rmt_side_bar.dart';
import 'rmt_top_bar.dart';

class RmtLayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const RmtLayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const RmtSideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const RmtTopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
