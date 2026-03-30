import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import 'hr_hiring_side_bar.dart';
import 'hr_hiring_top_bar.dart';

class HrHiringLayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const HrHiringLayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const HrHiringSideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const HrHiringTopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
