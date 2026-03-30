import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import 'partnership_manager_side_bar.dart';
import 'partnership_manager_top_bar.dart';

class PartnershipManagerLayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const PartnershipManagerLayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const PartnershipManagerSideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const PartnershipManagerTopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
