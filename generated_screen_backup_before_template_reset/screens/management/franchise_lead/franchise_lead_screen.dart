import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/franchise_lead_header_section.dart';
import 'sections/franchise_lead_content_summary_section.dart';
import 'sections/franchise_lead_primary_content_section.dart';
import 'sections/franchise_lead_action_bar_section.dart';

class FranchiseLeadScreen extends StatelessWidget {
  const FranchiseLeadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'franchise_lead',
      title: 'FranchiseLeadScreen',
      child: Column(
        children: const [
          const FranchiseLeadHeaderSection(),
          const FranchiseLeadContentSummarySection(),
          const FranchiseLeadPrimaryContentSection(),
          const FranchiseLeadActionBarSection(),
        ],
      ),
    );
  }
}
