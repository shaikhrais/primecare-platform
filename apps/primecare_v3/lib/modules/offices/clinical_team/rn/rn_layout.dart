import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import 'rn_side_bar.dart';
import 'rn_top_bar.dart';

class RnLayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const RnLayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const RnSideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const RnTopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
