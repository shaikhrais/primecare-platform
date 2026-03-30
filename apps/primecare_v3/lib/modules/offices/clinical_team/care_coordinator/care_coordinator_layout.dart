import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import 'care_coordinator_side_bar.dart';
import 'care_coordinator_top_bar.dart';

class CareCoordinatorLayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const CareCoordinatorLayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const CareCoordinatorSideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const CareCoordinatorTopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
