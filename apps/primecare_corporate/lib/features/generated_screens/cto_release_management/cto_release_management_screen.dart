import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cto_release_management_header_section.dart';
import 'sections/cto_release_management_content_summary_section.dart';
import 'sections/cto_release_management_primary_content_section.dart';
import 'sections/cto_release_management_action_bar_section.dart';

class CtoReleaseManagementScreen extends StatelessWidget {
  const CtoReleaseManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cto_release_management',
      title: 'Cto Release Management',
      child: Column(
        children: const [
          const CtoReleaseManagementHeaderSection(),
          const CtoReleaseManagementContentSummarySection(),
          const CtoReleaseManagementPrimaryContentSection(),
          const CtoReleaseManagementActionBarSection(),
        ],
      ),
    );
  }
}
