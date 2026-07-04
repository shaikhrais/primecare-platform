import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/family_member_care_updates_header_section.dart';
import 'sections/family_member_care_updates_content_summary_section.dart';
import 'sections/family_member_care_updates_primary_content_section.dart';
import 'sections/family_member_care_updates_action_bar_section.dart';

class FamilyMemberCareUpdatesScreen extends StatelessWidget {
  const FamilyMemberCareUpdatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'family_member_care_updates',
      title: 'Family Member Care Updates',
      child: Column(
        children: const [
          const FamilyMemberCareUpdatesHeaderSection(),
          const FamilyMemberCareUpdatesContentSummarySection(),
          const FamilyMemberCareUpdatesPrimaryContentSection(),
          const FamilyMemberCareUpdatesActionBarSection(),
        ],
      ),
    );
  }
}
