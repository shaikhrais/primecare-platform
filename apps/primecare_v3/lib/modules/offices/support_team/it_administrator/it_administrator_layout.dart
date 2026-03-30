import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import 'it_administrator_side_bar.dart';
import 'it_administrator_top_bar.dart';

class ItAdministratorLayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const ItAdministratorLayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const ItAdministratorSideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const ItAdministratorTopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
