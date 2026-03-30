import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import 'coo_operations_head_side_bar.dart';
import 'coo_operations_head_top_bar.dart';

class CooOperationsHeadLayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const CooOperationsHeadLayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const CooOperationsHeadSideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const CooOperationsHeadTopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
