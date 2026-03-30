import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import 'billing_specialist_side_bar.dart';
import 'billing_specialist_top_bar.dart';

class BillingSpecialistLayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const BillingSpecialistLayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const BillingSpecialistSideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const BillingSpecialistTopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
