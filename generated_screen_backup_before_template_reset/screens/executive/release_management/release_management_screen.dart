import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/release_management_header_section.dart';
import 'sections/release_management_content_summary_section.dart';
import 'sections/release_management_primary_content_section.dart';
import 'sections/release_management_action_bar_section.dart';

class ReleaseManagementScreen extends StatelessWidget {
  const ReleaseManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'release_management',
      title: 'ReleaseManagementScreen',
      child: Column(
        children: const [
          const ReleaseManagementHeaderSection(),
          const ReleaseManagementContentSummarySection(),
          const ReleaseManagementPrimaryContentSection(),
          const ReleaseManagementActionBarSection(),
        ],
      ),
    );
  }
}
