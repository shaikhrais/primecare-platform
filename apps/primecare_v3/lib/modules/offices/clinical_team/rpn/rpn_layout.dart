import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import 'rpn_side_bar.dart';
import 'rpn_top_bar.dart';

class RpnLayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const RpnLayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const RpnSideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const RpnTopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
