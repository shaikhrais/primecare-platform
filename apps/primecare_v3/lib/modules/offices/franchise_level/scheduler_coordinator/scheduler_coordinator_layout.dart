import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import 'scheduler_coordinator_side_bar.dart';
import 'scheduler_coordinator_top_bar.dart';

class SchedulerCoordinatorLayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const SchedulerCoordinatorLayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const SchedulerCoordinatorSideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const SchedulerCoordinatorTopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
