import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import 'family_member_side_bar.dart';
import 'family_member_top_bar.dart';

class FamilyMemberLayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const FamilyMemberLayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const FamilyMemberSideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const FamilyMemberTopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
