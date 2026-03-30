import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import 'intake_coordinator_side_bar.dart';
import 'intake_coordinator_top_bar.dart';

class IntakeCoordinatorLayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const IntakeCoordinatorLayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const IntakeCoordinatorSideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const IntakeCoordinatorTopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
