import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/user_management_header_section.dart';
import 'sections/user_management_content_summary_section.dart';
import 'sections/user_management_primary_content_section.dart';
import 'sections/user_management_action_bar_section.dart';

class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'user_management',
      title: 'User Management',
      child: Column(
        children: const [
          const UserManagementHeaderSection(),
          const UserManagementContentSummarySection(),
          const UserManagementPrimaryContentSection(),
          const UserManagementActionBarSection(),
        ],
      ),
    );
  }
}
