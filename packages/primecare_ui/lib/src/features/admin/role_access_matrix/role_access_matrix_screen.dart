import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/role_access_matrix_header_section.dart';
import 'sections/role_access_matrix_content_summary_section.dart';
import 'sections/role_access_matrix_primary_content_section.dart';
import 'sections/role_access_matrix_action_bar_section.dart';

class RoleAccessMatrixScreen extends StatelessWidget {
  const RoleAccessMatrixScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'role_access_matrix',
      title: 'Role Access Matrix',
      child: Column(
        children: const [
          const RoleAccessMatrixHeaderSection(),
          const RoleAccessMatrixContentSummarySection(),
          const RoleAccessMatrixPrimaryContentSection(),
          const RoleAccessMatrixActionBarSection(),
        ],
      ),
    );
  }
}
