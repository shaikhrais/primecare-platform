import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/care_updates_header_section.dart';
import 'sections/care_updates_content_summary_section.dart';
import 'sections/care_updates_primary_content_section.dart';
import 'sections/care_updates_action_bar_section.dart';

class CareUpdatesScreen extends StatelessWidget {
  const CareUpdatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'care_updates',
      title: 'CareUpdatesScreen',
      child: Column(
        children: const [
          const CareUpdatesHeaderSection(),
          const CareUpdatesContentSummarySection(),
          const CareUpdatesPrimaryContentSection(),
          const CareUpdatesActionBarSection(),
        ],
      ),
    );
  }
}
