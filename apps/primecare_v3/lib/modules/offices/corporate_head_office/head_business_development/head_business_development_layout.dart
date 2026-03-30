import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import 'head_business_development_side_bar.dart';
import 'head_business_development_top_bar.dart';

class HeadBusinessDevelopmentLayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const HeadBusinessDevelopmentLayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const HeadBusinessDevelopmentSideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const HeadBusinessDevelopmentTopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
