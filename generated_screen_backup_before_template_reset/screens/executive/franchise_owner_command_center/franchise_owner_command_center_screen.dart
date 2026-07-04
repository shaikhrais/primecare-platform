import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/franchise_owner_command_center_header_section.dart';
import 'sections/franchise_owner_command_center_content_summary_section.dart';
import 'sections/franchise_owner_command_center_primary_content_section.dart';
import 'sections/franchise_owner_command_center_action_bar_section.dart';

class FranchiseOwnerCommandCenterScreen extends StatelessWidget {
  const FranchiseOwnerCommandCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'franchise_owner_command_center',
      title: 'FranchiseOwnerCommandCenterScreen',
      child: Column(
        children: const [
          const FranchiseOwnerCommandCenterHeaderSection(),
          const FranchiseOwnerCommandCenterContentSummarySection(),
          const FranchiseOwnerCommandCenterPrimaryContentSection(),
          const FranchiseOwnerCommandCenterActionBarSection(),
        ],
      ),
    );
  }
}
