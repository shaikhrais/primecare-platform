import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/admin_user_management_header_section.dart';
import 'sections/admin_user_management_content_summary_section.dart';
import 'sections/admin_user_management_primary_content_section.dart';
import 'sections/admin_user_management_action_bar_section.dart';

class AdminUserManagementScreen extends StatelessWidget {
  const AdminUserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'admin_user_management',
      title: 'Admin User Management',
      child: Column(
        children: const [
          const AdminUserManagementHeaderSection(),
          const AdminUserManagementContentSummarySection(),
          const AdminUserManagementPrimaryContentSection(),
          const AdminUserManagementActionBarSection(),
        ],
      ),
    );
  }
}
