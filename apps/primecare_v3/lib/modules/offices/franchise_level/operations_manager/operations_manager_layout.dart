import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import 'operations_manager_side_bar.dart';
import 'operations_manager_top_bar.dart';

class OperationsManagerLayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const OperationsManagerLayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const OperationsManagerSideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const OperationsManagerTopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
