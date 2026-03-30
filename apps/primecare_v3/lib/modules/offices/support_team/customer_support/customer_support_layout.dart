import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import 'customer_support_side_bar.dart';
import 'customer_support_top_bar.dart';

class CustomerSupportLayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const CustomerSupportLayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const CustomerSupportSideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const CustomerSupportTopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
