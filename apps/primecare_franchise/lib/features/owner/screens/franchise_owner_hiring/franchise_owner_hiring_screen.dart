import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/franchise_owner_hiring_header_section.dart';
import 'sections/franchise_owner_hiring_content_summary_section.dart';
import 'sections/franchise_owner_hiring_primary_content_section.dart';
import 'sections/franchise_owner_hiring_action_bar_section.dart';

class FranchiseOwnerHiringScreen extends StatelessWidget {
  const FranchiseOwnerHiringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'franchise_owner_hiring',
      title: 'Franchise Owner Hiring',
      child: Column(
        children: const [
          const FranchiseOwnerHiringHeaderSection(),
          const FranchiseOwnerHiringContentSummarySection(),
          const FranchiseOwnerHiringPrimaryContentSection(),
          const FranchiseOwnerHiringActionBarSection(),
        ],
      ),
    );
  }
}
