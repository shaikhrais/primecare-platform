import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import 'franchise_sales_manager_side_bar.dart';
import 'franchise_sales_manager_top_bar.dart';

class FranchiseSalesManagerLayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const FranchiseSalesManagerLayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const FranchiseSalesManagerSideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const FranchiseSalesManagerTopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
