import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import 'client_side_bar.dart';
import 'client_top_bar.dart';

class ClientLayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const ClientLayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const ClientSideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const ClientTopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
