import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import 'compliance_manager_side_bar.dart';
import 'compliance_manager_top_bar.dart';

class ComplianceManagerLayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const ComplianceManagerLayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const ComplianceManagerSideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const ComplianceManagerTopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
