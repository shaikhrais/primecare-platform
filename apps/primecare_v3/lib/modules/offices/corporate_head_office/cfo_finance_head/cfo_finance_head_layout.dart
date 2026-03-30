import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import 'cfo_finance_head_side_bar.dart';
import 'cfo_finance_head_top_bar.dart';

class CfoFinanceHeadLayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const CfoFinanceHeadLayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const CfoFinanceHeadSideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const CfoFinanceHeadTopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
