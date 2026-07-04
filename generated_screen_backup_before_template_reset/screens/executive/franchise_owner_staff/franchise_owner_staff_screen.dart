import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/franchise_owner_staff_header_section.dart';
import 'sections/franchise_owner_staff_content_summary_section.dart';
import 'sections/franchise_owner_staff_primary_content_section.dart';
import 'sections/franchise_owner_staff_action_bar_section.dart';

class FranchiseOwnerStaffScreen extends StatelessWidget {
  const FranchiseOwnerStaffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'franchise_owner_staff',
      title: 'FranchiseOwnerStaffScreen',
      child: Column(
        children: const [
          const FranchiseOwnerStaffHeaderSection(),
          const FranchiseOwnerStaffContentSummarySection(),
          const FranchiseOwnerStaffPrimaryContentSection(),
          const FranchiseOwnerStaffActionBarSection(),
        ],
      ),
    );
  }
}
