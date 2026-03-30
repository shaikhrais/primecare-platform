import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import 'director_of_nursing_side_bar.dart';
import 'director_of_nursing_top_bar.dart';

class DirectorOfNursingLayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const DirectorOfNursingLayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const DirectorOfNursingSideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const DirectorOfNursingTopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
