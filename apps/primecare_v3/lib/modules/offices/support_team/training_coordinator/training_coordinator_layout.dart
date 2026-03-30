import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import 'training_coordinator_side_bar.dart';
import 'training_coordinator_top_bar.dart';

class TrainingCoordinatorLayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const TrainingCoordinatorLayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const TrainingCoordinatorSideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const TrainingCoordinatorTopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
