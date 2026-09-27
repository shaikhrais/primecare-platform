import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/grant_funding_allocation_header_section.dart';
import 'sections/grant_funding_allocation_content_summary_section.dart';
import 'sections/grant_funding_allocation_primary_content_section.dart';
import 'sections/grant_funding_allocation_action_bar_section.dart';

class GrantFundingAllocationScreen extends StatelessWidget {
  const GrantFundingAllocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'grant_funding_allocation',
      title: 'Grant Funding Allocation',
      child: Column(
        children: const [
          const GrantFundingAllocationHeaderSection(),
          const GrantFundingAllocationContentSummarySection(),
          const GrantFundingAllocationPrimaryContentSection(),
          const GrantFundingAllocationActionBarSection(),
        ],
      ),
    );
  }
}
