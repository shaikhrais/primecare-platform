import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import 'franchise_owner_side_bar.dart';
import 'franchise_owner_top_bar.dart';

class FranchiseOwnerLayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const FranchiseOwnerLayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const FranchiseOwnerSideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const FranchiseOwnerTopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
