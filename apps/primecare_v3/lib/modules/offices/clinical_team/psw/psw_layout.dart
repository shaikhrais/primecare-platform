import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import 'psw_side_bar.dart';
import 'psw_top_bar.dart';

class PswLayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const PswLayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const PswSideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const PswTopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
