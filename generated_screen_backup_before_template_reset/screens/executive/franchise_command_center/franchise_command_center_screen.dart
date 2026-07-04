import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/franchise_command_center_header_section.dart';
import 'sections/franchise_command_center_content_summary_section.dart';
import 'sections/franchise_command_center_primary_content_section.dart';
import 'sections/franchise_command_center_action_bar_section.dart';

class FranchiseCommandCenterScreen extends StatelessWidget {
  const FranchiseCommandCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'franchise_command_center',
      title: 'FranchiseCommandCenterScreen',
      child: Column(
        children: const [
          const FranchiseCommandCenterHeaderSection(),
          const FranchiseCommandCenterContentSummarySection(),
          const FranchiseCommandCenterPrimaryContentSection(),
          const FranchiseCommandCenterActionBarSection(),
        ],
      ),
    );
  }
}
