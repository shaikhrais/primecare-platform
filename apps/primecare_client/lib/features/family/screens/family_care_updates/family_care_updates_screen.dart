import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/family_care_updates_header_section.dart';
import 'sections/family_care_updates_content_summary_section.dart';
import 'sections/family_care_updates_primary_content_section.dart';
import 'sections/family_care_updates_action_bar_section.dart';

class FamilyCareUpdatesScreen extends StatelessWidget {
  const FamilyCareUpdatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'family_care_updates',
      title: 'Family Care Updates',
      child: Column(
        children: const [
          const FamilyCareUpdatesHeaderSection(),
          const FamilyCareUpdatesContentSummarySection(),
          const FamilyCareUpdatesPrimaryContentSection(),
          const FamilyCareUpdatesActionBarSection(),
        ],
      ),
    );
  }
}
