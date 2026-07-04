import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/franchise_command_center4_k_header_section.dart';
import 'sections/franchise_command_center4_k_content_summary_section.dart';
import 'sections/franchise_command_center4_k_primary_content_section.dart';
import 'sections/franchise_command_center4_k_action_bar_section.dart';

class FranchiseCommandCenter4KScreen extends StatelessWidget {
  const FranchiseCommandCenter4KScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'franchise_command_center4_k',
      title: 'FranchiseCommandCenter4KScreen',
      child: Column(
        children: const [
          const FranchiseCommandCenter4KHeaderSection(),
          const FranchiseCommandCenter4KContentSummarySection(),
          const FranchiseCommandCenter4KPrimaryContentSection(),
          const FranchiseCommandCenter4KActionBarSection(),
        ],
      ),
    );
  }
}
