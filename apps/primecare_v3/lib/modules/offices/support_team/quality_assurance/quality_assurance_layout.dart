import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import 'quality_assurance_side_bar.dart';
import 'quality_assurance_top_bar.dart';

class QualityAssuranceLayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const QualityAssuranceLayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const QualityAssuranceSideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const QualityAssuranceTopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
