import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import 'billing_admin_side_bar.dart';
import 'billing_admin_top_bar.dart';

class BillingAdminLayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const BillingAdminLayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const BillingAdminSideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const BillingAdminTopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
