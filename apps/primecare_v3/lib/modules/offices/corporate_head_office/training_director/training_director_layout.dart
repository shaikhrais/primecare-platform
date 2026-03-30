import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import 'training_director_side_bar.dart';
import 'training_director_top_bar.dart';

class TrainingDirectorLayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const TrainingDirectorLayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const TrainingDirectorSideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const TrainingDirectorTopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
