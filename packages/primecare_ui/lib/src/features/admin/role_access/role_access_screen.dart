import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/role_access_header_section.dart';
import 'sections/role_access_content_summary_section.dart';
import 'sections/role_access_primary_content_section.dart';
import 'sections/role_access_action_bar_section.dart';

class RoleAccessScreen extends StatelessWidget {
  const RoleAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'role_access',
      title: 'Role Access',
      child: Column(
        children: const [
          const RoleAccessHeaderSection(),
          const RoleAccessContentSummarySection(),
          const RoleAccessPrimaryContentSection(),
          const RoleAccessActionBarSection(),
        ],
      ),
    );
  }
}
